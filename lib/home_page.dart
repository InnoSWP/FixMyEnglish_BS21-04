import 'package:FixMyEnglish/file_download.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'Widgets/home_header.dart';
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
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MistakePage(files: files)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fix My English'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HomeHeader(),
          Container(
            width: 720,
            height: 275,
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: TextField(
                controller: controller,
                minLines: 10,
                maxLines: 20,
                decoration: InputDecoration(
                  labelText: "Enter Text",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 250.0),
                child: ElevatedButton(
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(233, 241, 232, 1)),
                  ),
                  child: const Text(
                    'Upload PDF',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(73, 69, 7, 1),
                        fontFamily: 'Merriweather',
                        fontSize: 24,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1.5),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  List<Future<MistakeFile>> files = [];
                  files.add(mistakeFromAPI(controller.text, 'unnamed'));
                  redirectToMistakePage(context, files);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(233, 241, 232, 1)),
                ),
                child: const Text(
                  'Upload Text',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(73, 69, 7, 1),
                      fontFamily: 'Merriweather',
                      fontSize: 24,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1.5),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
