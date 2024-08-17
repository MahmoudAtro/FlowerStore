// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:storeapp/database/authintication.dart';
import 'package:storeapp/layouts/pagelayout.dart';
import 'package:storeapp/shared/color.dart';
import 'package:storeapp/shared/user.dart';
import 'package:storeapp/widgets/auth/updateuser.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Authintication user = Authintication();
  @override
  Widget build(BuildContext context) {
    return Pagelayout(
        title: "Profile",
        body: Padding(
          padding: const EdgeInsets.only(top: 22.0, left: 22.0, right: 22.0),
          child: SingleChildScrollView(
            child: Column(children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110),
                  ),
                  child: Stack(
                    children: [
                      UserAuth.getuserImage() == ""
                          ? CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 225, 225, 225),
                              radius: 71,
                              backgroundImage:
                                  AssetImage("images/userimage.jpeg"),
                            )
                          : CircleAvatar(
                              radius: 71,
                              backgroundImage:
                                  NetworkImage("${UserAuth.getuserImage()}")),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 33,
              ),
              Container(
                padding: EdgeInsets.all(11),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(11)),
                child: Text(
                  "User Informations",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 300,
                padding: EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                    color: appbarGreen,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      "Name: ${UserAuth.getUserUsername()} ",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      "Email: ${UserAuth.getUserEmail()} ",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      //
                      "Last Signed In: now ",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateProfile()));
                        },
                        child: Text(
                          "Update User",
                          style: TextStyle(fontSize: 18),
                        )),
                    SizedBox(
                      height: 22,
                    ),
                    Center(
                        child: MaterialButton(
                      onPressed: () async {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "login", (route) => false);
                        await user.Logout();
                      },
                      color: Colors.red[700],
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    )),
                  ],
                ),
              ),
            ]),
          ),
        ),
        isdrawer: false,
        isbasket: true,
        icon: Icons.person);
  }
}
