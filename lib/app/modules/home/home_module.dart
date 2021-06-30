import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:houseitems/app/modules/home/repositories/comodo_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:houseitems/app/modules/home/services/comodo_services.dart';
import '../home/home_store.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ComodoService(comodoRepository: i.get())),
    Bind.lazySingleton(
        (i) => ComodoRepository(firestore: FirebaseFirestore.instance)),
    Bind.lazySingleton((i) => HomeStore(comodoService: i.get())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];
}
