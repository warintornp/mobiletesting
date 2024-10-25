enum AuthorizationStatus {
  success,
  technicalError,
  unauthorised,
}

extension AuthorizationStatusExtension on AuthorizationStatus {
  String getDisplayText() {
    switch (this) {
      case AuthorizationStatus.success:
        return "Login success";
      case AuthorizationStatus.unauthorised:
        return "Unauthorised";
      case AuthorizationStatus.technicalError:
        return "Facing technical difficulties";
    }
  }
}
