import 'package:flutter/material.dart';
import 'package:loja_app/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/cart_model.dart';
import 'models/user_model.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
          builder: (context,child,model){
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                title: "Flutter's Clothing",
                color: Color.fromARGB(255, 4, 125, 141),
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                debugShowCheckedModeBanner: false,
                home: HomeScreen(),
              ),
            );
          }
      )
    );
  }
}

