import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mobiletesting/login_screen/login_screen.dart';
import 'package:mobiletesting/login_screen/login_service.dart';
import 'package:mobiletesting/login_screen/login_view_model.dart';
import 'package:mobiletesting/login_screen/pin_rules.dart';
import 'package:mobiletesting/login_screen/sort_order.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../unit_testing/login_view_model_test.mocks.dart';

@GenerateMocks([BuildContext, LoginService])
void main() {
  late MockLoginService mockLoginService;

  setUp(() {
    mockLoginService = MockLoginService();
  });

  testWidgets('example of widget testing', (WidgetTester tester) async {
    // Arrange
    // when(serverA.functionB('')).thenAnswer((_) async => true);
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding
        .setSurfaceSize(Size(400, 800)); // ensure a must UI component visible
    await tester.pumpWidget(
      MaterialApp(home: Text("1")),
    );

    //Act
    await tester.tap(find.text('1'));
    await tester.pumpAndSettle();

    //Assertion
    expect(find.byType(AlertDialog), findsNothing);
    // verify(serverA.functionB('')).called(1);
    // await expectLater(find.byType(MaterialApp), matchesGoldenFile('goldens/widget.png'));
  }, tags: 'widget');


}
