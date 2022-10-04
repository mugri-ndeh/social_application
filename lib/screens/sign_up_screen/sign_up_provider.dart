import 'package:chat_application/services/validation.dart';
import 'package:flutter/widgets.dart';

import '../../services/firebase_auth.dart';

class SignUpProvider with ChangeNotifier {
  final _firebaseAuthService = FirebaseAuthServices();
  final _validationService = ValidationService();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;

  String? validate() {
    String username = usernameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (_validationService.validateName(username) != null) {
      notifyListeners();

      return _validationService.validateName(email);
    } else if (_validationService.validateEmail(username) != null) {
      notifyListeners();

      return _validationService.validateEmail(email);
    } else if (_validationService.validatePassword(password) != null) {
      notifyListeners();

      return _validationService.validatePassword(password);
    } else if (_validationService.validateConfirmPassword(
            password, confirmPassword) !=
        null) {
      notifyListeners();

      return _validationService.validateConfirmPassword(
          password, confirmPassword);
    } else {
      notifyListeners();

      return null;
    }
  }

  Future<dynamic> signUp() async {
    isLoading = true;
    String? validationError = validate();

    if (validationError != null) {
      isLoading = false;
      notifyListeners();

      return validationError;
    } else {
      isLoading = false;
      notifyListeners();

      return await _firebaseAuthService.signUp(emailController.text,
          passwordController.text, usernameController.text);
    }
  }
}
