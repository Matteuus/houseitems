import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../models/comodo.dart';

import 'interfaces/comodo_repository_interface.dart';

class ComodoRepository extends Disposable implements IComodoRepository {
  final FirebaseFirestore firestore;

  ComodoRepository({@required this.firestore});

  //dispose will be called automatically
  @override
  void dispose() {}

  @override
  Stream<List<ComodoModel>> get() {
    return firestore.collection('comodo').snapshots().map((query) =>
        query.docs.map((doc) => ComodoModel.fromDocument(doc)).toList());
  }

  @override
  Future<Stream<ComodoModel>> getByDocumentId(String documentId) async {
    return firestore
        .collection('comodo')
        .doc(documentId)
        .snapshots()
        .map((doc) => ComodoModel.fromDocument(doc));
  }

  @override
  Future save(ComodoModel model) async {
    if (model.reference == null) {
      model.reference =
          await FirebaseFirestore.instance.collection('comodo').add({
        'nome': model.nome,
      });
    } else {
      model.reference.update({
        'nome': model.nome,
      });
    }
  }

  Future delete(ComodoModel model) {
    return model.reference.delete();
  }
}
