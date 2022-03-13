
import 'package:flutter/material.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:flutter_fight_club/pages/main_page.dart';
import 'package:flutter_fight_club/pages/statistics_page.dart';
import 'package:flutter_fight_club/widgets/secondary_action_button.dart';
import 'package:flutter_test/flutter_test.dart';

import 'lesson_3/task_1.dart';
import 'lesson_3/task_2.dart';
import 'lesson_3/task_3.dart';
import 'lesson_3/task_4.dart';
import 'shared/container_checks.dart';
import 'shared/test_helpers.dart';
import 'shared/text_checks.dart';

void main() {
  group("l04h01", () => runTestLesson3Task1());
  group("l04h02", () => runTestLesson3Task2());
   group("l04h03", () => runTestLesson3Task3());
   group("l04h04", () => runTestLesson3Task4());
}
void runTestLesson3Task1() {
  testWidgets('module1', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final containerFinder =
    findTypeByTextOnlyInParentType(Container, "Statistics".toUpperCase(), Column);
    expect(
      containerFinder,
      isNotNull,
      reason: "There are should be a Container with text 'STATISTICS' in Column",
    );

    final Container container = tester.widget<Container>(containerFinder);

    checkContainerEdgeInsetsProperties(
      container: container,
      margin: EdgeInsetsCheck(left: 16, right: 16),
    );
    checkContainerWidthOrHeightProperties(
      container: container,
      widthAndHeight: WidthAndHeight(width: null, height: 40),
      secondWidthAndHeight: WidthAndHeight(width: double.infinity, height: 40),
    );
    checkContainerBorder(
      container: container,
      border: Border.all(color: const Color(0xFF161616), width: 2),
    );
    expect(
      container.child,
      isInstanceOf<Text>(),
      reason: "Container should have child of Text type",
    );

    expect(
      (container.child as Text).data,
      "Statistics".toUpperCase(),
      reason: "Text should uppercased text",
    );

    checkTextProperties(
      textWidget: container.child as Text,
      textColor: const Color(0xFF161616),
    );
  });
}
void runTestLesson3Task2() {
  testWidgets('module2', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SecondaryActionButton(onTap: () {}, text: "Statistics"),
        ),
      ),
    );

    final containerFinder = findTypeByTextOnlyInParentType(
        Container, "Statistics".toUpperCase(), SecondaryActionButton);

    final Container container = tester.widget<Container>(containerFinder);

    checkContainerEdgeInsetsProperties(
      container: container,
      margin: EdgeInsetsCheck(left: 16, right: 16),
    );
    checkContainerWidthOrHeightProperties(
      container: container,
      widthAndHeight: WidthAndHeight(width: null, height: 40),
      secondWidthAndHeight: WidthAndHeight(width: double.infinity, height: 40),
    );
    checkContainerAlignment(
      container: container,
      alignment: Alignment.center,
    );
    checkContainerBorder(
      container: container,
      border: Border.all(color: const Color(0xFF161616), width: 2),
    );

    expect(
      container.child,
      isInstanceOf<Text>(),
      reason: "Container should have child of Text type",
    );

    expect(
      (container.child as Text).data,
      "Statistics".toUpperCase(),
      reason: "Text should uppercased text",
    );

    expect(
      (container.child as Text).style,
      isNotNull,
      reason: "Text should have not null style",
    );

    checkTextProperties(
      textWidget: container.child as Text,
      textColor: const Color(0xFF161616),
    );

    await tester.pumpWidget(MyApp());

    final secondaryActionButtonFinder =
    findTypeByTextOnlyInParentType(SecondaryActionButton, "Statistics".toUpperCase(), Column);
    expect(
      secondaryActionButtonFinder,
      findsOneWidget,
      reason: "There are should be a SecondaryActionButton\n"
          "with text 'STATISTICS' in a top-level Column",
    );

    final gestureDetectorFinder = findTypeByTextOnlyInParentType(
        GestureDetector, "Statistics".toUpperCase(), SecondaryActionButton);
    expect(
      gestureDetectorFinder,
      findsOneWidget,
      reason: "There are should be a GestureDetector inside SecondaryActionButton",
    );
  });
}
void runTestLesson3Task4() {
  testWidgets('module4', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final secondaryActionButtonFinder =
    findTypeByTextOnlyInParentType(SecondaryActionButton, "Statistics".toUpperCase(), Column);

    expect(
      find.byType(MainPage),
      findsOneWidget,
      reason: "First page should be MainPage",
    );

    expect(
      secondaryActionButtonFinder,
      findsOneWidget,
      reason: "There are should be a SecondaryActionButton with text 'Statistics' in Column",
    );

    await tester.tap(secondaryActionButtonFinder);
    await tester.pumpAndSettle();

    expect(
      find.byType(StatisticsPage),
      findsOneWidget,
      reason: "Statistics should be opened after tap on 'STATISTICS' button",
    );
    final columnFinder = findTypeByTextOnlyInParentType(Column, "Statistics", StatisticsPage);

    expect(
      columnFinder,
      findsOneWidget,
      reason: "There should be a Column widget",
    );

    final Column column = tester.widget(columnFinder);

    expect(
      column.children.first,
      isInstanceOf<Container>(),
      reason: "First widget in Column should be Container",
    );

    final containerWithTitle = column.children.first as Container;

    checkContainerEdgeInsetsProperties(
      container: containerWithTitle,
      paddingOrMargin: EdgeInsetsCheck(top: 24),
    );

    expect(
      containerWithTitle.child,
      isInstanceOf<Text>(),
      reason: "Container's child should be of Text type",
    );

    checkTextProperties(
      textWidget: containerWithTitle.child as Text,
      text: "Statistics",
      textColor: const Color(0xFF161616),
      fontSize: 24,
    );

    final Widget lastWidgetInColumn = column.children.last;
    expect(
      lastWidgetInColumn,
      isInstanceOf<Padding>(),
      reason: "Last widget in Column should have type of Padding",
    );
    expect(
      (lastWidgetInColumn as Padding).padding,
      isInstanceOf<EdgeInsets>(),
      reason: "Padding should have padding property type of EdgeInsets",
    );
    expect(
      (lastWidgetInColumn.padding as EdgeInsets).bottom,
      16,
      reason: "Padding should have bottom padding of 16",
    );
    expect(lastWidgetInColumn.child, isNotNull, reason: "Padding should have not null child");

    final Widget paddingChild = lastWidgetInColumn.child!;
    expect(
      paddingChild,
      isInstanceOf<SecondaryActionButton>(),
      reason: "Padding's child should have type of SecondaryActionButton",
    );
    final SecondaryActionButton secondaryActionButton = paddingChild as SecondaryActionButton;
    expect(
      secondaryActionButton.text,
      "Back",
      reason: "SecondaryActionButton should have text 'Back'",
    );

    await tester.tap(find.text("BACK"));
    await tester.pumpAndSettle();

    expect(
      find.byType(MainPage),
      findsOneWidget,
      reason: "After tapping on Back we should be return to the MainPage",
    );
  });
}
