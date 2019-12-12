import 'package:flutter/material.dart';
import '../firebase/user_repository.dart';
import '../register/register_page.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.blueGrey.shade500,
      textColor: Colors.white,
      focusColor: Colors.blueGrey,
      hoverColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text(
          '建立帳號'
      ),
      onPressed: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context){
              return RegisterScreen(userRepository: _userRepository);
            })
        );
      },
    );
  }
}