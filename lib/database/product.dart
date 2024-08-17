

import 'package:supabase_flutter/supabase_flutter.dart';

class UploadToSupabase {

  final client = Supabase.instance.client;

  addData(String name, int price , String url) async {
    var response = await client.from("products").insert({'name': name, 'price': price , "img" : url});
    return response;
  }

  Future<List<Map<String, dynamic>>> readData() async{
    List<Map<String, dynamic>> response =
        await client.from("products").select();
    return response;
  }

  void updateData(int id, int price) async {
    var response =
        await client.from("products").update({'price': price}).eq('id', id);
    print(response);
  }

  void deleteData(int id) async {
    var response = await client.from("products").delete().eq('id', id);
    print(response);
  }

}
