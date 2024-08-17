import 'package:flutter/material.dart';
import 'package:storeapp/database/product.dart';
import 'package:storeapp/layouts/pagelayout.dart';
import 'package:storeapp/layouts/pagewidget.dart';
import 'package:storeapp/shared/user.dart';

// ignore: must_be_immutable
class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  UploadToSupabase supbase = UploadToSupabase();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserAuth.init();
  }

  @override
  Widget build(BuildContext context) {
    return Pagelayout(
      isbasket: false,
      icon: Icons.home,
      isdrawer: true,
      title: "Home",
      body: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: FutureBuilder <List<Map<String, dynamic>>>(
        future: supbase.readData(),
        builder: (context , AsyncSnapshot<List<Map<String, dynamic>>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError) {
            return Center(child: Text("${snapshot.hasError}" , style: TextStyle(color: Colors.red, fontSize: 15.0),),);
          }
          if(snapshot.hasData){
            return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 33,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, index) {
              return Pagewidget(product: snapshot.data![index]);
            });
          }
          return Text("Error in show product , try again.");
        } 
        ),
      ),
    );
  }
}
