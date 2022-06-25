@TestOn('chrome')

import 'package:FixMyEnglish/home_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'abc',
    (WidgetTester tester) async {
      tester.pumpWidget(HomePage());
      expect(find.text("Fix My English"), findsOneWidget);
    },
  );
}
