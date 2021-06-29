import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../models/comodo.dart';
import '../repositories/interfaces/comodo_repository_interface.dart';

import 'interfaces/comodo_services_interface.dart';

class ComodoService extends Disposable implements IComodoService {
  //dispose will be called automatically
  @override
  void dispose() {}

  final IComodoRepository comodoRepository;
  ComodoService({@required this.comodoRepository});

  @override
  Future delete(ComodoModel model) {
    return comodoRepository.delete(model);
  }

  @override
  Stream<List<ComodoModel>> get() {
    return comodoRepository.get();
  }

  @override
  Future save(ComodoModel model) {
    return comodoRepository.save(model);
  }
}
