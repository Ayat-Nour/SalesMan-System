import 'package:flutter/material.dart';
import 'package:route_salesman_system/Models/CompletedBillObject.dart';
import 'package:route_salesman_system/Models/User.dart';
import 'package:route_salesman_system/Models/VanObject.dart';
import 'package:route_salesman_system/Services/DataManager.dart';
import 'package:route_salesman_system/SplashScreen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

double totalCash=0;
double totalCheck=0;
double totalStock=0;

TextEditingController newPassword=TextEditingController();
TextEditingController confirmPassword=TextEditingController();


  @override
  void initState() {
    DataManager().getTotalCash(MyUser.id!).then((value) => {
      setState(() {
        totalCash = value;
      }),
    });
    DataManager().getTotalCheck(MyUser.id!).then((value) => {
      setState(() {
        totalCheck = value;
      }),

    });
    DataManager().getTotalStock(MyUser.id!).then((value) => {
      setState(() {
        totalStock = value;
      }),

    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration:const  BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/background2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: width*0.1,right: width*0.1,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: width*0.37,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: height*0.2,
                        child: Center(child: Text("Wallet Check",style: TextStyle(fontSize: width*0.035)))),
                    Container(
                      height: height*0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade900,
                                Colors.blue.shade300,
                              ]
                          )
                      ),
                      child:  Center(
                        child: Text("cash: $totalCash JD's",style: TextStyle(color: Colors.white,fontSize: width*0.02),),
                      ),
                    ),
                    Container(
                      height: height*0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.orange.shade900,
                                Colors.orange.shade300,
                              ]
                          )
                      ),
                      child:  Center(
                        child: Text("check: $totalCheck JD's",style: TextStyle(color: Colors.white,fontSize: width*0.02),),
                      ),
                    ),
                    Container(
                      height: height*0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.pink.shade900,
                                Colors.pink.shade300,
                              ]
                          )
                      ),
                      child:  Center(
                        child: Text("stock: $totalStock JD's",style: TextStyle(color: Colors.white,fontSize: width*0.02),),
                      ),
                    ),

                ],),
              ),
              SizedBox(
                width: width*0.37,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        height: height*0.2,
                        child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.grey.shade200,
                          child: Image.asset("lib/assets/sales_man.png",width: width*0.15,),
                        ),),
                    Container(
                      height: height*0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xff5ACE7C),
                            width: 3
                          )
                      ),
                      child:  Center(
                        child: Row(
                          children: [
                            const Padding(
                              padding:  EdgeInsets.only(left: 15,right: 15),
                              child: Icon(Icons.language_outlined,color:Color(0xff5ACE7C) ,size: 30,),
                            ),
                            Text("Change language",style: TextStyle(color: const Color(0xff5ACE7C),fontSize: width*0.02),),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: height*0.12,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: const Color(0xff5ACE7C),
                              width: 3
                          )
                      ),
                      child:  Center(
                        child: Row(
                          children: [
                            const Padding(
                              padding:  EdgeInsets.only(left: 15,right: 15),
                              child: Icon(Icons.password_outlined,color:Color(0xff5ACE7C) ,size: 30,),
                            ),
                            Text("Change Password",style: TextStyle(color: const Color(0xff5ACE7C),fontSize: width*0.02),),
                          ],
                        ),
                      ),
                    ),
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
                      child: Container(
                        height: height*0.12,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: const Color(0xff5ACE7C),
                                width: 3
                            )
                        ),
                        child:  Center(
                          child: Row(
                            children: [
                              const Padding(
                                padding:  EdgeInsets.only(left: 15,right: 15),
                                child: Icon(Icons.logout_outlined,color:Color(0xff5ACE7C) ,size: 30,),
                              ),
                              Text("Logout",style: TextStyle(color: const Color(0xff5ACE7C),fontSize: width*0.02),),
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],),
              ),
            ],

          ),
        )
      ),
    );
  }
}
