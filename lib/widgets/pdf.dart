import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import '../models/calcDetail.dart';

class PdfApi {
  final calcDetail calculationDetail;
  PdfApi(this.calculationDetail);

  static Future<File> generateTable(calcDetail calculationDetail) async {
    final pdf = Document();

    final headers = ['ITEM', 'DETAILS'];

    final data = [
      ['From',calculationDetail.locA],
      ['To',calculationDetail.locB],
      ['Estimated Distance',calculationDetail.estDist.toStringAsFixed(1)],
      // ['Cable Type',calculationDetail.cType],
      ['Cable Vd',calculationDetail.cVd],
      ['Cable Iz',calculationDetail.cIz],
      ['Calculated Vd',calculationDetail.calcVd.toStringAsFixed(2)],
      ['Calculated Vd Percantage',calculationDetail.calcVdPercent.toStringAsFixed(2)],
      ['Allowed Vd',calculationDetail.allowedVD],
      ['Cable Quantity',calculationDetail.cQty],
      ['Cable Price',calculationDetail.cPrice],
      ['Overall Cable Price',calculationDetail.overallPrice.toStringAsFixed(2)],
    ];
    
    pdf.addPage(Page(
      build: (context) => Table.fromTextArray(headers: headers, data: data),
    ));

    return saveDocument(name: 'Report.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    String name,
    Document pdf,
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
