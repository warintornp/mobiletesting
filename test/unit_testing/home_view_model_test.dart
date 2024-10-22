import 'package:flutter_test/flutter_test.dart';
import 'package:mobiletesting/pages/home_view_model.dart';
import 'package:mobiletesting/user_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'home_view_model_test.mocks.dart';

@GenerateMocks([UserService])
void main() {
  late HomeViewModel homeViewModel;
  late MockUserService mockUserService;

  setUp(() {
    mockUserService = MockUserService();
    homeViewModel = HomeViewModel(userService: mockUserService);
  });

  group('HomeViewModel', () {
    test('initial userDetails should be empty', () {
      expect(homeViewModel.userDetails, isEmpty);
    });

    test('onDidLoad should fetch user details and update userDetails',
        () async {
      // Arrange
      final mockUserDetails = {'name': 'John Doe', 'age': 30};
      when(mockUserService.fetchUserDetails())
          .thenAnswer((_) async => mockUserDetails);

      // Act
      await homeViewModel.onDidLoad();

      // Assert
      expect(homeViewModel.userDetails, equals(mockUserDetails));
      verify(mockUserService.fetchUserDetails()).called(1);
    });

    test('onDidLoad should notify listeners', () async {
      // Arrange

      when(mockUserService.fetchUserDetails()).thenAnswer((_) async => {});

      var listenerCalled = false;

      homeViewModel.addListener(() {
        listenerCalled = true;
      });

      // Act

      await homeViewModel.onDidLoad();

      // Assert

      expect(listenerCalled, isTrue);
    });
  });
}
