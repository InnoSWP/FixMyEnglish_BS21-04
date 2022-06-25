import 'package:FixMyEnglish/file_download.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';

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
  final List<Pair<String, String>> _filesStructure = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mistakes Page'),
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
              future: widget.files[_currentFile],
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Text(
                    '',
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
                    filename.substring(0, filename.characters.length /*- 4*/);
                List<Mistake> data = (snapshot.data as MistakeFile).mistakes;
                if (data.isNotEmpty) {
                  return ListView(
                    padding: const EdgeInsets.all(10),
                    children: data
                        .map(
                          (mistake) => MistakeItem(mistake.sentence,
                              mistake.match, mistake.description),
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
                          itemCount: widget.files.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                                future: widget.files[index],
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
                                      0, filename.characters.length /*- 4*/);
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
                                  return SizedBox(
                                    height: 30,
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _currentFile = index;
                                        });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color.fromRGBO(
                                                    233, 241, 232, 1)),
                                      ),
                                      child: Text(
                                        filename,
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                    ),
                                  );
                                });
                          },
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
