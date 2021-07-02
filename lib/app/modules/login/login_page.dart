import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:houseitems/app/modules/login/login_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:o_popup/o_popup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, UsuarioStore> {
  TextEditingController _usuarioController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.popAndPushNamed(context, '/home');
      }
    });
    //para quando for testar
    // _usuarioController.text = 'mano.mateus2012@gmail.com';
    // _senhaController.text = '08051997';
    getTheme().then((value) => store.themeColor = value);
  }

  Future<bool> changeTheme(String newColorTheme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('appTheme', newColorTheme);
  }

  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('appTheme') ?? '0xff000000';
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (store.themeColor == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: [
                OPopupTrigger(
                  barrierAnimationDuration: Duration(milliseconds: 400),
                  triggerWidget: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(
                      Icons.format_paint,
                      color: Color(int.parse(store.themeColor)),
                    ),
                  ),
                  popupContent: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      OColorPicker(
                        selectedColor: Color(int.parse(store.themeColor)),
                        colors: primaryColorsPalette,
                        onColorChange: (color) {
                          setState(() {
                            changeTheme(color.value.toString()).then((value) {
                              if (value) {
                                store.changeColor(color.value.toString());
                              }
                            });
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),

                  ///,
                ),
              ],
            ),
            body: Center(
                child: SingleChildScrollView(
              child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 128),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          controller: _usuarioController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "email",
                            labelText: "email",
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide()),
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextFormField(
                          controller: _senhaController,
                          decoration: InputDecoration(
                            hintText: "Senha",
                            labelText: "Senha",
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide()),
                            border:
                                OutlineInputBorder(borderSide: BorderSide()),
                          ),
                          obscureText: true,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_senhaController.text.isNotEmpty &&
                              _usuarioController.text.isNotEmpty) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _usuarioController.text,
                                      password: _senhaController.text)
                                  .then((value) {
                                if (value.user != null) {
                                  Navigator.popAndPushNamed(context, '/home');
                                }
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                snackShow(context,
                                    'Nenhum usuário encontrado para esse email');
                                print(
                                    'Nenhum usuário encontrado para esse email');
                              } else if (e.code == 'wrong-password') {
                                snackShow(
                                    context, 'Senha errada para esse usuário');
                                print('Senha errada para esse usuário');
                              }
                            }
                          } else {
                            _usuarioController.clear();
                            _senhaController.clear();
                            snackShow(context, 'Digite o e-mail e senha');
                          }
                        },
                        child: Text("Entrar"),
                      ),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  )),
            )),
          );
        }
      },
    );
  }
}

snackShow(BuildContext context, String mensagem) {
  showTopSnackBar(context, CustomSnackBar.error(message: mensagem));
}
