import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../../Model/quotation_model.dart';
import '../../../Util/Constant/app_colors.dart';
import '../../../Util/Constant/app_size.dart';

class DynamicTable extends StatelessWidget {
  final List<QuotationSub> data; // Dynamic Data
  final List<String> headers; // Table Headers
  final String total; // Total Amount Text

  const DynamicTable({
    super.key,
    required this.data,
    required this.headers,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      columnWidths: {
        0: const FlexColumnWidth(5), // Product column is larger
        for (int i = 1; i < headers.length; i++)
          i: i == 3 ? const FlexColumnWidth(2) : const FlexColumnWidth(1),
      },
      children: [
        // Header Row
        TableRow(
          decoration: BoxDecoration(color: Colors.grey[300]),
          children: headers
              .map(
                (header) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    header,
                    style: GoogleFonts.ptSans(
                      fontSize: Get.height / 50,
                      fontWeight: FontWeight.w700,
                      color: AppColors.color333,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
        ),
        // Data Rows
        ...data.map((row) {
          return TableRow(
            children: [
              _buildCell(
                  "${row.productCategory ?? ''}, ${row.productSubCategory ?? ''} Brand: ${row.quotationSubBrand ?? ''} Size: ${row.quotationSubSize1 ?? ''} X ${row.quotationSubSize2 ?? ''} ${row.quotationSubSizeUnit ?? ''}",
                  context: context),
              _buildCell(row.quotationSubQuantity?.toString() ?? "",
                  context: context),
              _buildCell(row.quotationSubRate?.toString() ?? "",
                  context: context),
              _buildCell(row.quotationSubAmount?.toString() ?? "",
                  context: context),
            ],
          );
        }),
        // Total Row
        TableRow(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                "Total :",
                style: GoogleFonts.ptSans(
                  fontSize: Get.height / 55,
                  fontWeight: FontWeight.w700,
                  color: AppColors.color333,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // First Cell: No Border
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text(""),
            ),
            // Second Cell: No Border
            Container(
              alignment: Alignment.center,
              child: const Text(""),
            ),
            // Third Cell: Retains Border

            // Fourth Cell: Retains Border
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: Text(
                total,
                style: GoogleFonts.ptSans(
                  fontSize: Get.height / 55,
                  fontWeight: FontWeight.w700,
                  color: AppColors.color333,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCell(String? text, {required BuildContext context}) {
    return Container(
      height: AppSize.displayHeight(context) * 0.08,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text ?? "",
        style: GoogleFonts.ptSans(
          fontSize: Get.height / 70,
          fontWeight: FontWeight.w400,
          color: AppColors.color333,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

Future<void> generateAndSharePDF(BuildContext context, List<QuotationSub> datas,
    List<String> headers, String total) async {
  final pdf = pw.Document();

  // Add a page with the image and table
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Image in PDF
            pw.SizedBox(height: 10),
            // Table
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black),
              columnWidths: {
                0: const pw.FlexColumnWidth(4),
                for (int i = 1; i < headers.length; i++)
                  i: i == 3
                      ? const pw.FlexColumnWidth(2)
                      : const pw.FlexColumnWidth(1.5),
              },
              children: [
                pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.grey300),
                  children: headers.map((header) {
                    return pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                      child: pw.Text(
                        header,
                        style: pw.TextStyle(
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.black,
                        ),
                        textAlign: pw.TextAlign.center,
                      ),
                    );
                  }).toList(),
                ),
                // Data Rows
                ...datas.map((row) {
                  return pw.TableRow(
                    children: [
                      _buildPdfCell(
                          "${row.productCategory ?? ''}, ${row.productSubCategory ?? ''}\nBrand: ${row.quotationSubBrand ?? ''}\nSize: ${row.quotationSubSize1 ?? ''} X ${row.quotationSubSize2 ?? ''} ${row.quotationSubSizeUnit ?? ''}"),
                      _buildPdfCell(row.quotationSubQuantity?.toString() ?? ""),
                      _buildPdfCell(row.quotationSubRate?.toString() ?? ""),
                      _buildPdfCell(row.quotationSubAmount?.toString() ?? ""),
                    ],
                  );
                }),
                // Total Row
                pw.TableRow(
                  children: [
                    _buildPdfCell("Total :",
                        isBold: true, textAlign: pw.TextAlign.center),
                    _buildPdfCell(""),
                    _buildPdfCell(""),
                    _buildPdfCell(total,
                        isBold: true, textAlign: pw.TextAlign.center),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
  try {
    // Save the PDF to a file
    final output = await getApplicationDocumentsDirectory();
    final filePath = "${output.path}/quotation_table.pdf";
    final pdfFile = File(filePath);
    var path = await pdfFile.writeAsBytes(await pdf.save());

    // Share the PDF file using Share plugin
    await Share.shareXFiles(
      [XFile(path.path)], // Share the saved PDF file
      text: 'Check out this quotation!', // Optional message
    ).then((value) {
      if (value.status != ShareResultStatus.success) {
        path.delete();
      }
    });
  } catch (e) {}
}

// Helper method to build PDF cells
pw.Widget _buildPdfCell(String text,
    {bool isBold = false, pw.TextAlign textAlign = pw.TextAlign.left}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: 10,
        fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
        color: PdfColors.black,
      ),
      textAlign: textAlign,
    ),
  );
}
