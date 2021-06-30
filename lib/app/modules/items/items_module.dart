import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:houseitems/app/modules/items/items_page.dart';
import 'package:houseitems/app/modules/items/items_store.dart';
import 'package:houseitems/app/modules/items/repositories/items_repository.dart';
import 'package:houseitems/app/modules/items/services/items_service.dart';

class ItemsModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ItemsService(itemsRepository: i.get())),
    Bind.lazySingleton(
        (i) => ItemsRepository(firestore: FirebaseFirestore.instance)),
    Bind.lazySingleton((i) => ItemsStore(itemsService: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:id/:nome',
        child: (_, args) => ItemsPage(args.params['id'], args.params['nome'])),
  ];
}
