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
  Stream<List<ItemsModel>> get(String comodoReference, {List<String> filtros}) {
    if (filtros != null && filtros.isNotEmpty) {
      if (filtros.length < 2) {
        return firestore
            .collection('comodo')
            .doc(comodoReference)
            .collection('items')
            .orderBy(filtros[0].isNotEmpty ? filtros[0] : '', descending: true)
            .snapshots()
            .map((query) =>
                query.docs.map((doc) => ItemsModel.fromDocument(doc)).toList());
      } else {
        return firestore
            .collection('comodo')
            .doc(comodoReference)
            .collection('items')
            .orderBy(filtros[0].isNotEmpty ? filtros[0] : '', descending: true)
            .orderBy(filtros[1].isNotEmpty ? filtros[1] : '', descending: true)
            .snapshots()
            .map((query) =>
                query.docs.map((doc) => ItemsModel.fromDocument(doc)).toList())
            .handleError((error) {
          print(error);
        });
      }
    } else {
      return firestore
          .collection('comodo')
          .doc(comodoReference)
          .collection('items')
          .snapshots()
          .map((query) =>
              query.docs.map((doc) => ItemsModel.fromDocument(doc)).toList());
    }
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
        'cardColor': model.cardColor,
        'textColor': model.textColor,
        'escolherCorTexto': model.escolherCorTexto,
        'quantidade': model.quantidade
      });
    } else {
      model.reference.update({
        'nome': model.nome,
        'valor': model.valor,
        'prioridade': model.prioridade,
        'jaTem': model.jaTem,
        'cardColor': model.cardColor,
        'textColor': model.textColor,
        'escolherCorTexto': model.escolherCorTexto,
        'quantidade': model.quantidade
      });
    }
  }

  Future delete(ItemsModel model) {
    return model.reference.delete();
  }
}
