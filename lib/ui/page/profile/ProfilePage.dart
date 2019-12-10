import 'package:flutter/material.dart';
import 'package:wadone_main/ui/manager/manager.dart';
import 'package:wadone_main/ui/page/user/user.dart';
import '../../page/profile/logout_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../authentication_bloc/bloc/bloc.dart';

class ProfilePage extends StatefulWidget {
  final String account;
  const ProfilePage({Key key,this.account}) : super(key:key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Manager(),
                ),
              );
            },
            child: Text('Manager Page'),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => User(),
                ),
              );
            },
            child: Text('User Page'),
          ),
          Container(
            child: Column(
              children: <Widget>[
                LogoutButton(
                  onPressed:()=> BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}