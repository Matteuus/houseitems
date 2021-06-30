import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../models/usuario.dart';

import 'interfaces/usuario_repository_interface.dart';

class UsuarioRepository extends Disposable implements IUsuarioRepository {
  final FirebaseFirestore firestore;

  UsuarioRepository({@required this.firestore});

  //dispose will be called automatically
  @override
  void dispose() {}

  @override
  Stream<List<UsuarioModel>> get() {
    return firestore.collection('usuario').snapshots().map((query) =>
        query.docs.map((doc) => UsuarioModel.fromDocument(doc)).toList());
  }

  @override
  Future<UsuarioModel> login(String username, String password) async {
    QuerySnapshot result = await firestore
        .collection('usuario')
        .where('nickname', isEqualTo: username)
        .get();
  }

  @override
  Future<Stream<UsuarioModel>> getByDocumentId(String documentId) async {
    return firestore
        .collection('usuario')
        .doc(documentId)
        .snapshots()
        .map((doc) => UsuarioModel.fromDocument(doc));
  }

  @override
  Future save(UsuarioModel model) async {
    if (model.reference == null) {
      model.reference =
          await FirebaseFirestore.instance.collection('usuario').add({
        'nome': model.nome,
        'email': model.email,
        'nickname': model.nickname,
        'senha': model.senha
      });
    } else {
      model.reference.update({
        'nome': model.nome,
        'email': model.email,
        'nickname': model.nickname,
        'senha': model.senha
      });
    }
  }

  Future delete(UsuarioModel model) {
    return model.reference.delete();
  }
}
