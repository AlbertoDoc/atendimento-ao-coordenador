import 'package:attend/services/login_service.dart';

abstract class LoginController {
  Future<bool> login(String email, String password);
}

class LoginControllerImpl extends LoginController {
  @override
  Future<bool> login(String email, String password) async {
    final statusCode = await LoginService.login(email, password);

    return statusCode == 200 ? true : false;
  }
}
