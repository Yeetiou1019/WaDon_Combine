import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../authentication_bloc/bloc/bloc.dart';
import 'register.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class propertyList{
  int id;
  String name;
 
  propertyList(this.id, this.name);
 
  static List<propertyList> getProperty() {
    return <propertyList>[
      propertyList(1, '商業智慧學院'),
      //propertyList(2, '人文社會學院'),
    ];
  }
}

class clubList{
  int id;
  String name;
 
  clubList(this.id, this.name);
 
  static List<clubList> getClub() {
    return <clubList>[
      clubList(1, '智慧商務系'),
      clubList(2, '財政稅務系'),
      clubList(3, '會計資訊系'),
      clubList(4, '觀光管理系'),
      clubList(5, '金融資訊系'),
    ];
  }
  static List<clubList> getClub2() {
    return <clubList>[
      clubList(1, '文化創意產業系'),
      clubList(2, '人力資源發展系'),
    ];
  }
}


class genderList{
  int id;
  String name;
 
  genderList(this.id, this.name);
 
  static List<genderList> getGender() {
    return <genderList>[
      genderList(1, '男'),
      genderList(2, '女'),
    ];
  }
}


class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();
  final TextEditingController _telConfirmController = TextEditingController();
  final TextEditingController _studentConfirmController = TextEditingController();
  final TextEditingController _nameConfirmController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }
  List<propertyList> _propertylist = propertyList.getProperty();
  List<DropdownMenuItem<propertyList>> _dropdownMenuItems;
  propertyList _selectedProperty;

  List<clubList> _clublist = clubList.getClub();
  List<DropdownMenuItem<clubList>> _dropdownMenuClub;
  clubList _selectedClub;

  List<genderList> _genderlist = genderList.getGender();
  List<DropdownMenuItem<genderList>> _dropdownMenuGender;
  genderList _selectedGender;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _passwordConfirmController.addListener(_onPasswordConfirmChanged);
    _nameConfirmController.addListener(_onNameConfirmChanged);
    _telConfirmController.addListener(_onTelConfirmChanged);
    _studentConfirmController.addListener(_onStudentConfirmChanged);

    _dropdownMenuItems = buildDropdownMenuItems(_propertylist);
    _dropdownMenuClub = buildDropdownMenuClub(_clublist);
    _dropdownMenuGender = buildDropdownMenuGender(_genderlist);

    _selectedProperty = _dropdownMenuItems[0].value;
    _selectedClub = _dropdownMenuClub[0].value;
    _selectedGender = _dropdownMenuGender[0].value;
  }

  List<DropdownMenuItem<propertyList>> buildDropdownMenuItems(List properties) {
  List<DropdownMenuItem<propertyList>> items = List();
  for (propertyList propertylist in properties) {
    items.add(
      DropdownMenuItem(
        value: propertylist,
        child: Text(propertylist.name),
      ),
    );
  }
  return items;
}

  List<DropdownMenuItem<clubList>> buildDropdownMenuClub(List clubs) {
  List<DropdownMenuItem<clubList>> items = List();
  for (clubList clublist in clubs) {
    items.add(
      DropdownMenuItem(
        value: clublist,
        child: Text(clublist.name),
      ),
    );
  }
  return items;
}

  List<DropdownMenuItem<genderList>> buildDropdownMenuGender(List genders) {
  List<DropdownMenuItem<genderList>> items = List();
  for (genderList genderlist in genders) {
    items.add(
      DropdownMenuItem(
        value: genderlist,
        child: Text(genderlist.name),
      ),
    );
  }
  return items;
}


onChangeDropdownItem(propertyList selectedProperty) {
  setState(() {
    _selectedProperty = selectedProperty;
  });
}

onChangeDropdownClub(clubList selectedClub) {
  setState(() {
    _selectedClub = selectedClub;
  });
}

onChangeDropdownGender(genderList selectedGender) {
  setState(() {
    _selectedGender = selectedGender;
  });
}

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('處理中...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('註冊失敗'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: '電子信箱',
                    ),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? '無效的電子信箱' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: '密碼',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPasswordValid ? '無效的密碼' : null;
                    },
                  ),
                  TextFormField(
                    controller: _passwordConfirmController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: '密碼確認',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPasswordConfirmValid ? '再次確認密碼' : null;
                    },
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                    height: 60.0,
                    width: 150,
                    child: TextFormField(
                    controller: _studentConfirmController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.info_outline),
                      labelText: '學號',
                    ),
                    obscureText: false,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isStudentConfirmValid ? '請輸入正確學號' : null;
                    },
                  ),
                  ),
                  SizedBox(
                    height: 60.0,
                    width: 130,
                    child: TextFormField(
                    controller: _nameConfirmController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.insert_emoticon),
                      labelText: '姓名',
                    ),
                    obscureText: false,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isNameConfirmValid ? '請檢查本欄位' : null;
                    },
                  ),
                  ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text("系所", 
                      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.05),),
                      DropdownButton(
                    value: _selectedProperty,
                    items: _dropdownMenuItems,
                    onChanged: onChangeDropdownItem,
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 20,
                  ),
                  DropdownButton(
                    value: _selectedClub,
                    items: _dropdownMenuClub,
                    onChanged: onChangeDropdownClub,
                  ),
                  SizedBox(
                    height: 30.0,
                    width: 20,
                  ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 60.0,
                        width: 70,
                      child:DropdownButton(
                    value: _selectedGender,
                    items: _dropdownMenuGender,
                    onChanged: onChangeDropdownGender,
                  ),
                      ),
                    SizedBox(
                    height: 60.0,
                    width: 200,
                    child: TextFormField(
                    controller: _telConfirmController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      labelText: '手機號碼',
                    ),
                    obscureText: false,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isTelConfirmValid ? '請輸入正確手機號碼' : null;
                    },
                  ),
                  ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                    width: 20,
                  ),
                  
                  SizedBox(
                    height: 30.0,
                    width: 20,
                  ),
                  
                  
                  //Text('Selected: ${_selectedProperty.name}'),
                  RegisterButton(
                    onPressed: isRegisterButtonEnabled(state)
                        ? _onFormSubmitted
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nameConfirmController.dispose();
    _telConfirmController.dispose();
    _studentConfirmController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _registerBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onPasswordConfirmChanged() {
    _registerBloc.add(
      PasswordConfirmChanged(passwordConfirm: _passwordConfirmController.text),
    );
  }
  
  void _onTelConfirmChanged() {
    _registerBloc.add(
      TelConfirmChanged(telConfirm: _telConfirmController.text),
    );
  }

  void _onStudentConfirmChanged() {
    _registerBloc.add(
      StudentConfirmChanged(studentConfirm: _studentConfirmController.text),
    );
  }

  void _onNameConfirmChanged() {
    _registerBloc.add(
      NameConfirmChanged(nameConfirm: _nameConfirmController.text),
    );
  }
  

  void _onFormSubmitted() {
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text,
        cId:_selectedClub.name,
        gender:_selectedGender.name,
        tel:_telConfirmController.text,
        student:_studentConfirmController.text,
        name: _nameConfirmController.text,
      ),
    );
  }
}