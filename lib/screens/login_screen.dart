import 'package:flutter/material.dart';
import 'package:loja_app/models/user_model.dart';
import 'package:loja_app/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text("CRIAR CONTA",
              style: TextStyle(fontSize: 15),
            ),
            textColor: Colors.white,
            onPressed: (){           //para criar e logar
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => SignUpScreen())
              );
            },
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model){
          if(model.isLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "E-mail"
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text){
                    if(text.isEmpty || !text.contains("@")){
                      return "E-mail Inválido";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16,),
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Senha"
                  ),
                  obscureText: true,
                  validator: (text){
                    if(text.isEmpty || text.length <6){
                      return "Senha Inválida";
                    }
                    return null;
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: (){},
                    child: Text("Esqueci minha Senha",
                      textAlign: TextAlign.right,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ),
                SizedBox(height: 16,),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: (){
                      if(_formKey.currentState.validate()){

                      }
                      model.signIn();
                    },
                    child: Text("Entrar",
                      style: TextStyle(fontSize: 18),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}