// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on _HomeStore, Store {
  late final _$infosAtom = Atom(name: '_HomeStore.infos', context: context);

  @override
  ObservableList<String> get infos {
    _$infosAtom.reportRead();
    return super.infos;
  }

  @override
  set infos(ObservableList<String> value) {
    _$infosAtom.reportWrite(value, super.infos, () {
      super.infos = value;
    });
  }

  late final _$loadInfosAsyncAction =
      AsyncAction('_HomeStore.loadInfos', context: context);

  @override
  Future<void> loadInfos() {
    return _$loadInfosAsyncAction.run(() => super.loadInfos());
  }

  late final _$_HomeStoreActionController =
      ActionController(name: '_HomeStore', context: context);

  @override
  void addInfo(String info) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.addInfo');
    try {
      return super.addInfo(info);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeInfo(int index) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.removeInfo');
    try {
      return super.removeInfo(index);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void editInfo(int index, String newInfo) {
    final _$actionInfo =
        _$_HomeStoreActionController.startAction(name: '_HomeStore.editInfo');
    try {
      return super.editInfo(index, newInfo);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
infos: ${infos}
    ''';
  }
}
