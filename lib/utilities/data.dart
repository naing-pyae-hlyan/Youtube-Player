final String baseUrl = 'www.googleapis.com';

errorResponse(String message) {
  Map<String, dynamic> errorResponse = {
    'error': {'message': message}
  };
  return errorResponse;
}
