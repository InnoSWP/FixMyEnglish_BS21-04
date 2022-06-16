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
      appBar: AppBar(
        title: Text('Mistakes Page'),
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
                      String filename = (snapshot.data as MistakeFile).name;
                      return TextButton(
                        onPressed: () {
                          print(index);
                          setState(() {
                            _currentFile = index;
                          });
                        },
                        child: Text('File 1'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(233, 241, 232, 1)),
                        ),
                      );
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
