import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:houseitems/app/modules/items/models/items.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:o_popup/o_popup.dart';
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
  bool filtroPrioridade = false;
  bool filtroValor = false;

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
        actions: [
          PopupMenuButton(
              icon: Icon(Icons.filter_list_outlined),
              tooltip: 'Filtro',
              onSelected: (value) {
                if (value == 'prioridade') {
                  filtroPrioridade = !filtroPrioridade;
                  if (filtroPrioridade) {
                    store.addFiltro('prioridade');
                    store.getItemsList(widget.comodoReference);
                  } else {
                    store.removeFiltro('prioridade');
                    store.getItemsList(widget.comodoReference);
                  }
                } else if (value == 'valor') {
                  filtroValor = !filtroValor;
                  if (filtroValor) {
                    store.addFiltro('valor');
                    store.getItemsList(widget.comodoReference);
                  } else {
                    store.removeFiltro('valor');
                    store.getItemsList(widget.comodoReference);
                  }
                }
              },
              itemBuilder: (BuildContext context) => [
                    CheckedPopupMenuItem(
                      value: 'prioridade',
                      checked: filtroPrioridade,
                      child: Text("Prioridade"),
                    ),
                    CheckedPopupMenuItem(
                      value: 'valor',
                      checked: filtroValor,
                      child: Text("Preço"),
                    ),
                  ])
        ],
      ),
      body: Observer(
        builder: (context) {
          if (store.itemsList.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<ItemsModel> list = store.itemsList.data;
            var valorTotalPendente = 0.0;
            var valorTotalAdquirido = 0.0;
            list.forEach((element) {
              if (!element.jaTem) {
                valorTotalPendente += element.valor;
              } else if (element.jaTem) {
                valorTotalAdquirido += element.valor;
              }
            });
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (contenxt, index) {
                      var item = list[index];
                      return Card(
                        color: Color(int.parse(item.cardColor)),
                        child: InkWell(
                          onTap: () => dialogAddItemComodo(
                              context, store, widget.comodoReference,
                              item: list[index]),
                          onLongPress: () {
                            dialogExcluir(context, list[index], store);
                          },
                          child: ListTile(
                            leading: Icon(Icons.inventory),
                            title: Text(
                              item.nome,
                              style: TextStyle(
                                  color: !item.escolherCorTexto
                                      ? item.jaTem
                                          ? Colors.green
                                          : Colors.red
                                      : Color(int.parse(item.textColor))),
                            ),
                            trailing: Text("R\$ ${item.valor}"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(
                        "Valores a pagar do comodo: R\$ $valorTotalPendente" +
                            "\nValores de itens adquiridos: R\$ $valorTotalAdquirido"),
                  ),
                )
              ],
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
  bool escolherCorText = item != null ? item.escolherCorTexto : false;

  if (item != null) {
    _nomeItemController.text = item.nome;
    _quantidadeItemController.text = item.quantidade.toString();
    _valorItemController.text = item.valor.toString();
  }

  String newCardColor = item.cardColor;
  String newTextColor = item.textColor;

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
                      decoration: InputDecoration(
                        hintText: "Nome do item",
                        labelText: "Nome do item",
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide()),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
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
                      decoration: InputDecoration(
                        hintText: "Quantidade",
                        labelText: 'Quantidade',
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide()),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
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
                      decoration: InputDecoration(
                        hintText: "Valor total (R\$)",
                        labelText: "Valor total (R\$)",
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide()),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
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
                          barrierAnimationDuration: Duration(milliseconds: 400),
                          triggerWidget: Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Container(
                              color: newCardColor == '0xffffffff' ||
                                      newCardColor == '4294967295'
                                  ? Colors.black
                                  : Colors.transparent,
                              child: Icon(
                                Icons.format_paint,
                                color: Color(int.parse(newCardColor)),
                              ),
                            ),
                          ),
                          popupContent: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              OColorPicker(
                                selectedColor: Color(int.parse(newCardColor)),
                                colors: primaryColorsPalette,
                                onColorChange: (color) {
                                  setState(() {
                                    print(color.value);
                                    newCardColor = color.value.toString();
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
                    CheckboxListTile(
                      value: escolherCorText,
                      onChanged: (newValue) {
                        setState(() {
                          escolherCorText = newValue;
                        });
                      },
                      title: Text('Escolher cor do texto?'),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    escolherCorText
                        ? Row(
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
                                    color: newTextColor == '0xffffffff' ||
                                            newTextColor == '4294967295'
                                        ? Colors.black
                                        : Colors.transparent,
                                    child: Icon(
                                      Icons.format_paint,
                                      color: Color(int.parse(newTextColor)),
                                    ),
                                  ),
                                ),
                                popupContent: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    OColorPicker(
                                      selectedColor:
                                          Color(int.parse(newTextColor)),
                                      colors: primaryColorsPalette,
                                      onColorChange: (color) {
                                        setState(() {
                                          newTextColor = color.value.toString();
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
                          )
                        : Container(
                            width: 0,
                            height: 0,
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
                                          cardColor: newCardColor,
                                          escolherCorTexto: escolherCorText,
                                          textColor: newTextColor,
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
                                          cardColor: newCardColor,
                                          textColor: newTextColor,
                                          escolherCorTexto: escolherCorText,
                                          jaTem: jaPossui),
                                      comodoReference);
                              store.getItemsList(comodoReference);
                              snackShow(context,
                                  'Item ${_nomeItemController.text} adicionado e/ou alterado');
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
