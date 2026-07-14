enum StatusCodeErrorEnum {
  connectTimeout(value: -2, descricao: 'connectTimeout'),
  sendTimeout(value: -3, descricao: 'sendTimeout'),
  receiveTimeout(value: -4, descricao: 'receiveTimeout'),
  response(value: -5, descricao: 'response'),
  cancel(value: -6, descricao: 'cancel'),
  other(value: -7, descricao: 'other');

  const StatusCodeErrorEnum({required this.value, required this.descricao});

  final int value;
  final String descricao;
}
