import 'package:flutter/material.dart';

import 'file.dart';
import 'mistake.dart';

class MistakePage extends StatefulWidget {
  final List<Future<MistakeFile>> files;

  const MistakePage({Key? key, required this.files}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MistakePageState();
}

class _MistakePageState extends State<MistakePage> {
  int _currentFile = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            color: Colors.black,
            height: 500,
            width: 500,
            child: FutureBuilder(
              future: widget.files[_currentFile],
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const CircularProgressIndicator();
                }
                List<Mistake> data = (snapshot.data as MistakeFile).mistakes;
                if (data.isNotEmpty) {
                  return ListView(
                    padding: const EdgeInsets.all(8),
                    children: data
                        .map((mistake) =>
                            Text('${mistake.sentence} --- ${mistake.match}'))
                        .toList(),
                  );
                }
                return const Text('no mistakes');
              },
            ),
          ),
          Container(
            color: Colors.blueGrey,
            height: 500,
            width: 500,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: widget.files.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                    future: widget.files[index],
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }
                      String filename = (snapshot.data as MistakeFile).name;
                      return TextButton(
                          onPressed: () {
                            print(index);
                            setState(() {
                              _currentFile = index;
                            });
                          },
                          child: Text(filename));
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
