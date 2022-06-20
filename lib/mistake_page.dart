import 'package:FixMyEnglish/file_download.dart';
import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

import 'file.dart';
import 'mistake.dart';

const String csvBase = 'match,sentence,label,description\n';

class MistakePage extends StatefulWidget {
  final List<Future<MistakeFile>> files;

  const MistakePage({Key? key, required this.files}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MistakePageState();
}

class _MistakePageState extends State<MistakePage> {
  int _currentFile = 0;
  List<Pair<String, String>> _filesStructure = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mistakes Page'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.grey,
            height: 500,
            width: 500,
            child: FutureBuilder(
              future: widget.files[_currentFile],
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const CircularProgressIndicator(
                    backgroundColor: Colors.red,
                    strokeWidth: 8,
                  );
                }
                String filename = (snapshot.data as MistakeFile).name;
                filename =
                    filename.substring(0, filename.characters.length - 4);
                List<Mistake> data = (snapshot.data as MistakeFile).mistakes;
                if (data.isNotEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 500,
                        height: 450,
                        child: ListView(
                          padding: const EdgeInsets.all(8),
                          children: data
                              .map(
                                (mistake) => Container(
                                  color: Colors.white70,
                                  child: Column(
                                    children: [
                                      Tooltip(
                                        message: mistake.description,
                                        child: SubstringHighlight(
                                          text: mistake.sentence,
                                          term: mistake.match,
                                          caseSensitive: true,
                                          textStyleHighlight: TextStyle(
                                            background: Paint()
                                              ..color = Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          print('reported');
                                        },
                                        child: const Icon(Icons.report),
                                      )
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              String fileStructure = csvBase;
                              for (int i = 0; i < data.length; i++) {
                                fileStructure +=
                                    '${data[i].match},${data[i].sentence},${data[i].label},${data[i].description}\n';
                              }
                              download(fileStructure,
                                  downloadName: '$filename.csv');
                            },
                            child: const Text('Export file as CSV'),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'No Mistakes',
                      style: TextStyle(),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            color: Colors.blueGrey,
            height: 500,
            width: 200,
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
                              return const CircularProgressIndicator(
                                backgroundColor: Colors.red,
                                strokeWidth: 8,
                              );
                            }
                            String filename =
                                (snapshot.data as MistakeFile).name;
                            filename = filename.substring(
                                0, filename.characters.length - 4);
                            List<Mistake> data =
                                (snapshot.data as MistakeFile).mistakes;
                            String fileStructure = csvBase;
                            for (int i = 0; i < data.length; i++) {
                              fileStructure +=
                                  '${data[i].match},${data[i].sentence},${data[i].label},${data[i].description}\n';
                            }
                            if (!_filesStructure
                                .contains(Pair(fileStructure, filename))) {
                              _filesStructure
                                  .add(Pair(fileStructure, filename));
                            }
                            return TextButton(
                              onPressed: () {
                                setState(() {
                                  _currentFile = index;
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromRGBO(233, 241, 232, 1)),
                              ),
                              child: Text(filename),
                            );
                          });
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_filesStructure.isNotEmpty) {
                        print(_filesStructure.length);
                        for (final file in _filesStructure) {
                          print(file.last);
                          download(file.first,
                              downloadName: '${file.last}.csv');
                        }
                      }
                    },
                    child: const Text('Export all files as CSV')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
