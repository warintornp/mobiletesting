import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'login_screen_navigation_test.mocks.dart';

// TODO: โดนดัก
@GenerateMocks([NavigatorObserver])
void main() {
  testWidgets(
      'navigate to home_screen only when pin validation and api call are successful',
      (WidgetTester tester) async {
    BuildContext? context;
    // Arrange
    final mockObserver = MockNavigatorObserver();
    // mockObserver
    //     .didPush(MaterialPageRoute(builder: (_) => HomeScreen()), null)
    //     .thenAnswer((_) async => null);

    //  when(mockLoginService.authenticate('132495'))
    //     .thenAnswer((_) async => false);
    final widget = MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) {
            context = context;
            return ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => HomeViewModel(),
                      child: HomeScreen(),
                    ),
                  ),
                );
              },
              child: Text('Navigate'),
            );
          },
        ),
      ),
      navigatorObservers: [mockObserver],
    );

    // Act
    await tester.pumpWidget(widget);
    await tester.tap(find.text('Navigate'));
    await tester.pumpAndSettle();

    // Assert
    verify(mockObserver.didPush(any, any));
    verify(mockObserver.didPush(
      argThat(isA<MaterialPageRoute>().having(
        (route) => route.builder,
        'builder',
        isA<WidgetBuilder>().having((builder) => builder(context!), 'widget',
            isA<ChangeNotifierProvider<HomeViewModel>>()
            // .having(
            //   (provider) => provider.child,
            //   'child',
            //   isA<HomeScreen>(),
            // ),
            ),
      )),
      any,
    ));
  }, tags: 'widget');
}

class HomeViewModel extends ChangeNotifier {
  // Your HomeViewModel implementation
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('This is the home screen'),
      ),
    );
  }
}
