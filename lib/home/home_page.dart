import 'package:flutter/material.dart';
import '../ui/page/page.dart';
import '../home/drawer.dart';

class HomePage extends StatefulWidget {
  final String account;
  HomePage({Key key, this.account}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _selectIndex = 0;
  final List<Widget> pages = [
    // DashboardPage(
    //   key: PageStorageKey('DashboardPage'),
    // ),
    DashboardPage(
      key: PageStorageKey('DashboardPage')
      ),
    SubscriptionPage(
      key: PageStorageKey('SubscriptionPage'),
    ),
    ActivityPage(
      key: PageStorageKey('ActivityPage'),
    ),
    NotificationPage(
      key: PageStorageKey('NotificationPage'),
    ),
    ProfilePage(
      key: PageStorageKey('ProfilePage'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  Widget _bottomNavigationBar(int selectIndex) => Theme(
          data:Theme.of(context).copyWith(
          canvasColor: Colors.teal[200], //下方欄底色
        ),
        child:BottomNavigationBar(
        items: const <BottomNavigationBarItem>[        
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              title:  Text('主頁')),
            BottomNavigationBarItem(
              icon: const Icon(Icons.subscriptions),
              title:  Text('訂閱')),
            BottomNavigationBarItem(
              icon: const Icon(Icons.subtitles),
              title:  Text('活動')),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              title: Text('通知')),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.account_circle),
              title:  Text('個人')),
        ],
        type:BottomNavigationBarType.shifting, //分頁效果
          currentIndex: _selectIndex,
          fixedColor: Colors.blueGrey, //下方分頁點擊顏色
          onTap: _onTap,   //分頁點擊事件
          showSelectedLabels: true,   // 顯示已選擇之底部選項
          showUnselectedLabels: true, // 顯示未選擇之底部選項
  ),
);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Scaffold(
        appBar: new AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu,size: 30.0,),
              onPressed: (){
                Scaffold.of(context).openDrawer(); //點擊menu打開Drawer
              },
            );
          }),
        ),
        drawer: SlideDrawer(account: widget.account,),
        bottomNavigationBar: _bottomNavigationBar(_selectIndex),
        body: PageStorage(
          child: pages[_selectIndex],
          bucket: bucket,
        ),
      ),
    );
  }
  void _onTap(int index){
      setState(() {
        _selectIndex = index;
      });
  }
}

