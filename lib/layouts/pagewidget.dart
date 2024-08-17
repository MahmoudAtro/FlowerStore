import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/Provider/cart.dart';
import 'package:storeapp/database/authintication.dart';
import 'package:storeapp/widgets/details.dart';

// ignore: must_be_immutable
class Pagewidget extends StatelessWidget {
  Authintication user = Authintication();
  Pagewidget(
    {super.key, required, required this.product});
    Map product;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Cart>(context);
    return GestureDetector(
      onTap: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) => Details(product: product,)));
      },
      child: GridTile(
        // ignore: sort_child_properties_last
        child: Stack(
          children: [
            Positioned(
              top: -3,
              bottom: -9,
              left: 0,
              right: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(55),
                child: Image.network("${product["img"]}"),
              ),
            )
          ],
        ),
        footer: GridTileBar(
          trailing: IconButton(
              onPressed: () {
                provider.add(product);
              },
              icon: Icon(
                Icons.add,
                color: Color.fromARGB(255, 62, 94, 70),
              )),
          leading: Text("${product["price"]}"),
          title: Text(""),
        ),
      ),
    );
  }
}
