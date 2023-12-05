// home_store.dart
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  ObservableList<String> infos = ObservableList<String>();

  @action
  void addInfo(String info) {
    infos.add(info);
    _saveToPreferences();
  }

  @action
  void removeInfo(int index) {
    infos.removeAt(index);
    _saveToPreferences();
  }

  @action
  void editInfo(int index, String newInfo) {
    infos[index] = newInfo;
    _saveToPreferences();
  }

  @action
  Future<void> loadInfos() async {
    final prefs = await SharedPreferences.getInstance();
    final infoList = prefs.getStringList('infos') ?? [];
    infos = ObservableList<String>.of(infoList);
  }

  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('infos', infos.toList());
  }
}
