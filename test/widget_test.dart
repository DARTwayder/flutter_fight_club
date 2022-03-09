import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_fight_club/main.dart';
import 'package:collection/collection.dart';
import 'package:crypto/crypto.dart';

import 'lesson_2/task_1.dart';
import 'lesson_2/task_2.dart';
import 'lesson_2/task_3.dart';
import 'lesson_2/task_4.dart';
import 'lesson_2/task_5.dart';
import 'shared/helpers.dart';

void main() {
  group("l03h01", () => runTestLesson2Task1());
  group('l03h02', () => runTestLesson2Task2());
  group("l03h03", () => runTestLesson2Task3());
   group('l03h04', () => runTestLesson2Task4());
   group('l03h05', () => runTestLesson2Task5());
}
void runTestLesson2Task1() {
  testWidgets('module1', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final Iterable<Text> allTextsWithGrey = [
      ...tester.widgetList(find.text("DEFEND")),
      ...tester.widgetList(find.text("ATTACK")),
      ...tester.widgetList(find.text("HEAD")),
      ...tester.widgetList(find.text("TORSO")),
      ...tester.widgetList(find.text("LEGS")),
      ...tester.widgetList(find.text("You")),
      ...tester.widgetList(find.text("Enemy")),
    ].cast<Text>();
    final Iterable<Color?> colorsOfTextsWithGrey =
    allTextsWithGrey.map((e) => e.style?.color).toSet().toList();
    expect(
      colorsOfTextsWithGrey.length,
      1,
      reason: 'количество уникальных цветов',
    );
    expect(
      colorsOfTextsWithGrey.first,
      isNotNull,
    );

    expect(
      colorsOfTextsWithGrey.first,
      const Color(0xFF161616),
    );

    final Iterable<Text> allTextsWithWhite = [
      ...tester.widgetList(find.text("GO")),
    ].cast<Text>();
    final List<Color?> colorsOfTextsWithWhite =
    allTextsWithWhite.map((e) => e.style?.color).toSet().toList();
    expect(colorsOfTextsWithWhite.length, 1);
    expect(colorsOfTextsWithWhite.first, isNotNull);

    expect(
      colorsOfTextsWithWhite.first,
      isOneOrAnother(const Color(0xDDFFFFFF), const Color(0xDEFFFFFF)),
    );
  });
}


void runTestLesson2Task2() {
  testWidgets('module2', (WidgetTester tester) async {
    expect(
      FightClubColors.background,
      const Color.fromRGBO(213, 222, 240, 1),
    );
    expect(
      FightClubColors.greyButton,
      isOneOrAnother(Colors.black38, Color(0x60000000)),
    );
    expect(
      FightClubColors.blueButton,
      Color(0xFF1C79CE),
    );
    expect(
      FightClubColors.blackButton,
      isOneOrAnother(Colors.black87, Color(0xDE000000)),
    );
    expect(
      FightClubColors.darkGreyText,
      Color(0xFF161616),
    );

    expect(
      FightClubColors.whiteText,
      isOneOrAnother(Color(0xDDFFFFFF), Color(0xDEFFFFFF)),
    );
  });
}


void runTestLesson2Task3() {
  testWidgets('module3', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    final List<Row> rowWidgets = tester
        .widgetList<Row>(find.descendant(of: find.byType(FightersInfo), matching: find.byType(Row)))
        .toList();
    final Row? rowWithTwoChildren = rowWidgets.firstWhereOrNull((e) => e.children.length == 2);
    expect(rowWithTwoChildren, isNotNull, reason: "Cannot find Row with needed colors");
    expect(rowWithTwoChildren!.crossAxisAlignment, CrossAxisAlignment.stretch);
    expect(
      rowWithTwoChildren.children[0],
      isInstanceOf<Expanded>(),
    );
    expect(
      (rowWithTwoChildren.children[0] as Expanded).child,
      isInstanceOf<ColoredBox>(),
    );
    expect(
      ((rowWithTwoChildren.children[0] as Expanded).child as ColoredBox).color,
      Colors.white,
    );

    expect(
      rowWithTwoChildren.children[1],
      isInstanceOf<Expanded>(),
    );
    expect(
      (rowWithTwoChildren.children[1] as Expanded).child,
      isInstanceOf<ColoredBox>(),
    );
    expect(
      ((rowWithTwoChildren.children[1] as Expanded).child as ColoredBox).color,
      Color(0xFFC5D1EA),
    );
  });
}


