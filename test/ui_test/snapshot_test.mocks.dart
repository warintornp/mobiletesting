// Mocks generated by Mockito 5.4.4 from annotations
// in mobiletesting/test/ui_test/snapshot_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i9;
import 'dart:ui' as _i10;

import 'package:flutter/material.dart' as _i8;
import 'package:http/http.dart' as _i3;
import 'package:mobiletesting/home_screen/home_view_model.dart' as _i11;
import 'package:mobiletesting/login_screen/login_service.dart' as _i2;
import 'package:mobiletesting/login_screen/login_view_model.dart' as _i5;
import 'package:mobiletesting/login_screen/sort_order.dart' as _i6;
import 'package:mobiletesting/secure_storage.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;

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

class _FakeLoginService_0 extends _i1.SmartFake implements _i2.LoginService {
  _FakeLoginService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeClient_1 extends _i1.SmartFake implements _i3.Client {
  _FakeClient_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSecureStorage_2 extends _i1.SmartFake implements _i4.SecureStorage {
  _FakeSecureStorage_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoginViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginViewModel extends _i1.Mock implements _i5.LoginViewModel {
  MockLoginViewModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.LoginService get loginService => (super.noSuchMethod(
        Invocation.getter(#loginService),
        returnValue: _FakeLoginService_0(
          this,
          Invocation.getter(#loginService),
        ),
      ) as _i2.LoginService);

  @override
  _i6.SortOrder get keyPadsortOrder => (super.noSuchMethod(
        Invocation.getter(#keyPadsortOrder),
        returnValue: _i6.SortOrder.ascending,
      ) as _i6.SortOrder);

  @override
  String get inputtedPin => (super.noSuchMethod(
        Invocation.getter(#inputtedPin),
        returnValue: _i7.dummyValue<String>(
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
    _i8.BuildContext? context,
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
  _i9.Future<void> onShowErrorDialogButtonPressed(_i8.BuildContext? context) =>
      (super.noSuchMethod(
        Invocation.method(
          #onShowErrorDialogButtonPressed,
          [context],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

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
  void addListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i10.VoidCallback? listener) => super.noSuchMethod(
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

/// A class which mocks [LoginService].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginService extends _i1.Mock implements _i2.LoginService {
  MockLoginService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_1(
          this,
          Invocation.getter(#client),
        ),
      ) as _i3.Client);

  @override
  _i4.SecureStorage get secureStorage => (super.noSuchMethod(
        Invocation.getter(#secureStorage),
        returnValue: _FakeSecureStorage_2(
          this,
          Invocation.getter(#secureStorage),
        ),
      ) as _i4.SecureStorage);

  @override
  _i9.Future<bool> authenticate(String? pin) => (super.noSuchMethod(
        Invocation.method(
          #authenticate,
          [pin],
        ),
        returnValue: _i9.Future<bool>.value(false),
      ) as _i9.Future<bool>);
}

/// A class which mocks [HomeViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockHomeViewModel extends _i1.Mock implements _i11.HomeViewModel {
  MockHomeViewModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Map<String, dynamic> get userDetails => (super.noSuchMethod(
        Invocation.getter(#userDetails),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i9.Future<void> onDidLoad() => (super.noSuchMethod(
        Invocation.method(
          #onDidLoad,
          [],
        ),
        returnValue: _i9.Future<void>.value(),
        returnValueForMissingStub: _i9.Future<void>.value(),
      ) as _i9.Future<void>);

  @override
  void addListener(_i10.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i10.VoidCallback? listener) => super.noSuchMethod(
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
