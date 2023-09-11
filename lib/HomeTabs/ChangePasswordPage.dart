import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:route_salesman_system/Models/User.dart';
import 'package:route_salesman_system/Services/DataManager.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  TextEditingController passwordCon = TextEditingController();
  TextEditingController confirmCon = TextEditingController();
  String errorMessage="";
  DataManager read = DataManager();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Image.asset("lib/assets/R-Logo-title.png",height: 300,)),
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xffFF5F6D),size: 30),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Image.asset("lib/assets/change-password.jpg",height: height*0.45,),
              Padding(
                padding:  EdgeInsets.only(left: width*0.2,right: width*0.2,bottom: width*0.05,top: width*0.01),
                child: Text("HeaderCP".tr(),style: TextStyle( fontSize: width*0.04),),
              ),
              Padding(
                padding:  EdgeInsets.only(left: width*0.2,right: width*0.2,bottom: width*0.025),
                child: TextField(
                  controller: passwordCon,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide:  BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "newPass".tr(),
                    hintStyle:const TextStyle(fontSize: 20),
                    suffixIcon: const Icon(Icons.lock,color: Color(0xffFF5F6D),size: 35,),
                    contentPadding:const  EdgeInsets.all(20),
                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: width*0.2,right: width*0.2,bottom: width*0.025),
                child: TextField(
                  controller: confirmCon,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide:  BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "confirmPass".tr(),
                    hintStyle: const TextStyle(fontSize: 20),
                    suffixIcon: const Icon(Icons.lock_outline,color: Color(0xffFF5F6D),size: 35,),
                    contentPadding: const EdgeInsets.all(20),
                  ),
                  onSubmitted: (x){
                    if(passwordCon.text!=confirmCon.text){
                      setState(() {
                        errorMessage="errorMsg1CP".tr();
                      });
                    }
                  },
                ),
              ),
              errorMessage!="" ? Padding(
                padding:  EdgeInsets.only(left: width*0.2,right: width*0.2,bottom: width*0.05,),
                child: Text(errorMessage,style:const TextStyle(color: Colors.red),),
              ):Container(),
              Padding(
                padding:  EdgeInsets.only(left: width*0.2,right: width*0.2,bottom: width*0.025),
                child: GestureDetector(
                  onTap: () async {
                    if(passwordCon.text!=confirmCon.text ||confirmCon.text==""||passwordCon.text==""){
                      setState(() {
                        errorMessage="errorMsg2CP".tr();
                      });
                    }else{
                      setState(() {
                        errorMessage="";
                        read.changePassword(MyUser.id!, passwordCon.text);
                        final snackBar =SnackBar(
                          content:  Text('passSuccessfully'.tr(),style: TextStyle(fontSize: 15),),
                          backgroundColor: Colors.green,
                          elevation: 10,
                          action: SnackBarAction(
                            label: 'done'.tr(),
                            textColor: Colors.white,
                            onPressed: () {
                              setState(() {

                              });
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        passwordCon.text="";
                        confirmCon.text="";

                      });
                    }
                  },
                  child: Container(
                    width: width*0.2,
                    height: width*0.08,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child:  Text(
                        "change".tr(),style: TextStyle(color: Color(0xffFF5F6D) ,fontSize: width*0.03),),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),);
  }
}
