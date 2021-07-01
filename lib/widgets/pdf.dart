import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/calcDetail.dart';

class PdfApi {
  final calcDetail calculationDetail;
  PdfApi(this.calculationDetail);

  static Future<File> generateTable(calcDetail calculationDetail) async {
    var fontData =
        await rootBundle.load('asset/fonts/MPLUSRounded1c-Regular.ttf');
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    final pdf = pw.Document();

    final headers = ['ITEM', 'DETAILS'];

    final data = [
      ['From', calculationDetail.locA],
      ['To', calculationDetail.locB],
      ['Estimated Distance', calculationDetail.estDist.toStringAsFixed(1) + 'm'],
      ['Cable Type', calculationDetail.cType],
      ['Cable Vd', calculationDetail.cVd.toString() + 'mV'],
      ['Cable Iz', calculationDetail.cIz.toString() + 'A'],
      ['Calculated Vd', calculationDetail.calcVd.toStringAsFixed(2) + 'V' ],
      [
        'Calculated Vd Percantage',
        calculationDetail.calcVdPercent.toStringAsFixed(2) + '%'
      ],
      ['Allowed Vd', calculationDetail.allowedVD.toString() + '%'],
      ['Cable Quantity', calculationDetail.cQty],
      ['Cable Price', 'RM' + calculationDetail.cPrice.toString()],
      [
        'Overall Cable Price',
        'RM' + calculationDetail.overallPrice.toStringAsFixed(2)
      ],
    ];

    pdf.addPage(pw.Page(
      build: (context) => pw.Column(children: [
        pw.Text("CALCULATION DETAILS & RESULT OVERVIEW", style: pw.TextStyle(font: ttf,fontSize: 18)),
        pw.SizedBox(height: 15),
        pw.Table.fromTextArray(
            headers: headers, data: data, headerStyle: pw.TextStyle(font: ttf,fontSize: 14),cellStyle: pw.TextStyle(font: ttf, fontSize: 13))
      ]),
    ));

    return saveDocument(name: 'Report.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    String name,
    pw.Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
