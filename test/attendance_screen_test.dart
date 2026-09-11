import 'package:flutter/material.dart' show Key, Size;
import 'package:flutter_test/flutter_test.dart';
import 'package:semana3clase9/main.dart';

void main() {
  testWidgets(
    'actualiza, marca a todos y restablece la asistencia',
    (WidgetTester tester) async {
      await tester.pumpWidget(const AttendanceApp());

      expect(find.text('7/12 presentes'), findsOneWidget);
      expect(find.byKey(const Key('attendance-20260102')), findsOneWidget);

      await tester.tap(find.byKey(const Key('attendance-20260102')));
      await tester.pump();
      expect(find.text('8/12 presentes'), findsOneWidget);

      await tester.tap(find.byKey(const Key('mark-all-present')));
      await tester.pump();
      expect(find.text('12/12 presentes'), findsOneWidget);

      await tester.tap(find.byKey(const Key('restore-initial')));
      await tester.pump();
      expect(find.text('7/12 presentes'), findsOneWidget);
    },
  );

  testWidgets('no desborda a 360 píxeles de ancho', (WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(360, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const AttendanceApp());
    expect(tester.takeException(), isNull);
  });
}
