class Apiconstants
{
  static const String _baseUrl = "https://blackbrothersapi-ercecsbrf5grg5hu.brazilsouth-01.azurewebsites.net";

  static String urlBaseAPI(String endpoint) {
    if (endpoint.startsWith('/')) {
      return '$_baseUrl$endpoint';
    } else {
      return '$_baseUrl/$endpoint';
    }
  }
}
