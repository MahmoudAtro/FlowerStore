import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static setup(Map user) async {
    await init();
    setIsLogin(true);
    await userUsername(user["name"]);
    await userEmail(user["email"]);
    await userImage(user["img"]);
  }

  static setIsLogin(bool islogin) async {
    await prefs.setBool('islogin', islogin);
  }

  static userEmail(String email) async {
    await prefs.setString('email', email);
  }

  static userUsername(String username) async {
    await prefs.setString('username', username);
  }

  static String getUserEmail() {
    return prefs.getString('email') ?? "User@email.com";
  }

  static String getUserUsername() {
    return prefs.getString('username') ?? "User";
  }

  static bool getIsLogin() {
    return prefs.getBool('islogin') ?? false;
  }

  static userToken(String token) async {
    await prefs.setString('token', token);
  }

  static String? getUserToken() {
    return prefs.getString('token');
  }

  static userImage(String img) async{
    await prefs.setString("img", img);
  }

  static String? getuserImage(){
    return prefs.getString("img") ?? "null";
  }

  static logout() async{
    await prefs.clear();
  }
}
