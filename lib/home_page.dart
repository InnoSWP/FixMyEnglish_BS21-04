import 'package:flutter/material.dart';

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
                onPressed: () {
                  // to be done
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
