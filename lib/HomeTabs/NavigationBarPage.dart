import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_salesman_system/HomeTabs/CompletedBillsPage.dart';
import 'package:route_salesman_system/HomeTabs/CreateBillPage.dart';
import 'package:route_salesman_system/HomeTabs/HomePage.dart';
import 'package:route_salesman_system/HomeTabs/ProfilePage.dart';
import 'package:route_salesman_system/HomeTabs/VanStockPage.dart';
import 'package:route_salesman_system/Models/User.dart';

class NavigationBarPage extends StatefulWidget {
  const NavigationBarPage({Key? key}) : super(key: key);

  @override
  State<NavigationBarPage> createState() => _NavigationBarPageState();
}

class _NavigationBarPageState extends State<NavigationBarPage> {

  int selectedIndex=0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> selectedPage =const [
    HomePage(),
  VanStockPage(),
  CompletedBillsPage(),
  CreateBillPage(),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Image.asset("lib/assets/R-Logo-title.png",height: 270,)),
        elevation: 5,
        iconTheme: const IconThemeData(color: Color(0xffFF5F6D),size: 30),
      ),
        drawer:  Drawer(
          elevation: 20,
          width: width*0.5,
          child: ListView(
            children: [
              SizedBox(
                height: height*0.25,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xffFF5F6D),
                          Color(0xffFFC371),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                  ),
                    child:Row(
                      children: [
                        Image.asset("lib/assets/sales_man.png",width: width*0.2,),
                        Text("${MyUser.firstName} ${MyUser.lastName}",style: TextStyle(color: Colors.white,fontSize: 30),)
                      ],
                    ),),
              ),
              SizedBox(height: height*0.02,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    context.locale == Locale("ar") ?
                    context.setLocale(Locale("en")).then((value) => setState((){})) : context.setLocale(Locale("ar")).then((value) => setState((){})) ;
                  });
                },
                child: ListTile(
                  leading: Icon(Icons.language_outlined,color:Color(0xffFF5F6D) ,size: 30,),
                  title:  Text("changeLanguage".tr(),style: TextStyle(color:  Color(0xffFF5F6D),fontSize: width*0.03),),
                ),
              ),
              SizedBox(height: height*0.02,),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/changePasswordPage');
                },
                child: ListTile(
                  leading: Icon(Icons.password_outlined,color:Color(0xffFF5F6D) ,size: 30,),
                  title:  Text("changePassword".tr(),style: TextStyle(color:  Color(0xffFF5F6D),fontSize: width*0.03),),
                ),
              ),
              SizedBox(height: height*0.02,),
              GestureDetector(
                onTap: (){
                  MyUser.company = "";
                  MyUser.firstName = "";
                  MyUser.lastName = "";
                  MyUser.userName = "";
                  MyUser.password = "";
                  MyUser.id = "";
                  MyUser.phoneNumber ="";
                  Navigator.pushReplacementNamed(context, "/");
                },
                child: ListTile(
                  leading: Icon(Icons.logout_outlined,color:Color(0xffFF5F6D) ,size: 30,),
                  title:  Text("logout".tr(),style: TextStyle(color:  Color(0xffFF5F6D),fontSize: width*0.03),),
                ),
              ),
            ],
          ),
        ),
        onDrawerChanged: (x){
        print("$x LLLLLLLLLLLLLLLLLLLLLLL");
        },
        bottomNavigationBar: BottomNavigationBar(
          items:  [
            BottomNavigationBarItem(
              icon:const Icon(Icons.home_outlined),
              backgroundColor: Colors.black,
              label: "homeNB".tr(),
            ),
            BottomNavigationBarItem(
              icon:const Icon(Icons.local_shipping_outlined),
              backgroundColor: Colors.black,
              label: "vanNB".tr()
            ),
            BottomNavigationBarItem(
              icon:const Icon(Icons.list_outlined),
              backgroundColor: Colors.black,
              label: "billsNB".tr()
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.edit_outlined),
              backgroundColor: Colors.black,
              label: "createNB".tr()
            ),
          ],
          selectedItemColor: const Color(0xffFF5F6D),
          unselectedItemColor: Colors.white,
          currentIndex: selectedIndex,
          elevation: 20,
          iconSize: width*0.04,
          onTap: _onItemTapped,

        ),
        body: Center(
          child: selectedPage.elementAt(selectedIndex),
        )
    );
  }
}
