import 'package:supabase/supabase.dart';

class SupabaseRandler {
  static String url = "https://agbeaccpwuofyzpywzin.supabase.co";
  static String apiKey =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFnYmVhY2Nwd3VvZnl6cHl3emluIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjMyOTE0NjIsImV4cCI6MjAzODg2NzQ2Mn0.dqb2tMAWyLRuTlw_Zqas8avP7_bfw1oc9sgdoVlXezM";

  final client = SupabaseClient(url, apiKey);

  void addData(String task, bool status) async {
    var response = client.from("todo").insert({'task': task, 'status': status});
    print(response);
  }

  readData() async {
    List<Map<String, dynamic>> response =
        await client.from("todo").select();
    return response;
  }

  void updateData(int id, bool status) async {
    var response =
        await client.from("todo").update({'status': status}).eq('id', id);
    print(response);
  }

  void deleteData(int id) async {
    var response = await client.from("todo").delete().eq('id', id);
    print(response);
  }

  signup(String password , String email , String name)async{
    var response = await client.auth.signUp(password: password , email: email , data: {"name" : name}
    );
    print(response);
  }
}
