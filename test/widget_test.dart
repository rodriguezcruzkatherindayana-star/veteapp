
import 'package:flutter_test/flutter_test.dart';
import 'package:veteapp/main.dart';

void main() {
  testWidgets('VeteApp inicia correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(const VeteApp());

    expect(find.text('Bienvenido a VeteApp'), findsOneWidget);
  });
}
