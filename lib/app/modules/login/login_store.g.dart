// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsuarioStore on UsuarioStoreBase, Store {
  final _$usuarioAtom = Atom(name: 'UsuarioStoreBase.usuario');

  @override
  UsuarioModel get usuario {
    _$usuarioAtom.reportRead();
    return super.usuario;
  }

  @override
  set usuario(UsuarioModel value) {
    _$usuarioAtom.reportWrite(value, super.usuario, () {
      super.usuario = value;
    });
  }

  final _$themeColorAtom = Atom(name: 'UsuarioStoreBase.themeColor');

  @override
  String get themeColor {
    _$themeColorAtom.reportRead();
    return super.themeColor;
  }

  @override
  set themeColor(String value) {
    _$themeColorAtom.reportWrite(value, super.themeColor, () {
      super.themeColor = value;
    });
  }

  final _$UsuarioStoreBaseActionController =
      ActionController(name: 'UsuarioStoreBase');

  @override
  dynamic changeColor(String newColor) {
    final _$actionInfo = _$UsuarioStoreBaseActionController.startAction(
        name: 'UsuarioStoreBase.changeColor');
    try {
      return super.changeColor(newColor);
    } finally {
      _$UsuarioStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic login(String username, String password) {
    final _$actionInfo = _$UsuarioStoreBaseActionController.startAction(
        name: 'UsuarioStoreBase.login');
    try {
      return super.login(username, password);
    } finally {
      _$UsuarioStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void save(UsuarioModel model) {
    final _$actionInfo = _$UsuarioStoreBaseActionController.startAction(
        name: 'UsuarioStoreBase.save');
    try {
      return super.save(model);
    } finally {
      _$UsuarioStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(UsuarioModel model) {
    final _$actionInfo = _$UsuarioStoreBaseActionController.startAction(
        name: 'UsuarioStoreBase.delete');
    try {
      return super.delete(model);
    } finally {
      _$UsuarioStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
usuario: ${usuario},
themeColor: ${themeColor}
    ''';
  }
}