void runTestLesson2Task4() {
  testWidgets('module4', (WidgetTester tester) async {
    void _testSizedBox(SizedBox sizedBox) {
      expect(sizedBox.width, double.infinity);
    }

    void _testPadding(Padding padding) {
      expect((padding.padding as EdgeInsets).left, 16);
      expect((padding.padding as EdgeInsets).right, 16);
    }

    void _testColoredBox(ColoredBox coloredBox) {
      expect(coloredBox.color, const Color(0xFFC5D1EA));
    }

    await tester.pumpWidget(MyApp());
    final SafeArea safeArea = tester.widget<SafeArea>(find.byType(SafeArea));
    expect(safeArea.child, isInstanceOf<Column>());

    final Column topLevelColumn = safeArea.child as Column;
    final Widget? possiblyExpanded =
    topLevelColumn.children.firstWhereOrNull((element) => element is Expanded);
    expect(possiblyExpanded, isNotNull);
    expect(possiblyExpanded, isInstanceOf<Expanded>());
    final Expanded expanded = possiblyExpanded as Expanded;

    if (expanded.child is SizedBox) {
      final SizedBox sizedBox = expanded.child as SizedBox;

      _testSizedBox(sizedBox);

      expect(sizedBox.child, isInstanceOf<Padding>());
      final Padding padding = sizedBox.child as Padding;
      _testPadding(padding);

      expect(padding.child, isInstanceOf<ColoredBox>());
      _testColoredBox(padding.child as ColoredBox);
    } else {
      expect(expanded.child, isInstanceOf<Padding>());
      final Padding padding = expanded.child as Padding;
      _testPadding(padding);

      if (padding.child is SizedBox) {
        final SizedBox sizedBox = padding.child as SizedBox;
        _testSizedBox(sizedBox);

        expect(sizedBox.child, isInstanceOf<ColoredBox>());
        _testColoredBox(sizedBox.child as ColoredBox);
      } else {
        expect(padding.child, isInstanceOf<ColoredBox>());
        final ColoredBox coloredBox = padding.child as ColoredBox;
        _testColoredBox(coloredBox);

        expect(coloredBox.child, isInstanceOf<SizedBox>());

        _testSizedBox(coloredBox.child as SizedBox);
      }
    }
  });
}
void runTestLesson2Task5() {
  testWidgets('module5', (WidgetTester tester) async {
    final String youAvatarPath = "assets/images/you-avatar.png";
    final String enemyAvatarPath = "assets/images/enemy-avatar.png";

    final yourData = await rootBundle.load(youAvatarPath);
    final yourBuffer = yourData.buffer;
    final yourBytes = yourBuffer.asUint8List(yourData.offsetInBytes, yourData.lengthInBytes);
    final yourMd5checksum = md5.convert(yourBytes);
    expect(yourMd5checksum.toString(), "b740ac516bd8fb9950654185ce9241c4");

    final enemiesData = await rootBundle.load(enemyAvatarPath);
    final enemiesBuffer = enemiesData.buffer;
    final enemiesBytes =
    enemiesBuffer.asUint8List(enemiesData.offsetInBytes, enemiesData.lengthInBytes);
    final enemiesMd5checksum = md5.convert(enemiesBytes);
    expect(enemiesMd5checksum.toString(), "98855f71fa4fd927e3789adebcddaf73");

    expect(FightClubImages.youAvatar, youAvatarPath);
    expect(FightClubImages.enemyAvatar, enemyAvatarPath);

    await tester.pumpWidget(MyApp());

    final youImageFinder = assetImageByPathFinder(youAvatarPath);
    expect(youImageFinder, findsOneWidget);
    final Image youImage = tester.widget(youImageFinder);
    expect(youImage.image, isInstanceOf<AssetImage>());
    expect((youImage.image as AssetImage).assetName, youAvatarPath);

    final enemyImageFinder = assetImageByPathFinder(enemyAvatarPath);
    expect(enemyImageFinder, findsOneWidget);
    final Image enemyImage = tester.widget(enemyImageFinder);
    expect(enemyImage.image, isInstanceOf<AssetImage>());
    expect((enemyImage.image as AssetImage).assetName, enemyAvatarPath);
  });
}

Finder assetImageByPathFinder(final String path) {
  return find.byWidgetPredicate((widget) {
    if (widget is! Image) {
      return false;
    }
    final provider = widget.image;
    if (provider is ExactAssetImage) {
      return provider.assetName == path;
    } else if (provider is AssetImage) {
      return provider.assetName == path;
    }
    return false;
  });
}