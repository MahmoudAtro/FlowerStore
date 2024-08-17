import 'package:flutter/material.dart';
import 'package:storeapp/database/authintication.dart';
import 'package:storeapp/shared/buttons.dart';
import 'package:storeapp/shared/snackbar.dart';
import 'package:storeapp/shared/user.dart';
import 'package:storeapp/shared/userdecoration.dart';
import 'package:storeapp/widgets/auth/authpage.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  Authintication auth = Authintication();

  UserAuth user = UserAuth();

  bool isshow = true;
  bool isregister = true;

  bool isPassword6Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;

  onPasswordChanged(String password) {
    isPassword6Char = false;
    isPasswordHas1Number = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'.{6,}'))) {
        isPassword6Char = true;
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        isPasswordHas1Number = true;
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }

      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      }
    });
  }

  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AuthPage(
        title: "Register",
        body: Container(
          alignment: Alignment.center,
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                    key: _key,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: decoration.copyWith(
                              hintText: "enter your name",
                              suffixIcon: const Icon(Icons.person)),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (password) {
                            onPasswordChanged(password);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (!value.contains(RegExp(r'[0-9]'))) {
                              return 'Password should contain number';
                            }
                            if (!value.contains(RegExp(r'[A-Z]'))) {
                              return 'Password should not contain uppercase letter';
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
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isPassword6Char
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 189, 189, 189))),
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            Text("At least 6 characters"),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isPasswordHas1Number
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 189, 189, 189))),
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            Text("At least 1 number"),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: hasUppercase
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 189, 189, 189))),
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            Text("Has UpperCase"),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 15,
                              ),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: hasLowercase
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(
                                      color:
                                          Color.fromARGB(255, 189, 189, 189))),
                            ),
                            SizedBox(
                              width: 11,
                            ),
                            Text("Has LowerCase"),
                          ],
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
                Btn(
                    isregister: isregister,
                    child: "Register",
                    onPressed: () async {
                      setState(() {
                        isregister = false;
                      });
                      if (_key.currentState!.validate()) {
                        try {
                          var response = await auth.Signup(
                              password.text, email.text, name.text);
                          if (response.user != null) {
                            setState(() {
                              isregister = true;
                            });
                            print("response user = ${response.user}");
                            print(
                                "response metadata = ${response.user.userMetadata['email']}");
                            final data = auth
                                .client.auth.currentUser!.userMetadata as Map;
                            Navigator.pushNamedAndRemoveUntil(
                                context, "home", (route) => false);
                            UserAuth.setup(data);
                          } else {
                            setState(() {
                              isregister = true;
                            });
                            print(response);
                            showSnackBar(context, "Invalid email or password");
                          }
                        } catch (e) {
                          showSnackBar(context, "ERROR :  ${e} ");
                        }
                      }
                      setState(() {
                        isregister = true;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "already have an account?",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, 'login', (route) => false);
                        },
                        child: const Text("Login",
                            style:
                                TextStyle(color: Colors.blue, fontSize: 18))),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
