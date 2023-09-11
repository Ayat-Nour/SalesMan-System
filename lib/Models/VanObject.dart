class VanObject{
  final String? img;
  final String? name;
  final double? price;
  final num? quantity;
  final num? allQuantity;
  final String? id;

  VanObject({this.img,this.name,this.price,this.quantity,this.id,this.allQuantity});

  static VanObject fromJson(Map<String,dynamic> json) => VanObject(
      img: json['img'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      id: json['id'],
      allQuantity: json['allQuantity']
  );
}