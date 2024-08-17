// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:storeapp/database/authintication.dart';
import 'package:storeapp/layouts/pagelayout.dart';
import 'package:storeapp/shared/user.dart';
import 'package:storeapp/shared/userdecoration.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  SupabaseClient supabase = Supabase.instance.client;
  var image;
  final name = TextEditingController();
  final email = TextEditingController();
  Authintication user = Authintication();
  final _key = GlobalKey<FormState>();
  bool isupload = true;
  String path = "";
  String url = "";

  uploadImage2Screen() async {
    final pickedImg =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    try {
      if (pickedImg != null) {
        setState(() {
          image = File(pickedImg.path);
        });
      } else {
        print("NO img selected");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  upload(context) async {
    path = generateUniqueFileName(basename(image.path));
    await supabase.storage.from("images").upload(path, image);
    url = supabase.storage.from("images").getPublicUrl(path);
    var response = await user.updateuser(email.text, name.text, url);
    if (response != null) {
      final data = user.client.auth.currentUser!.userMetadata as Map;
      UserAuth.setup(data);
      setState(() {
        isupload = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("upload file successfuly"),
        backgroundColor: Colors.green,
      ));
    } else {
      setState(() {
        isupload = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("failed upload"),
        backgroundColor: Colors.red,
      ));
    }
  }

  String generateUniqueFileName(String originalFileName) {
    var uuid = Uuid();
    var fileExtension = originalFileName.split('.').last;
    return '${uuid.v4()}.$fileExtension';
  }

 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.clear();
    email.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = UserAuth.getUserUsername();
    email.text = UserAuth.getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Pagelayout(
        title: "Update Profile",
        body: Padding(
          padding: const EdgeInsets.only(top: 22.0, left: 22.0, right: 22.0),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110),
                  ),
                  child: Stack(
                    children: [
                      image == null
                          ? CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 225, 225, 225),
                              radius: 71,
                              backgroundImage:
                                  UserAuth.getuserImage() == "" ? 
                                  AssetImage("images/userimage.jpeg") 
                                  :
                                  NetworkImage("${UserAuth.getuserImage()}")
                            )
                          : ClipOval(
                              child: Image.file(
                                image!,
                                width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                      Positioned(
                        left: 99,
                        bottom: -10,
                        child: IconButton(
                          onPressed: () {
                            uploadImage2Screen();
                          },
                          icon: const Icon(Icons.add_a_photo),
                          color: Color.fromARGB(255, 94, 115, 128),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 33,
              ),
              Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        decoration:
                            decoration.copyWith(suffixIcon: Icon(Icons.person)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration:
                            decoration.copyWith(suffixIcon: Icon(Icons.email)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                          onPressed: () async {
                            if (_key.currentState!.validate()) {
                              setState(() {
                                isupload = false;
                              });
                              upload(context);
                            }
                          },
                          color: Colors.green[700],
                          child: isupload
                              ? Text(
                                  'Upload',
                                  style: TextStyle(color: Colors.white),
                                )
                              : CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                    ],
                  ))
            ]),
          ),
        ),
        isdrawer: false,
        isbasket: true,
        icon: Icons.settings);
  }
}
