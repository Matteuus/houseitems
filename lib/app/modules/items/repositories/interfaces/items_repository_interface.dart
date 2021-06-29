import '../../models/items.dart';

abstract class IitemsRepository {
  Stream<List<ItemsModel>> get(String comodoReference);
  Future save(ItemsModel model, String comodoReference);
  Future delete(ItemsModel model);
  Future<Stream<ItemsModel>> getByDocumentId(
      String comodoReference, String documentId);
}
