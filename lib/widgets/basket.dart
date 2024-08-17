import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/Provider/cart.dart';
import 'package:storeapp/database/db_order.dart';
import 'package:storeapp/layouts/pagelayout.dart';

class Basket extends StatefulWidget {
  const Basket({super.key});

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Cart>(context);
    return Pagelayout(
        isbasket: true,
        icon: Icons.shopping_cart,
        title: "Basket Cart",
        body: provider.cart.isEmpty
            ? Center(
                child: Text(
                  "no product in your basket",
                  style: TextStyle(color: Colors.blue[900], fontSize: 20),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 400,
                      width: double.infinity,
                      child: ListView.builder(
                          itemCount: provider.cart.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                    "${provider.cart[index]["img"]}"),
                              ),
                              title: Text("${provider.cart[index]["name"]}"),
                              subtitle:
                                  Text("${provider.cart[index]["price"]}"),
                              trailing: Stack(
                                children: [
                                  Consumer<Cart>(
                                    builder: (context, cart, child) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 5.0),
                                            child: IconButton(
                                                icon: const Icon(
                                                    Icons.minimize_sharp),
                                                onPressed: () {
                                                  cart.removequantity(index);
                                                }),
                                          ),
                                          Text(
                                            "${cart.cart[index]["quantity"]}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.only(top: 5.0),
                                            child: IconButton(
                                                onPressed: () {
                                                  cart.addquantity(index);
                                                },
                                                icon: const Icon(Icons.add)),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                            ));
                          }),
                    ),
                    ListTile(
                        title: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Total Price: ",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.deepPurple[900]),
                            ),
                            Consumer<Cart>(
                              builder: (context, cart, child) {
                                return Text(
                                  "\$${cart.totel()}",
                                  style: const TextStyle(fontSize: 15),
                                );
                              },
                            )
                          ],
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Delete All !',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red[900],
                                            fontSize: 20.0),
                                      ),
                                      elevation: 1.0,
                                      shadowColor: Colors.black,
                                      icon: Icon(Icons.delete),
                                      content: const Text(
                                        textAlign: TextAlign.end,
                                        'هل أنت متأكد أنك تريد حذف جميع المنتجات؟',
                                        style: TextStyle(fontSize: 12.0),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('إلغاء'),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // إغلاق النافذة بدون إتمام الشراء
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('موافق'),
                                          onPressed: () {
                                            // أكمل عملية الشراء هنا
                                            provider.deleteAll();
                                            Navigator.of(context)
                                                .pop(); // إغلاق النافذة بعد إتمام الشراء
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              color: Colors.red[700],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              padding: const EdgeInsets.all(5.0),
                              child: const Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                            const SizedBox(
                              width: 7.0,
                            ),
                            MaterialButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Confirm Buy !',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.green[900],
                                            fontSize: 20.0),
                                      ),
                                      elevation: 1.0,
                                      shadowColor: Colors.black,
                                      icon: Icon(Icons.sell),
                                      content: const Text(
                                          'هل أنت متأكد أنك تريد إتمام عملية الشراء؟'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('إلغاء'),
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // إغلاق النافذة بدون إتمام الشراء
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('موافق'),
                                          onPressed: () async {
                                            // أكمل عملية الشراء هنا
                                            DbOrder myorder = DbOrder();
                                            for (Map item in provider.cart) {
                                              var response =
                                                  await myorder.insert({
                                                "name": item["name"],
                                                "price": item["price"],
                                                "quantity": item["quantity"],
                                                "date":
                                                    DateFormat('EEEE, hh:mm a')
                                                        .format(DateTime.now())
                                                        .toString(),
                                              });
                                              print(response);
                                            }
                                            Navigator.of(context)
                                                .pop(); // إغلاق النافذة بعد إتمام الشراء
                                            provider.deleteAll();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              showCloseIcon: true,
                                              content: const Text(
                                                "تمت عملية الشراء بنجاح",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              backgroundColor: Colors.green,
                                              duration: Duration(seconds: 3),
                                            ));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              color: Colors.green[700],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)),
                              padding: const EdgeInsets.all(5.0),
                              child: const Text(
                                "Buy",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15.0),
                              ),
                            ),
                          ],
                        )),
                  ],
                )),
        isdrawer: false,
       );
  }
}
