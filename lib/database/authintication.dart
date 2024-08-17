import 'package:supabase_flutter/supabase_flutter.dart';

class Authintication {
  SupabaseClient client = Supabase.instance.client;

  Signup(String password, String email, String name) async {
    var response = await client.auth
        .signUp(password: password, email: email , data: {"name": name , "role" : "user", "img" : "null"});
    return response;
  }

  Signin(String password, String email) async {
      var response = await client.auth
          .signInWithPassword(email: email, password: password);
      return response;
  }

  Logout() async {
    var response = await client.auth.signOut();
    return response;
  }

  restPassword(String email)async{
    var response = await client.auth.resetPasswordForEmail(email);
    return response;
  }

  updateuser(String email, String name , String img)async{
    var response = await client.auth.updateUser(UserAttributes(email: email , data: {
      "name" : name,
      "img" : img,
    }));
    return response;
  }
}
