import 'package:cloud_firestore/cloud_firestore.dart';

class ComodoModel {
  String nome;
  int id;
  String cardColor;
  String textColor;
  DocumentReference reference;

  ComodoModel({
    this.nome = '',
    this.reference,
    this.cardColor,
    this.textColor,
    this.id,
  });

  factory ComodoModel.fromDocument(DocumentSnapshot doc) {
    return ComodoModel(
      nome: doc['nome'],
      cardColor: doc['cardColor'],
      textColor: doc['textColor'],
      reference: doc.reference,
    );
  }

  factory ComodoModel.fromJson(Map<String, dynamic> json) {
    return ComodoModel(
        nome: json['nome'],
        id: json['id'],
        cardColor: json['cardColor'],
        textColor: json['textColor']);
  }

  Map<String, dynamic> toJson() => {};

  @override
  String toString() {
    return 'Nome: ${this.nome} Referencia: ${this.reference} ';
  }
}
