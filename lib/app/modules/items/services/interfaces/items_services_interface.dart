import '../../models/items.dart';

abstract class IitemsService {
  Stream<List<ItemsModel>> get(String comodoReference, {List<String> filtros});
  Future save(ItemsModel model, String comodoReference);
  Future delete(ItemsModel model);
}
