import 'package:avora/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the AVORA foundation screen', (tester) async {
    await tester.pumpWidget(const AvoraApp());

    expect(find.text('AVORA'), findsOneWidget);
    expect(find.text('A quieter space for music.'), findsOneWidget);
  });
}
