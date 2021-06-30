import 'package:cloud_firestore/cloud_firestore.dart';

class UsuarioModel {
  String nome;
  String email;
  String nickname;
  String senha;
  DocumentReference reference;

  UsuarioModel(
      {this.nome = '', this.email, this.nickname, this.senha, this.reference});

  factory UsuarioModel.fromDocument(DocumentSnapshot doc) {
    return UsuarioModel(
      nome: doc['nome'],
      email: doc['email'],
      nickname: doc['nickname'],
      senha: doc['senha'],
      reference: doc.reference,
    );
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
        nome: json['nome'],
        email: json['email'],
        nickname: json['nickname'],
        senha: json['senha']);
  }

  Map<String, dynamic> toJson() => {};

  @override
  String toString() {
    return 'Nome: ${this.nome} Referencia: ${this.reference} ';
  }
}
