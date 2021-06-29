import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../models/items.dart';
import '../repositories/interfaces/items_repository_interface.dart';

import 'interfaces/items_services_interface.dart';

class ItemsService extends Disposable implements IitemsService {
  //dispose will be called automatically
  @override
  void dispose() {}

  final IitemsRepository itemsRepository;
  ItemsService({@required this.itemsRepository});

  @override
  Future delete(ItemsModel model) {
    return itemsRepository.delete(model);
  }

  @override
  Stream<List<ItemsModel>> get(String comodoReference) {
    return itemsRepository.get(comodoReference);
  }

  @override
  Future save(ItemsModel model, String comodoReference) {
    return itemsRepository.save(model, comodoReference);
  }
}
