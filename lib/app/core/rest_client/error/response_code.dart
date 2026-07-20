enum ResponseCode {
  ok(code: 200, description: 'OK'),
  created(code: 201, description: 'CREATED'),
  accepted(code: 202, description: 'ACCEPTED'),
  noContend(code: 204, description: 'NO_CONTENT'),
  badRequest(code: 400, description: 'BAD_REQUEST'),
  unauthorized(code: 401, description: 'UNAUTHORIZED'),
  forbidden(code: 403, description: 'FORBIDDEN'),
  notFound(code: 404, description: 'NOT_FOUND'),
  internalServerError(code: 500, description: 'INTERNAL_SERVER_ERROR'),
  serviceUnavailable(code: 503, description: 'SERVICE_UNAVAILABLE'),
  gatewayTimeout(code: 504, description: 'GATEWAY_TIMEOUT');

  const ResponseCode({required this.code, required this.description});

  final int code;
  final String description;
}
