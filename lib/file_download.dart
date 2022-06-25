import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

void download(
  String text, {
  String downloadName = 'report.csv',
}) {
  final base64 = base64Encode(text.codeUnits);
  final anchor =
      AnchorElement(href: 'data:application/octet-stream;base64,$base64')
        ..target = 'blank';
  anchor.download = downloadName;
  document.body!.append(anchor);
  anchor.click();
  anchor.remove();
}
