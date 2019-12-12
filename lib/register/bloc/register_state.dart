import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isPasswordConfirmValid;
  final bool isTelConfirmValid;
  final bool isStudentConfirmValid;
  final bool isNameConfirmValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  RegisterState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isPasswordConfirmValid,
    @required this.isNameConfirmValid,
    @required this.isTelConfirmValid,
    @required this.isStudentConfirmValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFailure,
  });

  factory RegisterState.empty() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isPasswordConfirmValid:true,
      isTelConfirmValid:true,
      isNameConfirmValid:true,
      isStudentConfirmValid:true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading() {
    return RegisterState(
      isEmailValid: true,
      isPasswordValid: true,
      isPasswordConfirmValid:true,
      isTelConfirmValid:true,
      isNameConfirmValid:true,
      isStudentConfirmValid:true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.failure() {
    return RegisterState(
      isEmailValid: true,
      isPasswordConfirmValid:true,
      isPasswordValid: true,
      isTelConfirmValid:true,
      isNameConfirmValid:true,
      isStudentConfirmValid:true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isEmailValid: true,
      isPasswordConfirmValid:true,
      isPasswordValid: true,
      isTelConfirmValid:true,
      isStudentConfirmValid:true,
      isNameConfirmValid:true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  RegisterState update({
    bool isEmailValid,
    bool isPasswordValid,
    bool isPasswordConfirmValid,
    bool isTelConfirmValid,
    bool isNameConfirmValid,
    bool isStudentConfirmValid,
    
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isPasswordConfirmValid:isPasswordConfirmValid,
      isNameConfirmValid:isNameConfirmValid,
      isTelConfirmValid:isTelConfirmValid,
      isStudentConfirmValid:isStudentConfirmValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    bool isEmailValid,
    bool isPasswordValid,
    bool isPasswordConfirmValid,
    bool isTelConfirmValid,
    bool isNameConfirmValid,
    bool isStudentConfirmValid,
    bool isSubmitEnabled,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isPasswordConfirmValid:isPasswordConfirmValid??this.isPasswordConfirmValid,
      isTelConfirmValid:isTelConfirmValid??this.isTelConfirmValid,
      isNameConfirmValid:isNameConfirmValid??this.isNameConfirmValid,
      isStudentConfirmValid:isStudentConfirmValid??this.isStudentConfirmValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  String toString() {
    return '''RegisterState {
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,      
      isPasswordConfirmValid:$isPasswordConfirmValid,
      isTelConfirmValid:$isTelConfirmValid,
      isNameConfirmValid:$isNameConfirmValid,
      isStudentConfirmValid:$isStudentConfirmValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure,
    }''';
  }
}
