import 'package:flutter/material.dart';
import 'package:storeapp/database/authintication.dart';
import 'package:storeapp/shared/buttons.dart';
import 'package:storeapp/shared/snackbar.dart';
import 'package:storeapp/shared/user.dart';
import 'package:storeapp/shared/userdecoration.dart';
import 'package:storeapp/widgets/auth/authpage.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  Authintication auth = Authintication();
  bool isshow = true;
  bool islogin = true;

  @override
  Widget build(BuildContext context) {
    return AuthPage(
        title: "Sign in",
        body: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: decoration.copyWith(
                            hintText: "enter your email",
                            suffixIcon: const Icon(Icons.email)),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: password,
                        obscureText: isshow,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        decoration: decoration.copyWith(
                            hintText: "enter your password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isshow = !isshow;
                                  });
                                },
                                icon: isshow
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off))),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              Btn(
                isregister: islogin,
                child: "Login",
                onPressed: () async {
                  setState(() {
                    islogin = false;
                  });
                  if (_key.currentState!.validate()) {
                    try {
                      await auth.Signin(password.text, email.text);
                      if (auth.client.auth.currentUser != null) {
                        setState(() {
                          islogin = true;
                        });
                        final data =
                            auth.client.auth.currentUser!.userMetadata as Map;
                        Navigator.pushNamedAndRemoveUntil(
                            context, "home", (route) => false);
                        UserAuth.setup(data);
                      } else {
                        setState(() {
                          islogin = true;
                        });
                        showSnackBar(context, "Invalid email or password");
                      }
                    } catch (e) {
                      showSnackBar(context, "ERROR :  ${e} ");
                    }
                  }
                  setState(() {
                    islogin = true;
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "rest");
                },
                child: Text(
                  "Forget Password?",
                  style: TextStyle(color: Colors.blue[900], fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'register', (route) => false);
                      },
                      child: const Text("Register",
                          style: TextStyle(color: Colors.blue, fontSize: 18))),
                ],
              ),
            ],
          ),
        ));
  }
}
