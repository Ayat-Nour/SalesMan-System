import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:route_salesman_system/Models/CompletedBillObject.dart';
import 'package:route_salesman_system/Models/User.dart';
import 'package:route_salesman_system/Services/DataManager.dart';

class CompletedBillsPage extends StatefulWidget {
  const CompletedBillsPage({Key? key}) : super(key: key);

  @override
  State<CompletedBillsPage> createState() => _CompletedBillsPageState();
}

class _CompletedBillsPageState extends State<CompletedBillsPage> {


  DataManager read = DataManager();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    Widget buildCompletedBillObj(CompletedBillObject objects)=>Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width*0.45,
        height: height*0.6,
        child: Card(
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(objects.productName.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: width*0.05),),
                  Text.rich(
                    TextSpan(
                        text: "to".tr(),
                        style: TextStyle(color: Color(0xffFF5F6D),fontSize: width*0.025),
                        children: <InlineSpan>[
                          TextSpan(
                            text: objects.companyName,
                            style: TextStyle(color:Colors.black,fontSize: width*0.025),
                          )
                        ]
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                        text: "Amount".tr(),
                        style: TextStyle(color: Color(0xffFF5F6D),fontSize: width*0.025),
                        children: <InlineSpan>[
                          TextSpan(
                            text: objects.quantity.toString() + "piecesVS".tr(),
                            style: TextStyle(color:Colors.black,fontSize: width*0.025),
                          )
                        ]
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                        text: "totalPrice".tr(),
                        style: TextStyle(color: Color(0xffFF5F6D),fontSize: width*0.025),
                        children: <InlineSpan>[
                          TextSpan(
                            text: objects.totalPrice.toString() + "JD".tr(),
                            style: TextStyle(color:Colors.black,fontSize: width*0.025),
                          )
                        ]
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                        text: "time".tr(),
                        style: TextStyle(color: Color(0xffFF5F6D),fontSize: width*0.025),
                        children: <InlineSpan>[
                          TextSpan(
                            text: objects.time.toString(),
                            style: TextStyle(color:Colors.black,fontSize: width*0.025),
                          )
                        ]
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                        text: "method".tr(),
                        style: TextStyle(color: Color(0xffFF5F6D),fontSize: width*0.025),
                        children: <InlineSpan>[
                          TextSpan(
                            text: objects.paymentMethod.toString(),
                            style: TextStyle(color:Colors.black,fontSize: width*0.025),
                          )
                        ]
                    ),
                  ),
                  Image.asset(objects.productImage.toString(),width: width*0.25,height: width*0.25,)
                ],
              ),
            )
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.only(left: width*0.025,right: width*0.025,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:[
            Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                        flex:2,
                        child: Padding(
                          padding: const EdgeInsets.only(left:30,right: 30),
                          child: Text("headerCB".tr(),style: TextStyle(fontSize: width*0.05,wordSpacing: 10,)),
                        )),
                    Expanded(
                        flex: 2,
                        child: Image.asset("lib/assets/Completed-pana.png"))
                  ],
                )),
            Expanded(
              flex: 2,
              child: StreamBuilder<List<CompletedBillObject>>(
                 stream: read.readCreatedBills(MyUser.id!),
                builder: (context , snapshot){
                  if(snapshot.hasData){
                    final bills = snapshot.data!;
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: bills.map(buildCompletedBillObj).toList(),
                    );
                  }
                  else{
                    print(snapshot.error.toString());
                    return const Center(child: CircularProgressIndicator(),);
                  }
                },),
            )
          ],
        ),
      ),
    );
  }
}
