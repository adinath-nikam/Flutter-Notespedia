import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class pdfViewer extends StatefulWidget {
  @override
  _pdfViewerState createState() => _pdfViewerState();
}

class _pdfViewerState extends State<pdfViewer> {
  PDFDocument _doc;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _initPdf();
  }

  _initPdf() async {
    setState(() {
      _loading = true;
    });
    final doc = await PDFDocument.fromURL("http://www.pdf995.com/samples/pdf.pdf");
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          body: _loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : PDFViewer(
                  document: _doc,
                  indicatorBackground: Colors.red,
                  // showIndicator: false,
                  // showPicker: false,
                ),
        ),
      ),
    );
  }
}
