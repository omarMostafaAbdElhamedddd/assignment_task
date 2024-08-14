enum AuthStatus { initial, loading, success, failure }

class AuthStatee {
  // final AuthStatus status;
  // final String? message;
  final AuthStatus status;

  AuthStatee(this.status);
}