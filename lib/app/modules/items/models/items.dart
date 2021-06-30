import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsModel {
  String nome;
  double valor;
  int prioridade;
  bool jaTem;
  int quantidade;
  DocumentReference reference;

  ItemsModel({
    this.nome = '',
    this.valor,
    this.prioridade,
    this.jaTem,
    this.quantidade,
    this.reference,
  });

  factory ItemsModel.fromDocument(DocumentSnapshot doc) {
    return ItemsModel(
      nome: doc['nome'],
      valor: doc['valor'],
      prioridade: doc['prioridade'],
      jaTem: doc['jaTem'],
      quantidade: doc['quantidade'],
      reference: doc.reference,
    );
  }

  factory ItemsModel.fromfromJson(Map<String, dynamic> json) {
    return ItemsModel(
        nome: json['nome'],
        valor: json['valor'],
        prioridade: json['prioridade'],
        jaTem: json['jaTem'],
        quantidade: json['quantidade']);
  }

  Map<String, dynamic> toJson() => {};

  @override
  String toString() {
    return 'Nome: ${this.nome} Referencia: ${this.reference} ';
  }
}
