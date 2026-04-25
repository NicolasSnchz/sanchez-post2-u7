import 'package:flutter_test/flutter_test.dart';
import 'package:sanchez_post2_u7/main.dart';

void main() {
  testWidgets('GeoSense inicia correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(const GeoSenseApp());

    expect(find.text('GeoSense'), findsOneWidget);
    expect(find.text('Acelerómetro'), findsOneWidget);
  });
}