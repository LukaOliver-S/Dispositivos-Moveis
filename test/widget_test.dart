import 'package:flutter_test/flutter_test.dart';
import 'package:sensores/main.dart';

void main() {
  testWidgets('exibe o menu de sensores', (WidgetTester tester) async {
    await tester.pumpWidget(const SensoresApp());

    expect(find.text('Sensores em Flutter'), findsOneWidget);
    expect(find.text('Acelerômetro'), findsOneWidget);
    expect(find.text('GPS'), findsOneWidget);
  });
}
