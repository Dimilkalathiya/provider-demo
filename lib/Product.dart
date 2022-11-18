

class Product {

  String? name;
  int? id;
  double? price;
  int? discount;

  Product({this.name,this.id,this.price,this.discount});

}
class CartBean {

  String? name;
  int? id;
  double? price;
  int? discount;
  int qty=1;

  CartBean({this.name,this.id,this.price,this.discount,required this.qty});

  CartBean.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json['id'],
        price = json['price'],
        discount = json['discount'],
        qty =json['qty'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'id': id,
    'price': price,
    'discount': discount,
    'qty': qty,
  };

  @override
  String toString() {
    return 'CartView{name: $name, id: $id, price: $price, discount: $discount, qty: $qty}';
  }
}