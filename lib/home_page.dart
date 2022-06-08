import 'package:flutter/material.dart';

import 'Widgets/home_header.dart';
import 'file.dart';
import 'mistake_page.dart';
import 'mistake_api.dart';

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
                  onPressed: () {
                    // TODO: Implement
                  },
                  child: Text(
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
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(233, 241, 232, 1)),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  List<Future<MistakeFile>> files = [];
                  files.add(mistakeFromAPI(controller.text, 'unnamed'));
                  redirectToMistakePage(context, files);
                },
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
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(233, 241, 232, 1)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
