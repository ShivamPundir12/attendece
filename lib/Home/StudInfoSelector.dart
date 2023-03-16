import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ReportPage.dart';

class StudentInfoSelector extends StatefulWidget {
  @override
  State<StudentInfoSelector> createState() => _StudentInfoSelectorState();
}

class _StudentInfoSelectorState extends State<StudentInfoSelector> {
  var ww = '1A';
  var options = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];
  var _currentItemSelected = "1";
  var rool = "1";

  var options1 = [
    'A',
    'B',
  ];
  var _currentItemSelected1 = "A";
  var rool1 = "A";

  var temp = [];

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('users')
        .where(
          'div',
          isEqualTo: ww,
        )
        .snapshots();

    return SafeArea(
      child: Scaffold(
        // This FloatingActionButton sends the attendance report to the ReportPage
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigate to the ReportPage and pass the attendance list and class as arguments
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ReportPage(
                  list: temp,
                  clas: ww,
                ),
              ),
            ).whenComplete(
              () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Student is Added to Attendence Sheet"),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 4),
                ),
              ),
            );
          },
          child: Icon(
            Icons.send,
          ),
          tooltip: "Get Pdf",
        ),
        // The AppBar contains two DropdownButtons for selecting the class and section
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Attendance Page',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              // The first DropdownButton is for selecting the class
              ClassSelector(),
              SizedBox(
                width: 10,
              ),
              // The second DropdownButton is for selecting the section
              SectionSelector(),
              SizedBox(
                width: 25,
              ),
            ],
          ),
        ),
        // The body displays a list of students in the selected class and section
        body: StreamBuilder(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              // Display an error message if there is an error in the snapshot
              return Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Display a loading indicator while the snapshot is being fetched
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: StudentList(snapshot),
            );
          },
        ),
      ),
    );
  }

// Listview of added Student
  ListView StudentList(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (_, index) {
        // Creates an InkWell widget that calls a function when tapped
        return InkWell(
          onTap: () {
            // 1019
            // Updates the state of the widget by adding or removing an item from the temp list
            setState(() {
              if (temp.contains(snapshot.data!.docChanges[index].doc['name'])) {
                temp.remove(snapshot.data!.docChanges[index].doc['name']);
              } else {
                temp.add(snapshot.data!.docChanges[index].doc['name']);
              }
            });
            // Prints the temp list for debugging purposes
            print(temp);
            setState(() {});
          },
          child: StudentInfoCard(snapshot, index),
        );
      },
    );
  }

// Student information card
  Card StudentInfoCard(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int index) {
    return Card(
      child: ListTile(
        // Displays the name of the item at the given index
        title: Text(snapshot.data!.docChanges[index].doc['name']),
        trailing: Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
            // Sets the background color of the container based on whether the item is in the temp list or not
            color: temp.contains(snapshot.data!.docChanges[index].doc['name'])
                ? Color.fromARGB(255, 248, 20, 4)
                : Color.fromARGB(255, 0, 228, 8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              // Displays "add" if the item is not in the temp list, "Remove" if it is
              temp.contains(snapshot.data!.docChanges[index].doc['name'])
                  ? 'Remove'
                  : 'add',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

// funtion for selecting section of student
  DropdownButton<String> SectionSelector() {
    return DropdownButton<String>(
      dropdownColor: Colors.blue[900],
      isDense: true,
      isExpanded: false,
      iconEnabledColor: Colors.white,
      focusColor: Colors.white,
      items: options1.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(
            dropDownStringItem,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValueSelected1) {
        setState(() {
          _currentItemSelected1 = newValueSelected1!;
          rool1 = newValueSelected1;
          // Set the 'div' value to the selected class and section
          ww = '';
          ww = _currentItemSelected + _currentItemSelected1;
        });
        print(ww);
      },
      value: _currentItemSelected1,
    );
  }

// function for selecting class
  DropdownButton<String> ClassSelector() {
    return DropdownButton<String>(
      dropdownColor: Colors.blue[900],
      isDense: true,
      isExpanded: false,
      iconEnabledColor: Colors.white,
      focusColor: Colors.white,
      items: options.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(
            dropDownStringItem,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValueSelected) {
        setState(() {
          _currentItemSelected = newValueSelected!;
          rool = newValueSelected;
          // Set the 'div' value to the selected class and section
          ww = '';
          ww = _currentItemSelected + _currentItemSelected1;
        });
        print(ww);
      },
      value: _currentItemSelected,
    );
  }
}
