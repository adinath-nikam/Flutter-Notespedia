import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class pdfViewer extends StatefulWidget {
  var url;
  pdfViewer({this.url});
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
    final doc =
        await PDFDocument.fromURL(widget.url);
    setState(() {
      _doc = doc;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : PDFViewer(
                document: _doc,
                indicatorBackground: Colors.lightBlue,
                // showIndicator: false,
                // showPicker: false,
              ),
      ),
    );
  }
}
