import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:houseitems/app/modules/items/items_store.dart';
import 'package:houseitems/app/modules/items/services/items_service.dart';
import 'package:houseitems/app/modules/items/repositories/items_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:houseitems/app/modules/login/login_module.dart';

import 'modules/home/home_module.dart';
import 'modules/items/items_module.dart';
import 'modules/login/login_store.dart';
import 'modules/login/repositories/usuario_repository.dart';
import 'modules/login/services/usuario_services.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ItemsService(itemsRepository: i.get())),
    Bind.lazySingleton(
        (i) => ItemsRepository(firestore: FirebaseFirestore.instance)),
    Bind.lazySingleton((i) => ItemsStore(itemsService: i.get())),
    Bind.lazySingleton((i) => UsuarioService(usuarioRepository: i.get())),
    Bind.lazySingleton(
        (i) => UsuarioRepository(firestore: FirebaseFirestore.instance)),
    Bind.lazySingleton((i) => UsuarioStore(usuarioService: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: LoginModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/items', module: ItemsModule()),
  ];
}
