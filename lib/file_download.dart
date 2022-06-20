import 'dart:convert';
import 'dart:html';

void download(
    String text, {
      String downloadName = 'report.csv',
    }) {
  final _base64 = base64Encode(text.codeUnits);
  final anchor =
  AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
    ..target = 'blank';
  anchor.download = downloadName;
  document.body!.append(anchor);
  anchor.click();
  anchor.remove();
}