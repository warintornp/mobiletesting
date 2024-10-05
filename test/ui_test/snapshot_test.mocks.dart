// Mocks generated by Mockito 5.4.4 from annotations
// in mobiletesting/test/ui_test/snapshot_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i8;
import 'dart:ui' as _i7;

import 'package:flutter/material.dart' as _i6;
import 'package:mobiletesting/pages/login_with_pin_view_model.dart' as _i3;
import 'package:mobiletesting/pages/sort_order.dart' as _i4;
import 'package:mobiletesting/user_service.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUserService_0 extends _i1.SmartFake implements _i2.UserService {
  _FakeUserService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoginWithPinViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginWithPinViewModel extends _i1.Mock
    implements _i3.LoginWithPinViewModel {
  MockLoginWithPinViewModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.UserService get userService => (super.noSuchMethod(
        Invocation.getter(#userService),
        returnValue: _FakeUserService_0(
          this,
          Invocation.getter(#userService),
        ),
      ) as _i2.UserService);

  @override
  _i4.SortOrder get keyPadsortOrder => (super.noSuchMethod(
        Invocation.getter(#keyPadsortOrder),
        returnValue: _i4.SortOrder.ascending,
      ) as _i4.SortOrder);

  @override
  String get inputtedPin => (super.noSuchMethod(
        Invocation.getter(#inputtedPin),
        returnValue: _i5.dummyValue<String>(
          this,
          Invocation.getter(#inputtedPin),
        ),
      ) as String);

  @override
  bool get isLoading => (super.noSuchMethod(
        Invocation.getter(#isLoading),
        returnValue: false,
      ) as bool);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  void onDigitPressed(
    int? digit,
    _i6.BuildContext? context,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onDigitPressed,
          [
            digit,
            context,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addPinDigit(int? digit) => super.noSuchMethod(
        Invocation.method(
          #addPinDigit,
          [digit],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onDeleteButtonPressed() => super.noSuchMethod(
        Invocation.method(
          #onDeleteButtonPressed,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i7.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [UserService].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserService extends _i1.Mock implements _i2.UserService {
  MockUserService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i8.Future<Map<String, dynamic>?> fetchUserDetails(String? pin) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchUserDetails,
          [pin],
        ),
        returnValue: _i8.Future<Map<String, dynamic>?>.value(),
      ) as _i8.Future<Map<String, dynamic>?>);

  @override
  _i8.Future<Map<String, dynamic>?> fetchUserDetails2(String? pin) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchUserDetails2,
          [pin],
        ),
        returnValue: _i8.Future<Map<String, dynamic>?>.value(),
      ) as _i8.Future<Map<String, dynamic>?>);
}
