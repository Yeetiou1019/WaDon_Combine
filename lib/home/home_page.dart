import 'package:flutter/material.dart';
import '../ui/page/page.dart';
import '../home/drawer.dart';
import '../ui/page/dashboard/SearchField.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  final String account;
  
  HomePage({Key key, this.account}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  final PageStorageBucket bucket = PageStorageBucket();
  int _selectIndex = 0; 
  Widget _bottomNavigationBar(int selectIndex) => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.teal[200], //下方欄底色
        ),
        child: CurvedNavigationBar(
          height: 50,
          backgroundColor: Colors.teal[300],
          items: <Widget>[
            Icon(Icons.home, size: 30, semanticLabel: "home"),
            Icon(Icons.subscriptions, size: 30, semanticLabel: "home"),
            Icon(Icons.subtitles, size: 30, semanticLabel: "home"),
            Icon(Icons.notifications, size: 30, semanticLabel: "home"),
            Icon(Icons.account_circle, size: 30, semanticLabel: "home"),
          ],
          onTap: _onTap,
        ),
      );

  @override
  Widget build(BuildContext context) {
  List<Widget> pages = [
    DashboardPage(
      key: PageStorageKey('DashboardPage'),
      account: widget.account,
    ),
    SubscriptionPage(
      key: PageStorageKey('SubscriptionPage'),
      account: widget.account,
    ),
    ActivityPage(
      key: PageStorageKey('ActivityPage'),
      account: widget.account,
    ),
    SearchField(
      key: PageStorageKey('SearchField'),
      //account: widget.account,
    ),
    ProfilePage(
      key: PageStorageKey('ProfilePage'),
      account: widget.account,
    ),
  ];
    return Container(
      child: Scaffold(
          appBar: new AppBar(
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  size: 30.0,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); //點擊menu打開Drawer
                },
              );
            }),
          ),
          drawer: SlideDrawer(
            account: widget.account,
          ),
          bottomNavigationBar: _bottomNavigationBar(_selectIndex),
          body: PageStorage(
            child: pages[_selectIndex],
            bucket: bucket,
          )
        ),
    );
  }

  void _onTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }
}