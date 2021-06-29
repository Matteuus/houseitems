// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  final _$comodoListAtom = Atom(name: 'HomeStoreBase.comodoList');

  @override
  ObservableStream<List<ComodoModel>> get comodoList {
    _$comodoListAtom.reportRead();
    return super.comodoList;
  }

  @override
  set comodoList(ObservableStream<List<ComodoModel>> value) {
    _$comodoListAtom.reportWrite(value, super.comodoList, () {
      super.comodoList = value;
    });
  }

  final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase');

  @override
  dynamic getComodoList() {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.getComodoList');
    try {
      return super.getComodoList();
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveComodo(ComodoModel model) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.saveComodo');
    try {
      return super.saveComodo(model);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(ComodoModel model) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.delete');
    try {
      return super.delete(model);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
comodoList: ${comodoList}
    ''';
  }
}
