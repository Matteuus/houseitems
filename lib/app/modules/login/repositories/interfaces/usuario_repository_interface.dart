import '../../models/usuario.dart';

abstract class IUsuarioRepository {
  Stream<List<UsuarioModel>> get();
  Future<UsuarioModel> login(String username, String password);
  Future save(UsuarioModel model);
  Future delete(UsuarioModel model);
  Future<Stream<UsuarioModel>> getByDocumentId(String documentId);
}
