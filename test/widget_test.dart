// ignore: import_of_legacy_library_into_null_safe
import 'package:FixMyEnglish/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    "title test",
    (WidgetTester tester) async {
      tester.pumpWidget(const MyApp());
      expect(find.text("Fix My English"), findsOneWidget);
    },
  );
}
