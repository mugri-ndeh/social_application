import 'package:chat_application/models/user.dart';
import 'package:chat_application/services/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Authentication with ChangeNotifier {
  FirebaseAuthServices authServices = FirebaseAuthServices();
  UserModel? loggedUser;
  bool loading = false;

  bool isLogin = true;

  toggleLogin() {
    isLogin = !isLogin;
    notifyListeners();
  }

  checkAuth() async {
    loading = true;
    await authServices.checkAuth().then((value) {
      loggedUser = value;
      loading = false;
    });
    notifyListeners();
  }

  logout() {
    authServices.logout();
  }
}
