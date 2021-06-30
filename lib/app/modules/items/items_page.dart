import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:houseitems/app/modules/items/models/items.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'items_store.dart';

class ItemsPage extends StatefulWidget {
  final String comodoReference;
  final String nomeComdo;
  final String title;
  const ItemsPage(this.comodoReference, this.nomeComdo,
      {Key key, this.title = "Home"})
      : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends ModularState<ItemsPage, ItemsStore> {
  @override
  void initState() {
    store.getItemsList(widget.comodoReference);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nomeComdo != null ? widget.nomeComdo : ''),
      ),
      body: Observer(
        builder: (context) {
          if (store.itemsList.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<ItemsModel> list = store.itemsList.data;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (contenxt, index) {
                var item = list[index];
                return Card(
                  child: InkWell(
                    onTap: () => dialogAddItemComodo(
                        context, store, widget.comodoReference,
                        item: list[index]),
                    onLongPress: () {
                      dialogExcluir(context, list[index], store);
                    },
                    child: ListTile(
                      leading: Icon(Icons.inventory),
                      title: Text(item.nome),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            dialogAddItemComodo(context, store, widget.comodoReference),
        child: Icon(Icons.add),
      ),
    );
  }
}

dialogExcluir(BuildContext context, ItemsModel item, ItemsStore store) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Atenção"),
          content: Text("Deseja excluir o item ${item.nome} ?"),
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
                store.delete(item);
                Navigator.of(context).pop();
                snackShow(context, '${item.nome} excluido com sucesso');
              },
            ),
          ],
        );
      });
}

snackShow(BuildContext context, String mensagem) {
  showTopSnackBar(context, CustomSnackBar.success(message: mensagem));
}

snackShowError(BuildContext context, String mensagem) {
  showTopSnackBar(context, CustomSnackBar.error(message: mensagem));
}

dialogAddItemComodo(
    BuildContext context, ItemsStore store, String comodoReference,
    {ItemsModel item}) {
  TextEditingController _nomeItemController = TextEditingController();
  TextEditingController _quantidadeItemController = TextEditingController();
  TextEditingController _valorItemController = TextEditingController();
  double _prioridade = item != null ? item.prioridade : 1;
  bool jaPossui = item != null ? item.jaTem : false;

  if (item != null) {
    _nomeItemController.text = item.nome;
    _quantidadeItemController.text = item.quantidade.toString();
    _valorItemController.text = item.valor.toString();
  }

  showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return StatefulBuilder(
            builder: (BuildContext buildContext, StateSetter setState) {
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
                      "Adicionar Item no comodo",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _nomeItemController,
                      decoration: InputDecoration(hintText: "Nome do item"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _quantidadeItemController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(hintText: "Quantidade"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _valorItemController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration:
                          InputDecoration(hintText: "Valor total (R\$)"),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Prioridade'),
                    Slider(
                      value: _prioridade,
                      min: 1,
                      max: 3,
                      divisions: 2,
                      label: _prioridade.round().toString() == '1'
                          ? 'Baixa'
                          : _prioridade.round().toString() == '2'
                              ? 'Média'
                              : _prioridade.round().toString() == '3'
                                  ? 'Alta'
                                  : '',
                      onChanged: (double value) {
                        setState(() {
                          print(value);
                          _prioridade = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    CheckboxListTile(
                      value: jaPossui,
                      onChanged: (newValue) {
                        setState(() {
                          jaPossui = newValue;
                        });
                      },
                      title: Text('Já possui'),
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
                            if (_nomeItemController.text.isNotEmpty &&
                                _quantidadeItemController.text.isNotEmpty &&
                                _valorItemController.text.isNotEmpty) {
                              item != null
                                  ? store.saveItem(
                                      ItemsModel(
                                          nome: _nomeItemController.text,
                                          quantidade: int.parse(
                                              _quantidadeItemController.text),
                                          valor: double.parse(
                                              _valorItemController.text),
                                          prioridade: _prioridade.toInt(),
                                          reference: item.reference,
                                          jaTem: jaPossui),
                                      comodoReference)
                                  : store.saveItem(
                                      ItemsModel(
                                          nome: _nomeItemController.text,
                                          quantidade: int.parse(
                                              _quantidadeItemController.text),
                                          valor: double.parse(
                                              _valorItemController.text),
                                          prioridade: _prioridade.toInt(),
                                          jaTem: jaPossui),
                                      comodoReference);
                              store.getItemsList(comodoReference);
                              snackShow(context,
                                  'Item ${_nomeItemController.text} adicionado ao comdo');
                              Navigator.pop(context);
                            } else {
                              snackShowError(context,
                                  'Preencha todos os campos corretamente');
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
      });
}
