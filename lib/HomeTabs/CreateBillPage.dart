import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:route_salesman_system/Models/CompletedBillObject.dart';
import 'package:route_salesman_system/Models/User.dart';
import 'package:route_salesman_system/Models/VanObject.dart';
import 'package:route_salesman_system/Services/DataManager.dart';

class CreateBillPage extends StatefulWidget {
  const CreateBillPage({Key? key}) : super(key: key);

  @override
  State<CreateBillPage> createState() => _CreateBillPageState();
}

class _CreateBillPageState extends State<CreateBillPage> {

  DataManager read = DataManager();
  TextEditingController productController = TextEditingController();
  TextEditingController methodController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  DateTime time= DateTime(2022);
  String img="";
  double price=0;
  double totalPrice=0;
  String docID="";
  num newQuantity=0;
  num oldQuantity=0;

Widget buildProduct(VanObject object)=>Container(
  child:   GestureDetector(

      onTap: () {

        setState(() {

          productController.text = object.name.toString();
          img = object.img.toString();
          price =double.parse(object.price.toString());
          docID=object.id.toString();
          oldQuantity=object.quantity!;
          Navigator.pop(context);

        });

      },

      child:  ListTile(

        title: Text("${object.name.toString()}"),

        subtitle: Text("${object.quantity}"+"pcsAvailable".tr()),

      ),

    ),
);


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: EdgeInsets.only(
              left: width * 0.03,
              right: width * 0.03,
              bottom: height*0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: height*0.35,
                    child: Row(
                      children: [
                        Expanded(
                            flex:2,
                            child: Padding(
                              padding: const EdgeInsets.only(left:30),
                              child: Text("headerCreateBill".tr(),style: TextStyle(fontSize: width*0.05,wordSpacing: 10,)),
                            )),
                        Expanded(
                            flex: 2,
                            child: Image.asset("lib/assets/sale-order.jpg",))
                      ],
                    )),
                 TextField(
                  controller: companyNameController,
                  style: TextStyle(fontSize: 20),
                  decoration:  InputDecoration(
                    contentPadding: EdgeInsets.all(30),
                    isDense: true,
                    hoverColor: Colors.transparent,
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFF5F6D),),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffFF5F6D),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),

                    hintText: "companyName".tr(),
                    hintStyle: const TextStyle(fontSize: 20)
                  ),
                ),
                TextField(
                  controller: productController,
                  style: TextStyle(fontSize: 20),
                  readOnly: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(30),
                    isDense: true,
                    suffixIcon:
                        Icon(Icons.keyboard_arrow_down, size: width * 0.04),
                    hoverColor: Colors.transparent,
                    fillColor: Colors.white,
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffFF5F6D)),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffFF5F6D),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "productName".tr(),
                      hintStyle: TextStyle(fontSize: 20)
                  ),
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title:  Text('products'.tr()),
                        content: SizedBox(
                          width: width * 0.35,
                          height: height * 0.3,
                          child: StreamBuilder<List<VanObject>>(
                            stream: read.readVanObject(MyUser.id!),
                            builder: (context , snapshot){
                              if(snapshot.hasData){
                                final products = snapshot.data!;
                                return ListView(
                                  children: products.map(buildProduct).toList(),
                                );
                              }
                              else{
                                return const Center(child: CircularProgressIndicator(),);
                              }
                            },
                          )
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child:  Text('cancel'.tr()),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                     Expanded(
                      child: TextField(
                        onChanged: (String x){
                          setState(() {
                            totalPrice=price* double.parse(quantityController.text);
                            newQuantity = oldQuantity - int.parse(quantityController.text);
                          });
                        },
                        controller: quantityController,
                        style: const TextStyle(fontSize: 20),
                        keyboardType: TextInputType.number,
                        decoration:  InputDecoration(
                          contentPadding:const EdgeInsets.all(30),
                          isDense: true,
                          hoverColor: Colors.transparent,
                          fillColor: Colors.white,
                          filled: true,
                          border:const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFF5F6D)),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          enabledBorder:const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffFF5F6D),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "amount".tr(),
                            hintStyle: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: methodController,
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(30),
                          isDense: true,
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            size: width * 0.04,
                          ),
                          hoverColor: Colors.transparent,
                          fillColor: Colors.white,
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffFF5F6D)),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xffFF5F6D),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "paymentMethod".tr(),
                            hintStyle: TextStyle(fontSize: 20)
                        ),
                        onTap: () {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title:  Text('method'.tr()),
                              content: SizedBox(
                                  width: width * 0.35,
                                  height: height * 0.15,
                                  child: ListView(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            methodController.text = "Cash";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child:  ListTile(
                                          title: Text("cashHP".tr()),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            methodController.text = "Check";
                                            Navigator.pop(context);
                                          });
                                        },
                                        child:  ListTile(
                                          title: Text("checksHP".tr()),
                                        ),
                                      ),
                                    ],
                                  )),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child:  Text('cancel'.tr()),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: height * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color(0xffFF5F6D),
                            width: 4
                          )
                            ),
                        child: Center(
                          child: Text(
                            "${totalPrice} "+"JD".tr(),
                            style: TextStyle(
                                color: const Color(0xffFF5F6D), fontSize: width * 0.04),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          final bill = CompletedBillObject(
                           companyName: companyNameController.text,
                           productName:productController.text,
                           productImage:img,
                           quantity: int.parse(quantityController.text),
                           totalPrice: totalPrice,
                           time:DateTime.now(),
                           paymentMethod: methodController.text,
                          );
                          read.createBill(bill,MyUser.id!).then((value) {
                            read.updateQuantity(docID, newQuantity);
                            final snackBar =SnackBar(
                              content:  Text('billSuccessfully'.tr(),style: TextStyle(fontSize: 15),),
                              backgroundColor: Colors.green,
                              elevation: 10,
                              action: SnackBarAction(
                                label: 'done'.tr(),
                                textColor: Colors.white,
                                onPressed: () {
                                  setState(() {
                                    companyNameController.text="";
                                    productController.text="";
                                    quantityController.text="";
                                    methodController.text="";
                                    totalPrice=0;
                                  });
                                },
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }).then((value) => {
                          setState(() {
                          companyNameController.text="";
                          productController.text="";
                          quantityController.text="";
                          methodController.text="";
                          totalPrice=0;
                          })
                          });
                        },
                        child: Container(
                          height: height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient:  const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xffFF5F6D),
                                    Color(0xffFFC371),
                                  ])),
                          child: Center(
                            child: Text(
                              "create".tr(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: width * 0.04),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
