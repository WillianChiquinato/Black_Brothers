class Apiconstants
{
  static const String _baseUrl = "https://web-production-fc91.up.railway.app";

  static String urlBaseAPI(String endpoint) {
    if (endpoint.startsWith('/')) {
      return '$_baseUrl$endpoint';
    } else {
      return '$_baseUrl/$endpoint';
    }
  }
}
