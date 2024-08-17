import 'package:flutter/material.dart';

import 'package:storeapp/database/authintication.dart';
import 'package:storeapp/shared/user.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  Authintication auth = Authintication();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              UserAuth.getIsLogin()
                  ? UserAccountsDrawerHeader(
                      decoration: BoxDecoration(color: Colors.blue),
                      accountName: Text("${UserAuth.getUserUsername()}",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
                      accountEmail: Text("${UserAuth.getUserEmail()}"),
                      currentAccountPictureSize: Size.square(80),
                      currentAccountPicture: InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, "profile");
                        },
                        child: CircleAvatar(
                            radius: 55,
                            backgroundImage: UserAuth.getuserImage() == "" ? 
                            AssetImage("images/userimage.jpeg") 
                            : 
                            NetworkImage("${UserAuth.getuserImage()}")),
                      ),
                    )
                  : SizedBox(),
              ListTile(
                  title: const Text("Home"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, "home", (route) => false);
                  }),
              ListTile(
                  title: const Text("My Orders"),
                  leading: const Icon(Icons.shopping_bag),
                  onTap: () {
                    Navigator.pushNamed(context, "order");
                  }),
              ListTile(
                  title: const Text("About"),
                  leading: const Icon(Icons.help_center),
                  onTap: () {}),
              ListTile(
                  title: const Text("add product"),
                  leading: const Icon(Icons.upload),
                  onTap: () {
                    Navigator.pushNamed(context, "upload");
                  }),
                ListTile(
                    title: const Text("Settings"),
                    leading: const Icon(Icons.settings),
                    onTap: () async {
                      Navigator.pushNamed(context, "profile");
                    }),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: const Text("Developed by Mahmoud Atro © 2024",
                style: TextStyle(fontSize: 16)),
          )
        ],
      ),
    );
  }
}
