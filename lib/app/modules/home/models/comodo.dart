import 'package:cloud_firestore/cloud_firestore.dart';

class ComodoModel {
  String nome;
  int id;
  DocumentReference reference;

  ComodoModel({
    this.nome = '',
    this.reference,
    this.id,
  });

  factory ComodoModel.fromDocument(DocumentSnapshot doc) {
    return ComodoModel(
      nome: doc['nome'],
      reference: doc.reference,
    );
  }

  factory ComodoModel.fromJson(Map<String, dynamic> json) {
    return ComodoModel(nome: json['nome'], id: json['id']);
  }

  Map<String, dynamic> toJson() => {};

  @override
  String toString() {
    return 'Nome: ${this.nome} Referencia: ${this.reference} ';
  }
}
