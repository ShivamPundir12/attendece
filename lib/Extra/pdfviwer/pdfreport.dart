// import 'dart:io';

// import 'package:attendece/Home/pdfviwer/pdfapi.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';

// class PdfInvoiceApi {
//   static Future<File> generate(Invoice invoice) async {
//     final pdf = Document();

//     pdf.addPage(MultiPage(
//       build: (context) => [
//         buildTitle(invoice),
//         buildInvoice(invoice)
//       ],
//     ));

//     return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
//   }


//   static Widget buildTitle(Invoice invoice) => Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'INVOICE',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 0.8 * PdfPageFormat.cm),
//           Text(invoice.info.description),
//           SizedBox(height: 0.8 * PdfPageFormat.cm),
//         ],
//       );

//   static Widget buildInvoice(Invoice invoice) {
//     final headers = [
//       'Description',
//       'Date',
//       'Quantity',
//       'Unit Price',
//       'VAT',
//       'Total'
//     ];
//     final data = invoice.items.map((item) {
    

//       return [
//         item.description,
//       ];
//     }).toList();

//     return Table.fromTextArray(
//       headers: headers,
//       data: data,
//       border: null,
//       headerStyle: TextStyle(fontWeight: FontWeight.bold),
//       headerDecoration: BoxDecoration(color: PdfColors.grey300),
//       cellHeight: 30,
//       cellAlignments: {
//         0: Alignment.centerLeft,
//         1: Alignment.centerRight,
//         2: Alignment.centerRight,
//         3: Alignment.centerRight,
//         4: Alignment.centerRight,
//         5: Alignment.centerRight,
//       },
//     );
//   }

//   static buildSimpleText({
//     required String title,
//     required String value,
//   }) {
//     final style = TextStyle(fontWeight: FontWeight.bold);

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: pw.CrossAxisAlignment.end,
//       children: [
//         Text(title, style: style),
//         SizedBox(width: 2 * PdfPageFormat.mm),
//         Text(value),
//       ],
//     );
//   }

//   static buildText({
//     required String title,
//     required String value,
//     double width = double.infinity,
//     TextStyle? titleStyle,
//     bool unite = false,
//   }) {
//     final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

//     return Container(
//       width: width,
//       child: Row(
//         children: [
//           Expanded(child: Text(title, style: style)),
//           Text(value, style: unite ? style : null),
//         ],
//       ),
//     );
//   }
// }