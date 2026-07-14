import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/setor_model.dart';

enum SessionStorageKeys {
  setorSelecionado('setorSelecionado'),
  accesToken('accesToken'),
  refreshToken('refreshToken');

  final String key;
  const SessionStorageKeys(this.key);
}

enum ManterDadosLogin {
  login('login'),
  senha('senha');

  final String key;
  const ManterDadosLogin(this.key);
}

class LocalStorageUtils {
  static Future<bool> cointains(String key) async {
    return SharedPreferences.getInstance().then((sharedPreferences) {
      return sharedPreferences.containsKey(key);
    });
  }

  static Future<String> getValue(String key) async {
    return SharedPreferences.getInstance().then((sharedPreferences) {
      return sharedPreferences.getString(key) ?? '';
    });
  }

  static Future<bool> setValue(String key, String value) async {
    return SharedPreferences.getInstance().then((sharedPreferences) {
      return sharedPreferences.setString(key, value);
    });
  }

  static Future<bool> removeValue(String key) async {
    return SharedPreferences.getInstance().then((sharedPreferences) {
      return sharedPreferences.remove(key);
    });
  }

  static Future<void> clean() async {
    await LocalStorageUtils.removeValue(SessionStorageKeys.setorSelecionado.key);
    await LocalStorageUtils.removeValue(SessionStorageKeys.accesToken.key);
    await LocalStorageUtils.removeValue(SessionStorageKeys.refreshToken.key);
  }

  static Future<SetorModel?> carregarSetorSelecionado() async {
    final setorSelecionado = await LocalStorageUtils.getValue(SessionStorageKeys.setorSelecionado.key);

    if (setorSelecionado.isNotEmpty) {
      log('Obtendo setor do local storage');
      return SetorModel?.fromJson(setorSelecionado);
    }

    return null;
  }

  static Future<void> salvarSetor({required SetorModel? setor}) async {
    await LocalStorageUtils.setValue(SessionStorageKeys.setorSelecionado.key, setor?.toJson() ?? '{}');
  }
}
