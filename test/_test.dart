import 'package:FixMyEnglish/file.dart';
import 'package:FixMyEnglish/mistake.dart';
import 'package:FixMyEnglish/mistake_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});
  test(
    'unit tests',
    () {
      expect(
          mistakeFromAPI('aaa', 'a.pdf'),
          Future.value(MistakeFile(
            'a.pdf',
            [],
          )));

      expect(
          mistakeFromAPI("isn't", 'a.pdf'),
          Future.value(MistakeFile(
            'a.pdf',
            [
              Mistake(
                  match: "n't",
                  sentence: "isn't",
                  label: "SPOKN1",
                  description: "Using contractions")
            ],
          )));

      expect(
          mistakeFromAPI("isn't", 'a.pdf'),
          Future.value(MistakeFile(
            'a.pdf',
            [
              Mistake(
                  match: "n't",
                  sentence: "isn't",
                  label: "SPOKN1",
                  description: "Using contractions")
            ],
          )));

      expect(
          mistakeFromAPI("There are good", 'a.pdf'),
          Future.value(MistakeFile(
            'a.pdf',
            [
              Mistake(
                  match: "There are",
                  sentence: "There are good",
                  label: "SPOKN1",
                  description: "Using forms of there is/are"),
              Mistake(
                  match: "good",
                  sentence: "There are good",
                  label: "VOCAB5",
                  description: "using a forbidden words"),
            ],
          )));
    },
  );
}
