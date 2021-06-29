import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:houseitems/app/modules/home/models/comodo.dart';
import 'package:houseitems/app/modules/items/items_page.dart';

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
                      title: Text(comodo.nome),
                      trailing: Icon(Icons.arrow_forward_ios),
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
          content: Text("Deseja excluir o comdo ${comodo.nome} ?"),
          actions: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              child: Text(
                "Voltar",
                style: TextStyle(color: Colors.blue),
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
              },
            ),
          ],
        );
      });
}

dialogAddComodo(BuildContext context, HomeStore store) {
  TextEditingController _comodoController = TextEditingController();

  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Scaffold(
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 10,
              height: MediaQuery.of(context).size.height - 80,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  Text("Adicionar Comodo"),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _comodoController,
                    decoration: InputDecoration(hintText: "Nome do comodo"),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Voltar",
                          style: TextStyle(color: Colors.blue),
                        ),
                        //color: const Color(0xFF1BC0C5),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_comodoController.text.isNotEmpty) {
                            store.saveComodo(
                                ComodoModel(nome: _comodoController.text));
                            Navigator.pop(context);
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
      });
}
