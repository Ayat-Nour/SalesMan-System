
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:route_salesman_system/Services/DataManager.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {

 TextEditingController emailCon = TextEditingController();
 TextEditingController passCon = TextEditingController();

 @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:  [
              Image.asset("lib/assets/Tablet login-bro.png",height: height*0.55,),
              Padding(
                padding:  EdgeInsets.only(left: width*0.2,right: width*0.2,bottom: width*0.05,top: width*0.01),
                child: Text("headerLP".tr(),style: TextStyle( fontSize: width*0.05),),
              ),
              Padding(
               padding:  EdgeInsets.only(left: width*0.2,right: width*0.2,bottom: width*0.025),
               child: TextField(
                 controller: emailCon,
                 style: const TextStyle(fontSize: 20),
                 decoration: InputDecoration(
                   fillColor: Colors.grey.shade100,
                   filled: true,
                   border: const OutlineInputBorder(
                       borderSide:  BorderSide.none,
                       borderRadius: BorderRadius.all(Radius.circular(20)),
                   ),
                   hintText: "username".tr(),
                   hintStyle:const TextStyle(fontSize: 20),
                   suffixIcon: const Icon(Icons.person_outline,color: Color(0xffFF5F6D),size: 35,),
                   contentPadding:const  EdgeInsets.all(20),
                 ),
               ),
             ),
              Padding(
                padding:  EdgeInsets.only(left: width*0.2,right: width*0.2,bottom: width*0.05),
                child: TextField(
                  controller: passCon,
                  obscureText: true,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide:  BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "password".tr(),
                    hintStyle: const TextStyle(fontSize: 20),
                    suffixIcon: const Icon(Icons.lock_outline,color: Color(0xffFF5F6D),size: 35,),
                    contentPadding: const EdgeInsets.all(20),

                  ),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left: width*0.2,right: width*0.2,bottom: width*0.025),
                child: GestureDetector(
                  onTap: () async {
                   /*  dynamic result= _x.SignIn(emailCon.text, passCon.text);
                     if (result == null){
                      print("****************** null");
                      }else{
                      print(result);
                      print("Nooot nuuuuuuuuuuuul");
                      Navigator.pushNamed(context, "/navigationBarPage");
                    }*/
                    DataManager().Login(emailCon.text, passCon.text).then((value) =>{
                      if(value == "Active user") Navigator.pushReplacementNamed(context, "/navigationBarPage")
                      else if(value == "No user"){
                      showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title:  Text('wrongUser'.tr(),style: TextStyle(fontSize: 25),),
                        content: SizedBox(
                            width: width * 0.35,
                            height: height * 0.15,
                            child:  Center(child:  Text("errorMsgLP".tr(),style: TextStyle(fontSize: 20),))),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child:  Text('done'.tr(),style: TextStyle(color: Color(0xffFF5F6D),fontSize: 20),),
                          ),
                        ],
                      ),
                    )
                      }
                    });

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
                        "continue".tr(),style: TextStyle(color: Color(0xffFF5F6D) ,fontSize: width*0.03),),
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
