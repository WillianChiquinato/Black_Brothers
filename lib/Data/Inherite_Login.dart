import 'package:flutter/material.dart';

class LoginInherite extends InheritedWidget {
  LoginInherite({
    super.key,
    required Widget child,
  }) : super(child: child);

  String loginUser = "AdminUser";
  String loginSenha = "AdminSenha";

  void newLogin(String user, String senha)
  {
    loginUser = user;
    loginSenha = senha;
    print(loginUser);
    print(loginSenha);
  }

  static LoginInherite of(BuildContext context) {
    final LoginInherite? result = context.dependOnInheritedWidgetOfExactType<LoginInherite>();
    assert(result != null, 'No LoginInherite found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(LoginInherite old) {
    return old.loginUser != loginUser && old.loginSenha != loginSenha;
  }
}
