import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:route_salesman_system/LoginPage.dart';
import 'package:route_salesman_system/Models/ChartData.dart';
import 'package:route_salesman_system/Models/User.dart';
import 'package:route_salesman_system/Services/Auth.dart';
import 'package:route_salesman_system/Services/DataManager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final AuthenticationService _auth = AuthenticationService();
  String? name="";
  List<ChartData> data=[];
  Map percent={};
  double totalPercent=0;
  double x=0;

  double totalCash=0;
  double totalCheck=0;
  double totalStock=0;

  @override
  void initState()  {
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
    DataManager().getPercentage(MyUser.id!).then((value) => {
      setState(() {
        percent = value;
        print(percent);
      }),
    }).then((value) => {
      percent.forEach((key, value) {
        data.add(ChartData(key, percent[key], Color(0xffFF5F6D)));
        x+=value;
      }),
      totalPercent = (x/data.length),
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold  (
      backgroundColor: Colors.white,
      body: SizedBox(
        width: width,
        height: height,
          child: Padding(
            padding: EdgeInsets.only(left: width*0.03,right: width*0.03,),
            child: ListView(
              children: [
                SizedBox(
                    height: height*0.35,
                    child: Row(
                      children: [
                        Expanded(
                            flex:2,
                            child: Padding(
                              padding: const EdgeInsets.only(left:30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('hello'.tr()+ " ${MyUser.firstName}",style: TextStyle(fontSize: width*0.06),),
                                  SizedBox(height: height*0.02,),
                                  Text("keepTracking".tr(),style: TextStyle(fontSize: width*0.04),),
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Image.asset("lib/assets/home-page.jpg",)),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Container(
                    height: height*0.1,
                    decoration:  BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xffFF5F6D),
                          Color(0xffFFC371),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text("completed1HP".tr()+"${totalPercent.toStringAsFixed(2)}"+"completed2HP".tr(),style: TextStyle(color: Colors.white,fontSize: width*0.03),)),
                  ),
                ),
                SizedBox(
                  child: SfCartesianChart(
                    primaryYAxis: CategoryAxis(
                      visibleMaximum: 100,
                      maximum:100,
                      interval: 10,
                    minimum: 0
                    ),
                    primaryXAxis: CategoryAxis(
                      labelRotation: 50,
                    ),
                    series: <ChartSeries>[
                      ColumnSeries<ChartData, String>(
                      dataLabelSettings: const DataLabelSettings(isVisible: true, labelAlignment: ChartDataLabelAlignment.middle,),
                      dataSource: data,
                      yValueMapper: (ChartData x, _) => x.percentage,
                      xValueMapper: (ChartData x, _) => x.productName,
                      pointColorMapper: (ChartData x, _) => x.color,
                  ),
              ],

            ),
          ),
                SizedBox(
                    height: height*0.15,
                    child: Center(child: Text("checkHP".tr(),style:TextStyle(fontSize: width*0.06),))),
                Padding(
                  padding:  EdgeInsets.only(left:width*0.1,right: width*0.1,bottom: width*0.05),
                  child: Container(
                    height: height*0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black,
                      image: const DecorationImage(
                        image: AssetImage("lib/assets/wallet-cash.jpg",),
                        fit: BoxFit.cover,
                       opacity: 150
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("cashHP".tr(),style: TextStyle(color: Colors.white,fontSize: width*0.06),),
                        Text("$totalCash"+"JD".tr(),style: TextStyle(color: Colors.white,fontSize: width*0.06),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width*0.1,right: width*0.1,bottom: width*0.05),
                  child: Container(
                    height: height*0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                        image: const DecorationImage(
                            image: AssetImage("lib/assets/wallet-check.jpg",),
                            fit: BoxFit.cover,
                            opacity: 150
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("checksHP".tr(),style: TextStyle(color: Colors.white,fontSize: width*0.06),),
                        Text("$totalCheck"+"JD".tr(),style: TextStyle(color: Colors.white,fontSize: width*0.06),),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left:width*0.1,right: width*0.1,bottom: width*0.05),
                  child: Container(
                    height: height*0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                        image: const DecorationImage(
                            image: AssetImage("lib/assets/wallet-stock.jpg",),
                            fit: BoxFit.cover,
                            opacity: 150
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("stockHP".tr(),style: TextStyle(color: Colors.white,fontSize: width*0.06),),
                        Text("$totalStock"+"JD".tr(),style: TextStyle(color: Colors.white,fontSize: width*0.06),),
                      ],
                    ),
                  ),
                ),

      ])),
    ));
  }
}
