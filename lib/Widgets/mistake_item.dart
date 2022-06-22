

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TextHeighlight.dart';

class MistakeItem extends StatelessWidget {
  final String sentence;
  final String match;
  final String description;

  MistakeItem(this.sentence, this.match, this.description);

  @override
  Widget build(BuildContext context) {
    //Converting match from string to List<String> to work with the widget
    List<String> matches = <String>[];
    matches.add(match);
    return InkWell(
      onTap: null,
      child: Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7,
        margin: EdgeInsets.all(10),
        child: Row(
          children: [
            buildDTH(sentence, matches, description),
            TextButton(
              onPressed: () {
                print('reported');
              },
              child: const Icon(Icons.report,
              color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}