import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:houseitems/app/modules/home/models/comodo.dart';
import 'package:houseitems/app/modules/items/items_page.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:o_popup/o_popup.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comodos'),
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.popAndPushNamed(context, '/');
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: Observer(
        builder: (context) {
          if (store.comodoList.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<ComodoModel> list = store.comodoList.data;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (contenxt, index) {
                var comodo = list[index];
                return Card(
                  color: Color(int.parse(comodo.cardColor)),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ItemsPage(comodo.reference.id, comodo.nome)));
                    },
                    onLongPress: () {
                      dialogExcluir(context, comodo, store);
                    },
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text(
                        comodo.nome,
                        style: TextStyle(
                          color: Color(int.parse(comodo.textColor)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //store.saveComodo(ComodoModel(nome: "Teste"));
          dialogAddComodo(context, store);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

dialogExcluir(BuildContext context, ComodoModel comodo, HomeStore store) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atenção"),
          content: Text("Deseja excluir o comodo ${comodo.nome} ?"),
          actions: [
            ElevatedButton(
              child: Text(
                "Voltar",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Excluir"),
              onPressed: () {
                store.delete(comodo);
                Navigator.of(context).pop();
                snackShow(
                    context, 'Comodo ${comodo.nome} excluido com sucesso');
              },
            ),
          ],
        );
      });
}

snackShow(
  BuildContext context,
  String mensagem,
) {
  showTopSnackBar(context, CustomSnackBar.success(message: mensagem));
}

snackShowError(BuildContext context, String mensagem) {
  showTopSnackBar(context, CustomSnackBar.error(message: mensagem));
}

dialogAddComodo(
  BuildContext context,
  HomeStore store,
) {
  TextEditingController _comodoController = TextEditingController();
  String cardColor = '0xffffffff';
  String textColor = '0xff000000';

  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              body: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: MediaQuery.of(context).size.height - 80,
                  padding: EdgeInsets.all(20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        "Adicionar comodo",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: _comodoController,
                        decoration: InputDecoration(
                          labelText: "Nome do comodo",
                          hintText: "Nome do comodo",
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide()),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Cor do card: "),
                          SizedBox(
                            width: 8,
                          ),
                          OPopupTrigger(
                            barrierAnimationDuration:
                                Duration(milliseconds: 400),
                            triggerWidget: Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Container(
                                color: cardColor == '0xffffffff' ||
                                        cardColor == '4294967295'
                                    ? Colors.black
                                    : Colors.transparent,
                                child: Icon(
                                  Icons.format_paint,
                                  color: Color(int.parse(cardColor)),
                                ),
                              ),
                            ),
                            popupContent: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                OColorPicker(
                                  selectedColor: Color(int.parse(cardColor)),
                                  colors: primaryColorsPalette,
                                  onColorChange: (color) {
                                    setState(() {
                                      print(color.value);
                                      cardColor = color.value.toString();
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            ),

                            ///,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Cor do texto do card: "),
                          SizedBox(
                            width: 8,
                          ),
                          OPopupTrigger(
                            barrierAnimationDuration:
                                Duration(milliseconds: 400),
                            triggerWidget: Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Container(
                                color: textColor == '0xffffffff' ||
                                        textColor == '4294967295'
                                    ? Colors.black
                                    : Colors.transparent,
                                child: Icon(
                                  Icons.format_paint,
                                  color: Color(int.parse(textColor)),
                                ),
                              ),
                            ),
                            popupContent: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                OColorPicker(
                                  selectedColor: Color(int.parse(textColor)),
                                  colors: primaryColorsPalette,
                                  onColorChange: (color) {
                                    setState(() {
                                      textColor = color.value.toString();
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ],
                            ),

                            ///,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Voltar",
                            ),
                            //color: const Color(0xFF1BC0C5),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_comodoController.text.isNotEmpty) {
                                store.saveComodo(ComodoModel(
                                    nome: _comodoController.text,
                                    cardColor: cardColor,
                                    textColor: textColor));
                                Navigator.pop(context);
                                snackShow(context,
                                    'Comodo ${_comodoController.text} criado com sucesso');
                              } else {
                                snackShowError(
                                    context, 'Preencha o campo corretamente');
                              }
                            },
                            child: Text(
                              "Salvar",
                              style: TextStyle(color: Colors.white),
                            ),
                            //color: const Color(0xFF1BC0C5),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
