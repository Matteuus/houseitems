import '../../models/comodo.dart';

abstract class IComodoService {
  Stream<List<ComodoModel>> get();
  Future save(ComodoModel model);
  Future delete(ComodoModel model);
}
