// Mocks generated by Mockito 5.4.4 from annotations
// in mobiletesting/test/ui_test/login_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i10;
import 'dart:ui' as _i11;

import 'package:flutter/foundation.dart' as _i3;
import 'package:flutter/material.dart' as _i2;
import 'package:flutter/src/widgets/notification_listener.dart' as _i6;
import 'package:mobiletesting/login_screen/login_service.dart' as _i4;
import 'package:mobiletesting/login_screen/login_view_model.dart' as _i7;
import 'package:mobiletesting/login_screen/pin_rules.dart' as _i5;
import 'package:mobiletesting/login_screen/sort_order.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i9;

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

class _FakeWidget_0 extends _i1.SmartFake implements _i2.Widget {
  _FakeWidget_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeInheritedWidget_1 extends _i1.SmartFake
    implements _i2.InheritedWidget {
  _FakeInheritedWidget_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({_i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.info}) =>
      super.toString();
}

class _FakeDiagnosticsNode_2 extends _i1.SmartFake
    implements _i3.DiagnosticsNode {
  _FakeDiagnosticsNode_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );

  @override
  String toString({
    _i3.TextTreeConfiguration? parentConfiguration,
    _i3.DiagnosticLevel? minLevel = _i3.DiagnosticLevel.info,
  }) =>
      super.toString();
}

class _FakeLoginService_3 extends _i1.SmartFake implements _i4.LoginService {
  _FakeLoginService_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePinRules_4 extends _i1.SmartFake implements _i5.PinRules {
  _FakePinRules_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [BuildContext].
///
/// See the documentation for Mockito's code generation for more information.
class MockBuildContext extends _i1.Mock implements _i2.BuildContext {
  MockBuildContext() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Widget get widget => (super.noSuchMethod(
        Invocation.getter(#widget),
        returnValue: _FakeWidget_0(
          this,
          Invocation.getter(#widget),
        ),
      ) as _i2.Widget);

  @override
  bool get mounted => (super.noSuchMethod(
        Invocation.getter(#mounted),
        returnValue: false,
      ) as bool);

  @override
  bool get debugDoingBuild => (super.noSuchMethod(
        Invocation.getter(#debugDoingBuild),
        returnValue: false,
      ) as bool);

  @override
  _i2.InheritedWidget dependOnInheritedElement(
    _i2.InheritedElement? ancestor, {
    Object? aspect,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #dependOnInheritedElement,
          [ancestor],
          {#aspect: aspect},
        ),
        returnValue: _FakeInheritedWidget_1(
          this,
          Invocation.method(
            #dependOnInheritedElement,
            [ancestor],
            {#aspect: aspect},
          ),
        ),
      ) as _i2.InheritedWidget);

  @override
  void visitAncestorElements(_i2.ConditionalElementVisitor? visitor) =>
      super.noSuchMethod(
        Invocation.method(
          #visitAncestorElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void visitChildElements(_i2.ElementVisitor? visitor) => super.noSuchMethod(
        Invocation.method(
          #visitChildElements,
          [visitor],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void dispatchNotification(_i6.Notification? notification) =>
      super.noSuchMethod(
        Invocation.method(
          #dispatchNotification,
          [notification],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.DiagnosticsNode describeElement(
    String? name, {
    _i3.DiagnosticsTreeStyle? style = _i3.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeElement,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_2(
          this,
          Invocation.method(
            #describeElement,
            [name],
            {#style: style},
          ),
        ),
      ) as _i3.DiagnosticsNode);

  @override
  _i3.DiagnosticsNode describeWidget(
    String? name, {
    _i3.DiagnosticsTreeStyle? style = _i3.DiagnosticsTreeStyle.errorProperty,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeWidget,
          [name],
          {#style: style},
        ),
        returnValue: _FakeDiagnosticsNode_2(
          this,
          Invocation.method(
            #describeWidget,
            [name],
            {#style: style},
          ),
        ),
      ) as _i3.DiagnosticsNode);

  @override
  List<_i3.DiagnosticsNode> describeMissingAncestor(
          {required Type? expectedAncestorType}) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeMissingAncestor,
          [],
          {#expectedAncestorType: expectedAncestorType},
        ),
        returnValue: <_i3.DiagnosticsNode>[],
      ) as List<_i3.DiagnosticsNode>);

  @override
  _i3.DiagnosticsNode describeOwnershipChain(String? name) =>
      (super.noSuchMethod(
        Invocation.method(
          #describeOwnershipChain,
          [name],
        ),
        returnValue: _FakeDiagnosticsNode_2(
          this,
          Invocation.method(
            #describeOwnershipChain,
            [name],
          ),
        ),
      ) as _i3.DiagnosticsNode);
}

/// A class which mocks [LoginViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginViewModel extends _i1.Mock implements _i7.LoginViewModel {
  MockLoginViewModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.LoginService get loginService => (super.noSuchMethod(
        Invocation.getter(#loginService),
        returnValue: _FakeLoginService_3(
          this,
          Invocation.getter(#loginService),
        ),
      ) as _i4.LoginService);

  @override
  _i8.SortOrder get keyPadsortOrder => (super.noSuchMethod(
        Invocation.getter(#keyPadsortOrder),
        returnValue: _i8.SortOrder.ascending,
      ) as _i8.SortOrder);

  @override
  _i5.PinRules get pinRules => (super.noSuchMethod(
        Invocation.getter(#pinRules),
        returnValue: _FakePinRules_4(
          this,
          Invocation.getter(#pinRules),
        ),
      ) as _i5.PinRules);

  @override
  String get inputtedPin => (super.noSuchMethod(
        Invocation.getter(#inputtedPin),
        returnValue: _i9.dummyValue<String>(
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
  String get dialogMessage => (super.noSuchMethod(
        Invocation.getter(#dialogMessage),
        returnValue: _i9.dummyValue<String>(
          this,
          Invocation.getter(#dialogMessage),
        ),
      ) as String);

  @override
  bool get shouldNavigateToHome => (super.noSuchMethod(
        Invocation.getter(#shouldNavigateToHome),
        returnValue: false,
      ) as bool);

  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);

  @override
  _i10.Future<void> onDigitPressed(
    int? digit,
    _i2.BuildContext? context,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #onDigitPressed,
          [
            digit,
            context,
          ],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  _i10.Future<void> onShowErrorDialogButtonPressed(_i2.BuildContext? context) =>
      (super.noSuchMethod(
        Invocation.method(
          #onShowErrorDialogButtonPressed,
          [context],
        ),
        returnValue: _i10.Future<void>.value(),
        returnValueForMissingStub: _i10.Future<void>.value(),
      ) as _i10.Future<void>);

  @override
  void onDeleteButtonPressed() => super.noSuchMethod(
        Invocation.method(
          #onDeleteButtonPressed,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onDialogClose() => super.noSuchMethod(
        Invocation.method(
          #onDialogClose,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onDoneNavigation() => super.noSuchMethod(
        Invocation.method(
          #onDoneNavigation,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addListener(_i11.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void removeListener(_i11.VoidCallback? listener) => super.noSuchMethod(
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
