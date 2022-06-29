import 'dart:async';

import 'package:flutter/material.dart';

import 'file_download.dart';
import 'mistake_api.dart';
import 'Widgets/mistake_item.dart';
import 'file.dart';
import 'mistake.dart';

const String csvBase = 'match,sentence,label,description\n';
bool isVisible = true;
late List<Mistake> data;
late String filename;

class MistakePageText extends StatefulWidget {
  final Future<MistakeFile> file;
  final TextEditingController parentController;

  const MistakePageText(
      {Key? key, required this.file, required this.parentController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MistakePageTextState();
}

class _MistakePageTextState extends State<MistakePageText> {
  late TextEditingController _controller;
  late Future<MistakeFile> file;
  Color color = Colors.white;

  @override
  void initState() {
    _controller = widget.parentController;
    file = widget.file;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fix My English',
          style: TextStyle(
            fontFamily: 'Eczar',
            fontSize: 24,
          ),
        ),
      ),
      body:
          //TODO : Add ProgressBar
          /*
              Visibility(
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        visible: isVisible,
        child: LinearProgressIndicator(
          backgroundColor: Colors.cyanAccent,
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ),

       */
          Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: color,
            width: 700,
            padding: const EdgeInsets.only(top: 25),
            child: FutureBuilder(
              future: file,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Text(
                    'Loading',
                    style: TextStyle(
                      backgroundColor: Colors.white,
                    ),
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  hideProgressBar();
                });

                filename = (snapshot.data as MistakeFile).name;
                filename =
                    filename.substring(0, filename.characters.length - 4);
                List<Mistake> data = (snapshot.data as MistakeFile).mistakes;
                if (data.isNotEmpty) {
                  return ListView(
                    padding: const EdgeInsets.all(10),
                    children: data
                        .map(
                          (mistake) => MistakeItem(mistake),
                        )
                        .toList(),
                  );
                }

                return const Center(
                  child: Text('No Mistakes Found'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 12),
            child: Wrap(
              children: [
                Container(
                  width: 300,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 450,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: TextField(
                            controller: _controller,
                            minLines: 20,
                            maxLines: 20,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromRGBO(73, 69, 7, 1)),
                          ),
                          onPressed: () {
                            setState(() {
                              // ignore: null_argument_to_non_null_type
                              file = Future.value(null);
                              file =
                                  mistakeFromAPI(_controller.text, 'File.pdf');
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Analyze'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(73, 69, 7, 1)),
                            ),
                            onPressed: () {
                              String fileStructure = csvBase;
                              for (int i = 0; i < data.length; i++) {
                                fileStructure +=
                                    '${data[i].match},${data[i].sentence},${data[i].label},${data[i].description}\n';
                              }
                              download(fileStructure,
                                  downloadName: '$filename.csv');
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Export File'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void hideProgressBar() {
    setState(() {
      isVisible = false;
      color = const Color.fromRGBO(247, 250, 235, 1);
    });
  }
}
