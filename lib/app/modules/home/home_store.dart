import 'package:houseitems/app/modules/home/models/comodo.dart';
import 'package:houseitems/app/modules/home/services/interfaces/comodo_services_interface.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IComodoService comodoService;

  @observable
  ObservableStream<List<ComodoModel>> comodoList;

  HomeStoreBase({this.comodoService}) {
    getComodoList();
  }

  @action
  getComodoList() {
    comodoList = comodoService.get().asObservable();
  }

  @action
  void saveComodo(ComodoModel model) {
    comodoService.save(model);
  }

  @action
  void delete(ComodoModel model) {
    comodoService.delete(model);
  }
}
