import 'package:flutter/widgets.dart';

import '../../services/firebase_auth.dart';
import '../../services/validation.dart';

class LoginProvider with ChangeNotifier {
  final _firebaseAuthService = FirebaseAuthServices();
  final _validationService = ValidationService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  String? validate() {
    String email = emailController.text;
    String password = passwordController.text;

    if (_validationService.validateEmail(email) != null) {
      notifyListeners();

      return _validationService.validateEmail(email);
    } else if (_validationService.validatePassword(password) != null) {
      notifyListeners();

      return _validationService.validatePassword(password);
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<dynamic> login() async {
    isLoading = true;
    String? validationError = validate();

    if (validationError != null) {
      isLoading = false;
      notifyListeners();

      return validationError;
    } else {
      isLoading = false;
      notifyListeners();

      return await _firebaseAuthService.login(
          emailController.text, passwordController.text);
    }
  }
}
