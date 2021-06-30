import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../models/usuario.dart';
import '../repositories/interfaces/usuario_repository_interface.dart';

import 'interfaces/usuario_services_interface.dart';

class UsuarioService extends Disposable implements IUsuarioService {
  //dispose will be called automatically
  @override
  void dispose() {}

  final IUsuarioRepository usuarioRepository;
  UsuarioService({@required this.usuarioRepository});

  @override
  Future delete(UsuarioModel model) {
    return usuarioRepository.delete(model);
  }

  @override
  Stream<List<UsuarioModel>> get() {
    return usuarioRepository.get();
  }

  @override
  Future<UsuarioModel> login(String username, String password) {
    return usuarioRepository.login(username, password);
  }

  @override
  Future save(UsuarioModel model) {
    return usuarioRepository.save(model);
  }
}
