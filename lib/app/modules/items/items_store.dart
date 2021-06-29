import 'package:houseitems/app/modules/items/models/items.dart';
import 'package:houseitems/app/modules/items/services/interfaces/items_services_interface.dart';
import 'package:mobx/mobx.dart';
part 'items_store.g.dart';

class ItemsStore = _ItemsStoreBase with _$ItemsStore;

abstract class _ItemsStoreBase with Store {
  final IitemsService itemsService;

  @observable
  ObservableStream<List<ItemsModel>> itemsList;

  _ItemsStoreBase({this.itemsService});

  @action
  getItemsList(String comodoReference) {
    itemsList = itemsService.get(comodoReference).asObservable();
  }

  @action
  void saveItem(ItemsModel model, String comodoReference) {
    itemsService.save(model, comodoReference);
  }

  @action
  void delete(ItemsModel model) {
    itemsService.delete(model);
  }
}
