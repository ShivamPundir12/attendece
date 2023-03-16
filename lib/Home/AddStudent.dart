import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentAddPage extends StatefulWidget {
  const StudentAddPage({super.key});

  @override
  State<StudentAddPage> createState() => _StudentAddPageState();
}

class _StudentAddPageState extends State<StudentAddPage> {
  // Create TextEditingController objects to get values from TextFields
  TextEditingController name = TextEditingController();
  TextEditingController div = TextEditingController();
  TextEditingController rolln = TextEditingController();

  // Create CollectionReference object to access Firebase Firestore database
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  // Initialize some variables with default values
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a student'),
      ),
      body: Container(
        child: Column(
          children: [
            // TextField for entering student name
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: name,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  hintText: "Name Of Student",
                  labelText: "Name",
                ),
              ),
            ),

            // TextField for entering student roll number
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: rolln,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  hintText: "Roll Number Of Student",
                  labelText: "Roll number",
                ),
              ),
            ),

            // DropDownButtons for selecting class and division
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Class : '),
                    // DropdownButton for selecting class
                    ClassSelector(),
                  ],
                ),
                SizedBox(
                  width: 35,
                ),
                Row(
                  children: [
                    Text('Div : '),

                    // DropdownButton for selecting division
                    DivisionSelector(),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Button to add student Data
            AddButton(),
          ],
        ),
      ),
    );
  }

// Function of ClassSelector
  DropdownButton<String> ClassSelector() {
    return DropdownButton<String>(
      dropdownColor: Color.fromARGB(255, 0, 255, 21),
      isDense: true,
      isExpanded: false,
      iconEnabledColor: Color.fromARGB(255, 1, 1, 255),
      focusColor: Color.fromARGB(255, 0, 17, 251),
      items: options.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(
            dropDownStringItem,
            style: TextStyle(
              color: Color.fromARGB(255, 11, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        );
      }).toList(),

      // Update the selected class and division values when the user selects an option
      onChanged: (newValueSelected) {
        setState(() {
          _currentItemSelected = newValueSelected!;
          rool = newValueSelected;

          // Concatenate the class and division values to form the complete division value
          ww = '';
          ww = _currentItemSelected + _currentItemSelected1;
        });
        print(ww);
      },
      value: _currentItemSelected,
    );
  }

// This button add the Student Info To ReportPage
  MaterialButton AddButton() {
    return MaterialButton(
      color: Color.fromARGB(255, 2, 11, 128),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {
        ref.add({
          'name': name.text,
          'div': ww,
          'roll': rolln.text,
        }).whenComplete(
          () => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Student added to Attendence Section"),
              duration: Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
            ),
          ),
        );
      },
      child: Text(
        'ADD',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

// DropdownButton function for selecting division
  DropdownButton<String> DivisionSelector() {
    return DropdownButton<String>(
      dropdownColor: Color.fromARGB(255, 26, 255, 0),
      isDense: true,
      isExpanded: false,
      iconEnabledColor: Colors.blue[900],
      focusColor: Colors.blue[900],
      items: options1.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
          value: dropDownStringItem,
          child: Text(
            dropDownStringItem,
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
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
          ww = '';
          ww = _currentItemSelected + _currentItemSelected1;
        });
        print(ww);
      },
      value: _currentItemSelected1,
    );
  }
}
