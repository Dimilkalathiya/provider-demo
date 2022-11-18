import 'package:flutter/material.dart';
import 'package:my_provider/cart_controller.dart';
import 'package:provider/provider.dart';

import 'Product.dart';

class CartViewClass extends StatefulWidget {
  const CartViewClass({Key? key}) : super(key: key);

  @override
  _CartViewClassState createState() => _CartViewClassState();
}

class _CartViewClassState extends State<CartViewClass> {
  double total(List<CartBean> list) {
    double totalPrice = 0;
    double? discount = 0;
    for (int i = 0; i < list.length; i++) {
      discount = list[i].price! * list[i].qty * list[i].discount! / 100;
      totalPrice += list[i].price! * list[i].qty - discount;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CartView'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                child:
                    Consumer<CartController>(builder: (context, cart, child) {
                  return Column(
                    children: cart.getList().map((c) {
                      return Card(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                onPressed: () {
                                  cart.remove(c.id!);
                                },
                                child: Text("Remove"),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 3),
                                  child: Text(c.name!),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          //p.qty++;
                                          cart.incrQty(c.id!);
                                        },
                                        child: Text('+'),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(c.qty.toString()),
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 50,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          cart.decrQty(c);
                                          if (c.qty <= 0) {
                                            cart.remove(c.id!);
                                          }
                                        },
                                        child: Text(
                                          '-',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 3),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(c.price.toString() +
                                            " * " +
                                            c.qty.toString() +
                                            " = "),
                                      ),
                                      Text(
                                        (c.price! * c.qty).toString(),
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text((c.price! * c.qty -
                                                (c.price! *
                                                    c.qty *
                                                    c.discount! /
                                                    100))
                                            .toString()),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(c.id.toString()),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
            ),
            Text("total amount"),
            Consumer<CartController>(builder: (context, cart, child) {
              return Text(total(cart.getList()).toString());
            }),
          ],
        ),
      ),
    );
  }
}
