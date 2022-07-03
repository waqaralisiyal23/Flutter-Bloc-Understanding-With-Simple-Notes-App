import 'package:bloclearningwithsimplenotesapp/models/models.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiProtocol {
  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) async {
    bool result = await Future.delayed(
      const Duration(seconds: 2),
      () {
        return email == 'waqar@gmail.com' && password == 'waqar123';
      },
    );
    return result ? const LoginHandle.fakeLogin() : null;
  }
}
