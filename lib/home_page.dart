import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'file.dart';
import 'mistake_page.dart';
import 'mistake_api.dart';

Future<FilePickerResult?> mistakeFromPDF() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    type: FileType.custom,
    allowedExtensions: ['pdf'],
  );
  return result;
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = TextEditingController();

  void redirectToMistakePage(
      BuildContext context, List<Future<MistakeFile>> files) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MistakePage(files: files);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('fix my english'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: controller,
            minLines: 10,
            maxLines: 20,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  List<Future<MistakeFile>> files = [];
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    allowMultiple: true,
                    type: FileType.custom,
                    allowedExtensions: ['pdf'],
                  );
                  if (result != null) {
                    for (final file in result.files) {
                      final PdfDocument document =
                          PdfDocument(inputBytes: file.bytes);
                      String text = PdfTextExtractor(document).extractText();
                      files.add(mistakeFromAPI(text, file.name));
                    }
                    redirectToMistakePage(context, files);
                  }
                },
                child: const Text('Upload Files'),
              ),
              ElevatedButton(
                onPressed: () {
                  List<Future<MistakeFile>> files = [];
                  files.add(mistakeFromAPI(controller.text, 'unnamed'));
                  redirectToMistakePage(context, files);
                },
                child: const Text('Check'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
