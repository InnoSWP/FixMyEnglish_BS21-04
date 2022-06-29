import 'package:FixMyEnglish/mistake.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'TextHeighlight.dart';

class MistakeItem extends StatelessWidget {
  final Mistake mistake;

  const MistakeItem(this.mistake, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Converting match from string to List<String> to work with the widget
    List<String> matches = <String>[];
    matches.add(mistake.match);
    return InkWell(
      onTap: null,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7,
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            buildDTH(
                mistake.sentence, matches, mistake.label, mistake.description),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      TextEditingController controller =
                          TextEditingController();
                      return AlertDialog(
                        title: const Text('Report?'),
                        content: SizedBox(
                          width: 500,
                          height: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildDTH(mistake.sentence, matches, mistake.label,
                                  mistake.description),
                              TextField(
                                controller: controller,
                                minLines: 1,
                                maxLines: 1,
                                decoration: InputDecoration(
                                  label: const Text('Reason'),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final database =
                                  FirebaseDatabase.instance.ref('reports');
                              database.push().set({
                                'match': mistake.match,
                                'sentence': mistake.sentence,
                                'label': mistake.label,
                                'description': mistake.description,
                                'reason': controller.text,
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('Report'),
                          ),
                        ],
                      );
                    });
              },
              child: const Icon(Icons.report, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
