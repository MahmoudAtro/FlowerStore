import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/Provider/cart.dart';
import 'package:storeapp/database/authintication.dart';
import 'package:storeapp/layouts/drawer.dart';
import 'package:storeapp/shared/color.dart';
import 'package:storeapp/widgets/basket.dart';

// ignore: must_be_immutable
class Pagelayout extends StatefulWidget {
   Pagelayout(
      {super.key,
      required this.title,
      required this.body,
      required this.isdrawer,
      required this.isbasket,
      required this.icon});
  final String title;
  final Widget body;
  final bool isdrawer;
  final bool isbasket;
  final IconData icon;

  @override
  State<Pagelayout> createState() => _PagelayoutState();
}

class _PagelayoutState extends State<Pagelayout> {
  Authintication user = Authintication();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: widget.isdrawer ? MyDrawer() : null,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: Colors.white,
              size: 22.0,
            ),
            Text(
              widget.title,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        actions: <Widget>[
          widget.isbasket
              ? SizedBox(
                  width: 1.0,
                )
              : Consumer<Cart>(
                  builder: ((context, cart, child) {
                    return Row(
                      children: [
                        Stack(
                          children: [
                            Visibility(
                              visible: cart.count() > 0,
                              child: Positioned(
                                right: 0,
                                top: -5,
                                child: Container(
                                    child: Text(
                                      "${cart.count()}",
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0)),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(211, 164, 255, 193),
                                        shape: BoxShape.circle)),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Basket()));
                                },
                                icon: const Icon(
                                  Icons.add_shopping_cart,
                                )),
                          ],
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Text(
                            "\$ ${cart.totel()}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    );
                  }),
                )
        ],
        backgroundColor: appbarGreen,
      ),
      body: Column(
        children: [
          user.client.auth.currentUser != null ? 
          user.client.auth.currentUser?.emailConfirmedAt == null ?
          MaterialBanner(
            elevation: 1.0,
              content: Text("your email is not confirmed"),
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text("Confirm Email"),
                )
              ]) :
              SizedBox()
              : 
              SizedBox(),
              Expanded(child: widget.body),
        ],
      ),
    ));
  }
}
