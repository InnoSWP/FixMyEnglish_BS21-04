import 'package:FixMyEnglish/file_download.dart';
import 'package:FixMyEnglish/mistake_api.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import 'Widgets/mistake_item.dart';
import 'file.dart';
import 'mistake.dart';

const String csvBase = 'match,sentence,label,description\n';
bool isVisible = true;
late List<Mistake> data;
late String filename;

class MistakePage extends StatefulWidget {
  final List<Future<MistakeFile>> files;

  const MistakePage({Key? key, required this.files}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MistakePageState();
}

class _MistakePageState extends State<MistakePage> {
  int _currentFile = 0;
  Color color = Colors.white;
  late List<Future<MistakeFile>> files;
  final List<Pair<String, String>> _filesStructure = [];

  @override
  void initState() {
    files = widget.files;
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
              future: files[_currentFile],
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
                        child: ListView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: files[index],
                                builder: (context, snapshot) {
                                  if (snapshot.data == null) {
                                    return const Text(
                                      '',
                                      style: TextStyle(
                                        backgroundColor: Colors.white,
                                      ),
                                    );
                                  }

                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    hideProgressBar();
                                  });

                                  String filename =
                                      (snapshot.data as MistakeFile).name;
                                  filename = filename.substring(
                                      0, filename.characters.length - 4);
                                  data =
                                      (snapshot.data as MistakeFile).mistakes;
                                  String fileStructure = csvBase;
                                  for (int i = 0; i < data.length; i++) {
                                    fileStructure +=
                                        '${data[i].match},${data[i].sentence},${data[i].label},${data[i].description}\n';
                                  }
                                  if (!_filesStructure.contains(
                                      Pair(fileStructure, filename))) {
                                    _filesStructure
                                        .add(Pair(fileStructure, filename));
                                  }
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Container(
                                      color: index == _currentFile
                                          ? const Color.fromARGB(
                                              56,
                                              141,
                                              180,
                                              246,
                                            )
                                          : const Color.fromRGBO(
                                              233,
                                              241,
                                              232,
                                              1,
                                            ),
                                      height: 30,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _currentFile = index;
                                              });
                                            },
                                            child: Text(
                                              filename,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              if (files.length == 1) {
                                                Navigator.of(context).pop();
                                              } else {
                                                setState(() {
                                                  files.removeAt(index);
                                                  _currentFile = 0;
                                                });
                                              }
                                            },
                                            icon: const Icon(Icons.delete),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(73, 69, 7, 1)),
                            ),
                            onPressed: () async {
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
                                  String text =
                                      PdfTextExtractor(document).extractText();
                                  files.add(mistakeFromAPI(text, file.name));
                                }
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Upload More'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
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
                              child: Text('Export Current File'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromRGBO(73, 69, 7, 1)),
                            ),
                            onPressed: () {
                              if (_filesStructure.isNotEmpty) {
                                for (final file in _filesStructure) {
                                  download(file.first,
                                      downloadName: '${file.last}.csv');
                                }
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Export All Files'),
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
