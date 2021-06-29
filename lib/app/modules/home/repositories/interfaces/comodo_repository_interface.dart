import '../../models/comodo.dart';

abstract class IComodoRepository {
  Stream<List<ComodoModel>> get();
  Future save(ComodoModel model);
  Future delete(ComodoModel model);
  Future<Stream<ComodoModel>> getByDocumentId(String documentId);
}
