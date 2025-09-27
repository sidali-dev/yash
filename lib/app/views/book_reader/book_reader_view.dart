import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:yash/app/controllers/book_reader/book_reader_controller.dart';

class BookReaderView extends GetView<BookReaderController> {
  final int initialPage;
  final Uint8List book;

  const BookReaderView({
    required this.initialPage,
    required this.book,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.memory(
        book,
        initialPageNumber: initialPage,
        controller: controller.pdfViewerController,
        pageSpacing: 0.0,
        pageLayoutMode: PdfPageLayoutMode.single,
        scrollDirection: PdfScrollDirection.horizontal,
        onPageChanged: (details) =>
            controller.updateLastReadPage(details.newPageNumber),
      ),
    );
  }
}
