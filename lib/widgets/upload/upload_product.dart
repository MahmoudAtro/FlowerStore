import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storeapp/database/product.dart';
import 'package:storeapp/layouts/pagelayout.dart';
import 'package:storeapp/shared/userdecoration.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({super.key});

  @override
  State<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  var image;
  String path = "";
  String url = "";
  SupabaseClient supabase = Supabase.instance.client;
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  UploadToSupabase product = UploadToSupabase();
  bool isupload = true;
  @override
  Widget build(BuildContext context) {
    return Pagelayout(
        title: "upload",
        body: Container(
          padding: EdgeInsets.all(20.0),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    getphoto();
                  },
                  color: Colors.blue[500],
                  child: Text(
                    "Choose image",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                image != null
                    ? Container(
                        child: Image.file(image),
                      )
                    : // to show image
                    SizedBox(),
                SizedBox(
                  height: 10.0,
                ),
                Form(
                    child: Column(
                  children: [
                   TextFormField(
                keyboardType: TextInputType.text,
                controller: name,
                decoration: decoration.copyWith(
                    hintText: "enter your product name",
                    suffixIcon: const Icon(Icons.shopping_bag)),
              ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                keyboardType: TextInputType.text,
                controller: price,
                decoration: decoration.copyWith(
                    hintText: "enter your product price",
                    suffixIcon: const Icon(Icons.price_check)),
              ),
                  ],
                )),
                SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  onPressed: () {
                    setState(() {
                      isupload = false;
                    });
                    upload(context);
                  },
                  color: Colors.amber[500],
                  child: isupload
                      ? Text(
                          "upload",
                          style: TextStyle(color: Colors.white),
                        )
                      : CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3.0,
                        ),
                )
              ],
            ),
          ),
        ),
        isdrawer: false,
        isbasket: true,
        icon: Icons.upload);
  }

  getphoto() async {
    var pic = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pic!.path);
    });
  }

  upload(context) async {
    path = generateUniqueFileName(basename(image.path));
    await supabase.storage.from("images").upload(path, image);
    url = await supabase.storage.from("images").getPublicUrl(path);
    var response = await product.addData(name.text, int.parse(price.text), url);
    if (response == null) {
      setState(() {
        isupload = true;
      });
      clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("upload file successfuly"),
        backgroundColor: Colors.green,
      ));
    } else {
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
  void clear(){
    name.clear();
    price.clear();
    image = null;
  }
}
