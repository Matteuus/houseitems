// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemsStore on _ItemsStoreBase, Store {
  final _$itemsListAtom = Atom(name: '_ItemsStoreBase.itemsList');

  @override
  ObservableStream<List<ItemsModel>> get itemsList {
    _$itemsListAtom.reportRead();
    return super.itemsList;
  }

  @override
  set itemsList(ObservableStream<List<ItemsModel>> value) {
    _$itemsListAtom.reportWrite(value, super.itemsList, () {
      super.itemsList = value;
    });
  }

  final _$filtrosAtom = Atom(name: '_ItemsStoreBase.filtros');

  @override
  List<String> get filtros {
    _$filtrosAtom.reportRead();
    return super.filtros;
  }

  @override
  set filtros(List<String> value) {
    _$filtrosAtom.reportWrite(value, super.filtros, () {
      super.filtros = value;
    });
  }

  final _$_ItemsStoreBaseActionController =
      ActionController(name: '_ItemsStoreBase');

  @override
  dynamic addFiltro(String filtro) {
    final _$actionInfo = _$_ItemsStoreBaseActionController.startAction(
        name: '_ItemsStoreBase.addFiltro');
    try {
      return super.addFiltro(filtro);
    } finally {
      _$_ItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeFiltro(String filtro) {
    final _$actionInfo = _$_ItemsStoreBaseActionController.startAction(
        name: '_ItemsStoreBase.removeFiltro');
    try {
      return super.removeFiltro(filtro);
    } finally {
      _$_ItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getItemsList(String comodoReference) {
    final _$actionInfo = _$_ItemsStoreBaseActionController.startAction(
        name: '_ItemsStoreBase.getItemsList');
    try {
      return super.getItemsList(comodoReference);
    } finally {
      _$_ItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void saveItem(ItemsModel model, String comodoReference) {
    final _$actionInfo = _$_ItemsStoreBaseActionController.startAction(
        name: '_ItemsStoreBase.saveItem');
    try {
      return super.saveItem(model, comodoReference);
    } finally {
      _$_ItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void delete(ItemsModel model) {
    final _$actionInfo = _$_ItemsStoreBaseActionController.startAction(
        name: '_ItemsStoreBase.delete');
    try {
      return super.delete(model);
    } finally {
      _$_ItemsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
itemsList: ${itemsList},
filtros: ${filtros}
    ''';
  }
}
