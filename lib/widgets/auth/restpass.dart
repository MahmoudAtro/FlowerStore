import 'package:flutter/material.dart';
import 'package:storeapp/database/authintication.dart';
import 'package:storeapp/shared/buttons.dart';
import 'package:storeapp/shared/userdecoration.dart';
import 'package:storeapp/widgets/auth/authpage.dart';

// ignore: must_be_immutable
class Restpass extends StatelessWidget {
  Restpass({super.key});

  TextEditingController email = TextEditingController();
  Authintication user = Authintication();
  GlobalKey<FormState> _key = GlobalKey();
  bool issend = true;

  @override
  Widget build(BuildContext context) {
    return AuthPage(
        title: "Rest Password",
        body: Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "enter your email to rest password",
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height: 15.0,
              ),
              Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: email,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        decoration: decoration.copyWith(
                            hintText: "enter your email",
                            suffixIcon: Icon(Icons.email)),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Btn(
                isregister: issend,
                child: "Rest Password",
                onPressed: () async {
                  if (_key.currentState!.validate()) {
                    var response = await user.restPassword(email.text);
                    print(response);
                    if (response == true) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "password rested successfully",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ));
                    } else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("error")));
                    }
                  }
                },
              ),
            ])));
  }
}
