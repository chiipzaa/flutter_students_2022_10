/// id : 17
/// name : "NodeMCU Development Kit V2 แถมสาย USB (Node MCU)"
/// image : "product_22.jpg"
/// stock : 0
/// price : 280
/// created_at : "2021-08-13T06:06:02.092Z"
/// updated_at : "2021-08-13T06:06:02.092Z"

class Product {
  Product({
      num? id, 
      String? name, 
      String? image, 
      num? stock, 
      num? price, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _name = name;
    _image = image;
    _stock = stock;
    _price = price;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
    _stock = json['stock'];
    _price = json['price'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  num? _id;
  String? _name;
  String? _image;
  num? _stock;
  num? _price;
  String? _createdAt;
  String? _updatedAt;
Product copyWith({  num? id,
  String? name,
  String? image,
  num? stock,
  num? price,
  String? createdAt,
  String? updatedAt,
}) => Product(  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
  stock: stock ?? _stock,
  price: price ?? _price,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  num? get id => _id;
  String? get name => _name;
  String? get image => _image;
  num? get stock => _stock;
  num? get price => _price;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    map['stock'] = _stock;
    map['price'] = _price;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}