import 'package:dynamic_text_highlighting/dynamic_text_highlighting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildDTH(String text, List<String> highlights, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
    child: Tooltip(
      message: description,
      child: SizedBox(
        width: 590,
        child: DynamicTextHighlighting(
          text: text,
          highlights: highlights,
          color: Color.fromRGBO(255, 0, 0, 0.5),
          style: TextStyle(
            fontSize: 18.0,
            fontStyle: FontStyle.italic,
          ),
          caseSensitive: false,
        ),
      ),
    ),
  );
}