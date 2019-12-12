import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';
import '../../firebase/user_repository.dart';
import '../../validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _passwordComfirm = BehaviorSubject<String>();
  final _telComfirm = BehaviorSubject<String>();
  final _nameComfirm = BehaviorSubject<String>();
  final _studentComfirm = BehaviorSubject<String>();

  String get emailAddress => _email.value;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();
  
  @override
  Stream<RegisterState> transformEvents(
    Stream<RegisterEvent> events,
    Stream<RegisterState> Function(RegisterEvent event) next,
  ) {
    final observableStream = events as Observable<RegisterEvent>;
    final nonDebounceStream = observableStream.where((event) {
      return (event is! EmailChanged && event is! PasswordChanged && event is! PasswordConfirmChanged && event is! TelConfirmChanged && event is! NameConfirmChanged && event is! StudentConfirmChanged);
    });
    final debounceStream = observableStream.where((event) {
      return (event is EmailChanged || event is PasswordChanged || event is PasswordConfirmChanged || event is NameConfirmChanged || event is TelConfirmChanged || event is StudentConfirmChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super
        .transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is PasswordConfirmChanged) {
      yield* _mapPasswordConfirmChangedToState(event.passwordConfirm);
    } else if (event is TelConfirmChanged) {
      yield* _mapTelConfirmChangedToState(event.telConfirm);
    } else if (event is NameConfirmChanged) {
      yield* _mapNameConfirmChangedToState(event.nameConfirm);
    } else if (event is StudentConfirmChanged) {
      yield* _mapStudentConfirmChangedToState(event.studentConfirm);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password,event.cId,event.gender,event.tel,event.name,event.student);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }
  Stream<RegisterState> _mapPasswordConfirmChangedToState(String passwordComfirm) async* {
    yield state.update(
      isPasswordConfirmValid: Validators.isValidConfirmPassword(passwordComfirm),
    );
  }
    Stream<RegisterState> _mapTelConfirmChangedToState(String telComfirm) async* {
    yield state.update(
      isTelConfirmValid: Validators.isValidTel(telComfirm),
    );
  }
    Stream<RegisterState> _mapNameConfirmChangedToState(String nameComfirm) async* {
    yield state.update(
      isNameConfirmValid: Validators.isValidName(nameComfirm),
    );
  }
    Stream<RegisterState> _mapStudentConfirmChangedToState(String studentComfirm) async* {
    yield state.update(
      isStudentConfirmValid: Validators.isValidStudent(studentComfirm),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String email,
    String password,
    String cId,
    String gender,
    String tel,
    String name,
    String student,
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        email: email,
        password: password,
      );
      await _userRepository.addUserToFirestore(
        email,
        password,
        cId,
        gender,
        tel,
        name,
        student,
      );
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
  
}