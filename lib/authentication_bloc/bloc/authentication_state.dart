import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() {
    return 'Uninitialized';
  }
}

class Authenticated extends AuthenticationState {
  final String userName;
  const Authenticated(this.userName);
  
  @override
  String toString() {
    return 'Authenticated {UserName: $userName}';
  }
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() {
    return 'Unauthenticated';
  }
}

class LoadingAuthentication extends AuthenticationState {
    @override
    String toString() {
    return 'Loading';
  }
}


