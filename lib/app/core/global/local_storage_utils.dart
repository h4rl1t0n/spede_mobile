import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/setor_model.dart';
import '../../models/usuario_model.dart';
import '../../shared/data/auth/dto/auth_request_dto.dart';

enum SessionStorageKeys {
  usuarioLogado('usuarioLogado'),
  setorSelecionado('setorSelecionado'),
  accessToken('accessToken');
  // refreshToken('refreshToken'),

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
    await LocalStorageUtils.removeValue(SessionStorageKeys.accessToken.key);
    // await LocalStorageUtils.removeValue(SessionStorageKeys.refreshToken.key);
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

  static Future<void> saveUser({required UsuarioModel? user}) async {
    await LocalStorageUtils.setValue(SessionStorageKeys.usuarioLogado.key, user?.toJson() ?? '{}');
  }

  static Future<UsuarioModel?> loadUser() async {
    final usuarioLogado = await LocalStorageUtils.getValue(SessionStorageKeys.usuarioLogado.key);

    if (usuarioLogado.isNotEmpty) {
      log('Obtendo usuário logado');
      return UsuarioModel?.fromJson(usuarioLogado);
    }

    return null;
  }

  static Future<void> saveTokens({required String accessToken /*required String refreshToken*/}) async {
    await LocalStorageUtils.setValue(SessionStorageKeys.accessToken.key, accessToken);
    //await LocalStorageUtils.setValue(SessionStorageKeys.refreshToken.key, refreshToken);
    log('Tokens salvos e atualizados.');
  }

  static Future<void> saveDataLogin({required AuthRequestDto auth, bool saveData = false}) async {
    await LocalStorageUtils.setValue(ManterDadosLogin.login.key, auth.login);

    if (saveData) {
      await LocalStorageUtils.setValue(ManterDadosLogin.senha.key, auth.senha);
    } else {
      await LocalStorageUtils.removeValue(ManterDadosLogin.senha.key);
    }
  }

  static Future<String> getLogin() async {
    return LocalStorageUtils.getValue(ManterDadosLogin.login.key);
  }

  static Future<String> getSenha() async {
    return LocalStorageUtils.getValue(ManterDadosLogin.senha.key);
  }

  static Future<String> getAccessToken() async {
    return LocalStorageUtils.getValue(SessionStorageKeys.accessToken.key);
  }

  // static Future<String> getRefreshToken() async {
  //   return LocalStorageUtils.getValue(SessionStorageKeys.refreshToken.key);
  // }
}
