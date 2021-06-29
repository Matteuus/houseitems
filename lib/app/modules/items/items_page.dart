import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:houseitems/app/modules/items/models/items.dart';

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
        title: Text(widget.nomeComdo),
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
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
