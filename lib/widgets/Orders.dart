import 'package:flutter/material.dart';
import 'package:storeapp/database/db_order.dart';
import 'package:storeapp/shared/color.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  DbOrder myorder = DbOrder();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_bag,
              color: Colors.white,
              size: 22.0,
            ),
            Text(
              "Orders",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
        backgroundColor: appbarGreen,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Container(
          height: 500,
          child: FutureBuilder(
              future: myorder.read(),
              builder: (context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  Center(
                    child: Text(
                      "${snapshot.hasError}",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          leading: Text("${snapshot.data![index]["date"]}"),
                          title: Text("${snapshot.data![index]["name"]}"),
                          subtitle: Text(
                            "Quantity: ${snapshot.data![index]["quantity"]}",
                            style: TextStyle(fontSize: 10.0),
                          ),
                          trailing: Text("${snapshot.data![index]["price"]}"),
                        ));
                      });
                } else {
                  return Text(
                    "No Order",
                    style: TextStyle(color: Colors.blue, fontSize: 18.0),
                  );
                }
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(
            () {
              myorder.delete();
            },
          );
        },
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Icon(Icons.delete , color: Colors.red[500],),
      ),
    ));
  }
}
