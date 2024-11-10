import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mobiletesting/home_screen/home_screen.dart';
import 'package:mobiletesting/home_screen/home_view_model.dart';
import 'package:mobiletesting/login_screen/dot_view.dart';
import 'package:mobiletesting/login_screen/login_screen.dart';
import 'package:mobiletesting/login_screen/login_view_model.dart';
import 'package:mobiletesting/login_screen/login_service.dart';
import 'package:mobiletesting/login_screen/pin_grid_view.dart';
import 'package:mobiletesting/login_screen/sort_order.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'home_snapshot_test.mocks.dart';

@GenerateMocks([HomeViewModel])
void main() {
  late MockHomeViewModel mockHomeViewModel;
  

  setUpAll(() async {
    mockHomeViewModel = MockHomeViewModel();
    //Load app font
    await loadAppFonts();
  });

  testGoldens('example of snapshot testing', (tester) async {
    // // Arrange
    // final mockViewModelA = MockViewModelA();
    // when(mockViewModelA.functionB).thenReturn('');

    // final builder = DeviceBuilder()
    //   ..overrideDevicesForAllScenarios(devices: [
    //     const Device(name: 'Pixel3a 800 x 600', size: Size(800, 600)),
    //     Device.iphone11,
    //     Device.tabletPortrait,
    //   ])
    //   ..addScenario(widget: Text(''));

    // // Act
    // await tester.pumpDeviceBuilder(builder);
    // // Assert
    // await screenMatchesGolden(tester, 'expected_golden_image');
  });

  testGoldens('example of snapshot testing1', (tester) async {
    // // Arrange, Act
    // await tester.pumpWidgetBuilder(Text(''),
    //     surfaceSize: Size(400, 900), textScaleSize: 1.0);
    // // Assert
    // await screenMatchesGolden(tester, 'pin_grid_view_ascending');
  });
//Home Scree snapshot
  testGoldens('Home screen - default tier', (WidgetTester tester) async {

    when(mockHomeViewModel.userDetails).thenReturn({
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'point': 100,
    });

    //Set screen size before run test
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    //create Home screen
    await tester.pumpWidgetBuilder(
      ChangeNotifierProvider<HomeViewModel>(
        create: (_) => mockHomeViewModel,
        child: Scaffold(body: HomeScreen()),
      ),
      surfaceSize: Size(400, 800),
    );

    //assert
    await screenMatchesGolden(tester, 'home_screen_no_tier');
  });
  testGoldens('Home screen - bronze tier', (WidgetTester tester) async {
    when(mockHomeViewModel.userDetails).thenReturn({
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'point': 100,
      'tier': 'bronze'
    });

    //Set screen size before run test
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    await tester.pumpWidgetBuilder(
      ChangeNotifierProvider<HomeViewModel>(
        create: (_) => mockHomeViewModel,
        child: Scaffold(body: HomeScreen()),
      ),
      surfaceSize: Size(400, 800),
    );

    await screenMatchesGolden(tester, 'home_screen_bronze_tier');
  });

  testGoldens('Home screen - silver tier', (WidgetTester tester) async {
    when(mockHomeViewModel.userDetails).thenReturn({
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'point': 100,
      'tier': 'silver'
    });


    //Set screen size before run test
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    await tester.pumpWidgetBuilder(
      ChangeNotifierProvider<HomeViewModel>(
        create: (_) => mockHomeViewModel,
        child: Scaffold(body: HomeScreen()),
      ),
      surfaceSize: Size(400, 800),
    );

    await screenMatchesGolden(tester, 'home_screen_silver_tier');
  });

  testGoldens('Home screen - gold tier', (WidgetTester tester) async {
    when(mockHomeViewModel.userDetails).thenReturn({
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'point': 100,
      'tier': 'gold'
    });

    //Set screen size before run test
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(Size(400, 800));

    await tester.pumpWidgetBuilder(
      ChangeNotifierProvider<HomeViewModel>(
        create: (_) => mockHomeViewModel,
        child: Scaffold(body: HomeScreen()),
      ),
      surfaceSize: Size(400, 800),
    );

    await screenMatchesGolden(tester, 'home_screen_gold_tier');
  });
}
