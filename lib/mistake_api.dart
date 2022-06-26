// import 'dart:convert';

// import 'package:http/http.dart' as http;

// ignore: import_of_legacy_library_into_null_safe
// import 'main.dart';
import 'file.dart';
// import 'mistake.dart';
import 'mistakes_demo_data.dart';

Future<MistakeFile> mistakeFromAPI(String text, String filename) async {
  //TODO : Remove when solving the API problem
  return MistakeFile(filename, mistakes);

  // final response = await http.post(
  //   Uri.parse(urlAPI),
  //   headers: {
  //     "accept": "application/json",
  //     "Content-Type": "application/json",
  //     "Access-Control-Allow-Origin": "*"
  //   },
  //   body: jsonEncode({
  //     "text": text,
  //   }),
  // );
  // print(response.body);

  // if (response.statusCode == 200) {
  //   return MistakeFile(
  //     filename,
  //     List<Mistake>.from(
  //         json.decode(response.body).map((x) => Mistake.fromJson(x))),
  //   );
  // } else {
  //   return MistakeFile(filename, [
  //     Mistake(match: "", sentence: "Server Error", label: "", description: "")
  //   ]);
  // }
}
