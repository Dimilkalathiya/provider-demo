import 'package:flutter/material.dart';
import 'package:my_provider/CartView.dart';
import 'package:my_provider/Product.dart';
import 'package:my_provider/cart_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Product> product = [
    Product(name: 'charger', price: 399, id: 1, discount: 10),
    Product(name: 'battery', price: 799, id: 2, discount: 10),
    Product(name: 'display', price: 1699, id: 3, discount: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyProvider'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartViewClass(),
                      ));
                },
                child:
                    Consumer<CartController>(builder: (context, cart, child) {
                  return Stack(children: [
                    Icon(Icons.shopping_cart),
                    (cart.getList().length > 0)
                        ? Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(13))),
                            child: Center(
                                child: Text(
                              cart.getList().length.toString(),
                              style: TextStyle(fontSize: 10),
                            )),
                          )
                        : Text(''),
                  ]);
                }),
              ),
            ),
          ],
        ),
        body: Column(
          children: product.map((p) {
            return Card(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Consumer<CartController>(
                      builder: (context, cart, child) {
                        return ElevatedButton(
                          onPressed: () {
                            CartController cartBean =
                                Provider.of<CartController>(context,
                                    listen: false);

                            if (cart.cartGetList(p.id!) == null) {
                              cartBean.add(p);
                            } else {
                              cart.incrQty(p.id!);
                            }
                          },
                          child: Text("Add"),
                        );
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 3),
                        child: Text(p.name!),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 3),
                            child: Text(
                              p.price.toString(),
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 3),
                            child: Text(
                                (p.price! - (p.price! * p.discount! / 100))
                                    .toString()),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(p.id.toString()),
                  ),
                ],
              ),
            );
          }).toList(),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
