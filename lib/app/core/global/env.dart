class Env {
  static const Map<String, String> _keys = {
    'API_URL': String.fromEnvironment('API_URL'),
    'AMBIENTE': String.fromEnvironment('AMBIENTE'),
  };

  static String _getKey(String key) {
    final value = _keys[key] ?? '';

    if (value.isEmpty) {
      throw Exception('$key não está nas variáveis de ambiente');
    }

    return value;
  }

  static String get apiUrl => _getKey('API_URL');
  static String get ambiente => _getKey('AMBIENTE');
}
