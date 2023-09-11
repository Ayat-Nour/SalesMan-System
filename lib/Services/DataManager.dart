import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:route_salesman_system/Models/CompletedBillObject.dart';
import 'package:route_salesman_system/Models/User.dart';
import 'package:route_salesman_system/Models/VanObject.dart';

class DataManager {
  //this to read the van stock products
  Stream<List<VanObject>> readVanObject(String userID) => FirebaseFirestore.instance
      .collection('VanStock').where('user id', isEqualTo: userID)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => VanObject.fromJson(doc.data())).toList());

  //this to read the van stock products
  Stream<List<CompletedBillObject>> readCreatedBills(String userID) => FirebaseFirestore.instance
      .collection('Bills').where('user id', isEqualTo: userID).orderBy('time',descending: true)
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => CompletedBillObject.fromJson(doc.data())).toList());

  //this to add to the bills table
  Future createBill(CompletedBillObject obj,String userId) async {
    final bill = FirebaseFirestore.instance.collection('Bills').doc();
    final json = obj.toJson(bill.id,userId);
    await bill.set(json);
  }

  //this to update the quantity on vanStock table after creating the bill
  updateQuantity(String docID,num newQuantity){
   final obj= FirebaseFirestore.instance.collection('VanStock').doc(docID);
   obj.update({
    'quantity':newQuantity,});
  }

  changePassword(String userID,String password){
    final obj= FirebaseFirestore.instance.collection('LoginTable').doc(userID);
    obj.update({
      'password':password,});
  }

  Future<double> getTotalCash(String userID)  async {
    double x =0;
    await FirebaseFirestore.instance.collection('Bills').where("paymentMethod", isEqualTo:"Cash").where("user id", isEqualTo:userID).get().then((value) => value.docs.forEach((element) { x+=element.get('totalPrice'); print(x);}));
   return x;

  }

  Future<double> getTotalCheck(String userID)  async {
    double x =0;
    await FirebaseFirestore.instance.collection('Bills').where("paymentMethod", isEqualTo:"Check").where("user id", isEqualTo:userID).get().then((value) => value.docs.forEach((element) { x+=element.get('totalPrice'); print(x);}));
    return x;

  }

  Future<double> getTotalStock(String userID)  async {
    double x =0;
    await FirebaseFirestore.instance.collection('VanStock').where("user id", isEqualTo:userID).get().then((value) => value.docs.forEach((element) { x+= (element.get('price') * element.get('quantity')); print(x);}));
    return x;

  }

  Future getPercentage(String userID)  async {
    var x ={};
    print(userID);
    await FirebaseFirestore.instance.collection('VanStock').where("user id", isEqualTo:userID).get().then((value) => value.docs.forEach((element) { x[element.get('name').toString()]= (element.get('allQuantity') - element.get('quantity'))/element.get('allQuantity')*100;}));
    return x;

  }

  
  Future Login(String username , String password)async{
     bool flag=false;
    await FirebaseFirestore.instance.collection('LoginTable').get().then((value) => value.docs.forEach((element) {
      element.data().containsValue(username) && element.data().containsValue(password) ?  {
        MyUser.company = element.get("company"),
        MyUser.firstName = element.get("first name"),
        MyUser.lastName = element.get("last name"),
        MyUser.userName = element.get("user name"),
        MyUser.password = element.get("password"),
        MyUser.id = element.get("user id"),
        MyUser.phoneNumber = element.get("phone number"),
        print(MyUser.id),
        flag = true,
      } : print("no");
    }));
    if(flag) {return "Active user";}
    else {return "No user";}
  }
  
  



}
