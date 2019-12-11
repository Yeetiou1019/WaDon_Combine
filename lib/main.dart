import 'package:wadone_main/bloc/userbloc.dart';

import './authentication_bloc/bloc/bloc.dart';
import './firebase/user_repository.dart';
import './login/login_page.dart';
import './sample_bloc-delegate.dart';
import 'package:flutter/material.dart';
import 'splash_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import './home/home_page.dart';
import 'package:provider/provider.dart';
import './bloc/managerbloc.dart';
import './bloc/pagebloc.dart';

void main(){
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
} 

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserRepository _userRepository = UserRepository();
  final PageStorageBucket _bucket = PageStorageBucket();
  AuthenticationBloc _authenticationBloc;
  @override
  void initState(){
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          builder: (BuildContext context) => _authenticationBloc,),
        ChangeNotifierProvider(
          builder: (context) => PageBloc(),
        ),
        Provider(
          builder: (context) => Managerbloc(),
        ),
        Provider(builder: (context) => Userbloc(),)
        // Provider<String>.value(value: state.userName)
        // ChangeNotifierProvider(
        //   builder: (context)=>Userbloc(),
        // ),  
      ],
      child: MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal.shade200,//上方欄底色
        primaryTextTheme: TextTheme(
          title: TextStyle(
          color: Colors.white, //上方欄字顏色
          )
        )
      ),
        debugShowCheckedModeBanner: false,
        home: PageStorage(
          bucket: _bucket,
          child:BlocBuilder(
            bloc: _authenticationBloc,
            builder: (context, state) {
    	      if (state is Authenticated) {
        	    return HomePage(account: state.userName);
    	      } else if (state is Unauthenticated) {
        	    return LoginPage(userRepository: _userRepository,);
    	      } else
        	    return SplashPage();
            }
        ),
      ),    
    ),
    );
  }
}
