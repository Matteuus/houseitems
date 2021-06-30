import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:houseitems/app/modules/login/login_store.dart';
import 'package:houseitems/app/modules/login/repositories/usuario_repository.dart';
import 'package:houseitems/app/modules/login/services/usuario_services.dart';

import 'login_page.dart';

class LoginModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => UsuarioService(usuarioRepository: i.get())),
    Bind.lazySingleton(
        (i) => UsuarioRepository(firestore: FirebaseFirestore.instance)),
    Bind.lazySingleton((i) => UsuarioStore(usuarioService: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => LoginPage()),
  ];
}
