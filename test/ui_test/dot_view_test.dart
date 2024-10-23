import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/dot_view.dart';
import 'package:mobiletesting/pages/login_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'dot_view_test.mocks.dart';

@GenerateMocks([LoginViewModel])
void main() {
  group('Dot Widget', () {
    late MockLoginViewModel mockViewModel;

    setUp(() {
      mockViewModel = MockLoginViewModel();
    });

    testWidgets('Circles should be filled based on inputted PIN length',
        (WidgetTester tester) async {
      when(mockViewModel.inputtedPin).thenAnswer((_) => '122');

      await tester.pumpWidget(MaterialApp(home: Dot(viewModel: mockViewModel)));

      final containers =
          tester.widgetList<Container>(find.byType(Container)).toList();

      // Skip the first container as it's the parent
      final firstDotDeco = containers[1].decoration as BoxDecoration;
      final secondDotDeco = containers[2].decoration as BoxDecoration;
      final thirdDotDeco = containers[3].decoration as BoxDecoration;
      final forthDotDeco = containers[4].decoration as BoxDecoration;
      final fifthDotDeco = containers[5].decoration as BoxDecoration;

      expect(firstDotDeco.color, Colors.orange);
      expect(secondDotDeco.color, Colors.orange);
      expect(thirdDotDeco.color, Colors.orange);

      expect(forthDotDeco.color, null);
      expect(forthDotDeco.border?.top.color, Colors.orange);
      expect(fifthDotDeco.color, null);
      expect(fifthDotDeco.border?.top.color, Colors.orange);
    });
  });
}
