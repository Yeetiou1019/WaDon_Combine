import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class PasswordConfirmChanged extends RegisterEvent {
  final String passwordConfirm;

  const PasswordConfirmChanged({@required this.passwordConfirm});

  @override
  List<Object> get props => [passwordConfirm];

  @override
  String toString() => 'PasswordChanged { password: $passwordConfirm }';
}

class TelConfirmChanged extends RegisterEvent {
  final String telConfirm;

  const TelConfirmChanged({@required this.telConfirm});

  @override
  List<Object> get props => [telConfirm];

  @override
  String toString() => 'TelChanged { password: $telConfirm }';
}

class NameConfirmChanged extends RegisterEvent {
  final String nameConfirm;

  const NameConfirmChanged({@required this.nameConfirm});

  @override
  List<Object> get props => [nameConfirm];

  @override
  String toString() => 'NameChanged { name: $nameConfirm }';
}

class StudentConfirmChanged extends RegisterEvent {
  final String studentConfirm;

  const StudentConfirmChanged({@required this.studentConfirm});

  @override
  List<Object> get props => [studentConfirm];

  @override
  String toString() => 'StudentChanged { password: $studentConfirm }';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;
  final String cId;
  final String gender;
  final String name;
  final String tel;
  final String student;
  //final String cName;

  const Submitted({
    @required this.email,
    @required this.password,
    @required this.cId,
    @required this.gender,
    @required this.name,
    @required this.tel,
    @required this.student,
  //  @required this.cName,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password,cId:$cId }';
  }
}
