import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../models/items.dart';

import 'interfaces/items_repository_interface.dart';

class ItemsRepository extends Disposable implements IitemsRepository {
  final FirebaseFirestore firestore;

  ItemsRepository({@required this.firestore});

  //dispose will be called automatically
  @override
  void dispose() {}

  @override
  Stream<List<ItemsModel>> get(String comodoReference) {
    return firestore
        .collection('comodo')
        .doc(comodoReference)
        .collection('items')
        .snapshots()
        .map((query) =>
            query.docs.map((doc) => ItemsModel.fromDocument(doc)).toList());
  }

  @override
  Future<Stream<ItemsModel>> getByDocumentId(
      String comodoReference, String documentId) async {
    return firestore
        .collection('comodo')
        .doc(comodoReference)
        .collection('items')
        .doc(documentId)
        .snapshots()
        .map((doc) => ItemsModel.fromDocument(doc));
  }

  @override
  Future save(ItemsModel model, String comodoReference) async {
    if (model.reference == null) {
      model.reference = await FirebaseFirestore.instance
          .collection('comodo')
          .doc(comodoReference)
          .collection('items')
          .add({
        'nome': model.nome,
        'valor': model.valor,
        'prioridade': model.prioridade,
        'jaTem': model.jaTem,
        'quantidade': model.quantidade
      });
    } else {
      model.reference.update({
        'nome': model.nome,
        'valor': model.valor,
        'prioridade': model.prioridade,
        'jaTem': model.jaTem,
        'quantidade': model.quantidade
      });
    }
  }

  Future delete(ItemsModel model) {
    return model.reference.delete();
  }
}
