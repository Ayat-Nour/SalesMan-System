
import 'dart:developer';

class CompletedBillObject{
  final String? companyName;
  final String? productName;
  final String? productImage;
  final int? quantity;
  final double? totalPrice;
  final DateTime? time;
  final String? paymentMethod;
  final String? id;
  final String? userId;

  CompletedBillObject({this.companyName,this.productName,this.productImage,this.quantity,this.totalPrice,this.time,this.paymentMethod,this.id,this.userId});

  Map<String ,dynamic> toJson(String id,String userId)=>{
    'companyName':companyName,
    'productName':productName,
    'productImage':productImage,
    'quantity':quantity,
    'totalPrice':totalPrice,
    'time':time,
    'paymentMethod':paymentMethod,
    'id':id,
    'user id':userId
  };


  static CompletedBillObject fromJson(Map<String,dynamic> json) => CompletedBillObject(
      companyName: json['companyName'],
      paymentMethod: json['paymentMethod'],
      productImage: json['productImage'],
    productName: json['productName'],
      quantity: json['quantity'],
      time: json['time'].toDate(),
      totalPrice: json['totalPrice'],
      id: json['id'],
  );

}