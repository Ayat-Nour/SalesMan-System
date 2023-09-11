import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:route_salesman_system/Models/User.dart';
import 'package:route_salesman_system/Models/VanObject.dart';
import 'package:route_salesman_system/Services/DataManager.dart';

class VanStockPage extends StatefulWidget {
  const VanStockPage({Key? key}) : super(key: key);

  @override
  State<VanStockPage> createState() => _VanStockPageState();
}

class _VanStockPageState extends State<VanStockPage> {

  DataManager read = DataManager();

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Widget buildVanObject(VanObject object)=> Padding(
      padding: const EdgeInsets.all( 10),
      child: SizedBox(
        height: height*0.2,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text("${object.name}",style: TextStyle(fontSize: width*0.05,fontWeight: FontWeight.bold),),
                      Text.rich(
                        TextSpan(
                            text: "price/pieceVS".tr(),
                            style: TextStyle(color: Colors.black45,fontSize: width*0.03),
                            children: <InlineSpan>[
                              TextSpan(
                                text: object.price.toString() + "JD".tr(),
                                style: TextStyle(color:  Color(0xffFF5F6D),fontSize: width*0.03),
                              )
                            ]
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Text(object.quantity.toString()+"piecesVS".tr(),style: TextStyle(fontSize:width*0.025),)),
                Expanded(
                    flex: 1,
                    child: Image.asset("${object.img}",width: width*0.2,height: width*0.2,)),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding:  EdgeInsets.only(left: width*0.025,right: width*0.025,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              SizedBox(
                  height: height*0.35,
                  child: Row(
                    children: [
                      Expanded(
                          flex:2,
                          child: Padding(
                            padding: const EdgeInsets.only(left:30),
                            child: Text("headerVS".tr(),style: TextStyle(fontSize: width*0.05,wordSpacing: 10,)),
                          )),
                      Expanded(
                          flex: 3,
                          child: Image.asset("lib/assets/van-stock-img.jpg",))
                    ],
                  )),
              SizedBox(
                height: height*0.49,
                child: StreamBuilder<List<VanObject>>(
                  stream: read.readVanObject(MyUser.id!),
                  builder: (context , snapshot){
                    if(snapshot.hasData){
                      final vanObjects = snapshot.data!;
                      return ListView(
                        children: vanObjects.map(buildVanObject).toList(),
                      );
                    }
                    else{
                      return const Center(child: CircularProgressIndicator(),);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      )
    );



  }
}
