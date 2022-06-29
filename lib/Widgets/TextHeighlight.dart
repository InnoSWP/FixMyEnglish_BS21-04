// ignore_for_file: file_names

// ignore: import_of_legacy_library_into_null_safe
import 'package:dynamic_text_highlighting/dynamic_text_highlighting.dart';
import 'package:flutter/material.dart';

Widget buildDTH(
    String text, List<String> highlights, String label, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
    child: Tooltip(
      message: label,
      child: SizedBox(
        width: 590,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DynamicTextHighlighting(
              text: text,
              highlights: highlights,
              color: const Color.fromRGBO(255, 0, 0, 0.5),
              style: const TextStyle(
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
              ),
              caseSensitive: false,
            ),
            Text('Mistake: $description'),
          ],
        ),
      ),
    ),
  );
}
