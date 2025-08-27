class Apiconstants
{
  static const String _baseUrl = "http://192.168.0.60:5000";

  static String urlBaseAPI(String endpoint) {
    if (endpoint.startsWith('/')) {
      return '$_baseUrl$endpoint';
    } else {
      return '$_baseUrl/$endpoint';
    }
  }
}
