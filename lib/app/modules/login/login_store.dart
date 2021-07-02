import 'package:houseitems/app/modules/home/models/comodo.dart';
import 'package:houseitems/app/modules/home/services/interfaces/comodo_services_interface.dart';
import 'package:houseitems/app/modules/login/services/interfaces/usuario_services_interface.dart';
import 'package:mobx/mobx.dart';

import 'models/usuario.dart';

part 'login_store.g.dart';

class UsuarioStore = UsuarioStoreBase with _$UsuarioStore;

abstract class UsuarioStoreBase with Store {
  final IUsuarioService usuarioService;

  @observable
  UsuarioModel usuario;

  @observable
  String themeColor;

  @action
  changeColor(String newColor) {
    themeColor = newColor;
  }

  UsuarioStoreBase({this.usuarioService});

  @action
  login(String username, String password) {
    //usuario = usuarioService.login(username, password);
  }

  @action
  void save(UsuarioModel model) {
    usuarioService.save(model);
  }

  @action
  void delete(UsuarioModel model) {
    usuarioService.delete(model);
  }
}
