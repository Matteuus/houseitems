import 'package:flutter/material.dart';
import 'package:houseitems/app/modules/home/home_module.dart';
import 'package:houseitems/app/modules/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
            margin: EdgeInsets.only(top: 128, bottom: 128, left: 64, right: 64),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: _senhaController,
                    decoration: InputDecoration(hintText: "Senha"),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_senhaController.text.isNotEmpty &&
                        _senhaController.text == "0101") {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      _senhaController.clear();
                    }
                  },
                  child: Text("Entrar"),
                )
              ],
            )),
      ),
    );
  }
}
