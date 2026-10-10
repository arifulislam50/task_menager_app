// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:task_menager_app/main.dart';
import 'package:task_menager_app/provider/task_provider.dart';

void main() {
  testWidgets('A task can be added from the home screen', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(412, 915);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TaskProvider(),
        child: const TaskManagerApp(),
      ),
    );

    expect(find.text('No tasks yet!'), findsOneWidget);

    await tester.tap(find.text('Add Task').first);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Test task');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Test description',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Add Task'));
    await tester.pumpAndSettle();

    expect(find.text('Test task'), findsOneWidget);
    expect(find.text('Test description'), findsOneWidget);
  });
}
