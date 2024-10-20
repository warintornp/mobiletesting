import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// TODO: โดนดัก
// https://iiro.dev/writing-widget-tests-for-navigation-events/
// inspect text is not realistic for i18n
class MainPage extends StatelessWidget {
  void _navigateToDetailsPage(BuildContext context) {
    final route = MaterialPageRoute(builder: (_) => DetailsPage('Hello!'));
    Navigator.of(context).push(route);
  }

  static const navigateToDetailsButtonKey = Key('navigateToDetails');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing navigation'),
      ),
      body: ElevatedButton(
        onPressed: () => _navigateToDetailsPage(context),
        child: Text('Navigate to details page!'),
        key: navigateToDetailsButtonKey,
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  DetailsPage(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details page'),
      ),
      body: Center(
        child: Text(message),
      ),
    );
  }
}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('MainPage navigation tests', () {
    late NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    Future<void> _buildMainPage(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: MainPage(),

        // This mocked observer will now receive all navigation events
        // that happen in our app.
        navigatorObservers: [mockObserver],
      ));

      // The tester.pumpWidget() call above just built our app widget
      // and triggered the pushObserver method on the mockObserver once.
      verify(mockObserver.didPush(any!, any));
    }

    Future<void> _navigateToDetailsPage(WidgetTester tester) async {
      // Tap the button which should navigate to the details page.
      //
      // By calling tester.pumpAndSettle(), we ensure that all animations
      // have completed before we continue further.
      await tester.tap(find.byKey(MainPage.navigateToDetailsButtonKey));
      await tester.pumpAndSettle();
    }

    testWidgets(
        'when tapping "navigate to details" button, should navigate to details page',
        (WidgetTester tester) async {
      await _buildMainPage(tester);
      await _navigateToDetailsPage(tester);

      // By tapping the button, we should've now navigated to the details
      // page. The didPush() method should've been called...
      verify(mockObserver.didPush(any!, any));

      // ...and there should be a DetailsPage present in the widget tree...
      var detailsFinder = find.byType(DetailsPage);
      expect(detailsFinder, findsOneWidget);

      // ...with the message we sent from main page.
      var messageFinder = find.text('Hello!');
      var strictMatch =
          find.descendant(of: detailsFinder, matching: messageFinder);
      expect(strictMatch, findsOneWidget);
    });
  });
}
