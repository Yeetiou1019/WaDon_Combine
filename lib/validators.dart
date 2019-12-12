class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(\d){2,}$',
  );
    static final RegExp _nameRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$'
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidConfirmPassword(String passwordConfirm) {
    return _passwordRegExp.hasMatch(passwordConfirm);
  }

  static isValidTel(String tel) {
    return _passwordRegExp.hasMatch(tel);
  }
  
  static isValidStudent(String student) {
    return _passwordRegExp.hasMatch(student);
  }

  static isValidName(String name) {
    return _nameRegExp.hasMatch(name);
  }
  
}