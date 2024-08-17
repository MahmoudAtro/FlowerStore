import 'package:flutter/material.dart';
import 'package:storeapp/Provider/cart.dart';
import 'package:storeapp/widgets/HomePage.dart';
import 'package:storeapp/widgets/Orders.dart';
import 'package:storeapp/widgets/auth/login.dart';
import 'package:storeapp/widgets/auth/profile.dart';
import 'package:storeapp/widgets/auth/register.dart';
import 'package:storeapp/widgets/auth/restpass.dart';
import 'package:provider/provider.dart';
import 'package:storeapp/widgets/upload/upload_product.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://agbeaccpwuofyzpywzin.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFnYmVhY2Nwd3VvZnl6cHl3emluIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjMyOTE0NjIsImV4cCI6MjAzODg2NzQ2Mn0.dqb2tMAWyLRuTlw_Zqas8avP7_bfw1oc9sgdoVlXezM",
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final user = Supabase.instance.client.auth.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Cart(),
      child: MaterialApp(
        title: 'Store App',
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: user == null ? Login() : Homepage(),
        routes: {
          'home': (context) => Homepage(),
          "login": (context) => Login(),
          "register": (context) => Register(),
          "rest": (context) => Restpass(),
          "upload" : (context) => UploadProduct(),
          "order" : (context) => Orders(),
          "profile" : (context) => ProfilePage(),
        },
      ),
    );
  }
}
