import 'dart:convert';

import 'package:http/http.dart' as http;

import 'main.dart';
import 'file.dart';
import 'mistake.dart';

Future<MistakeFile> mistakeFromAPI(String text, String filename) async {
  final response = await http.post(
    Uri.parse('$proxy$urlAPI'),
    headers: {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
    body: jsonEncode({
      "text": text,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return MistakeFile(
      filename,
      List<Mistake>.from(
          json.decode(response.body).map((x) => Mistake.fromJson(x))),
    );
  } else {
    return MistakeFile(filename, []);
  }
}
