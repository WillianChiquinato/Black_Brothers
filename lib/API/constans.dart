class Apiconstants
{
  static const String _baseUrl = "blackbrothers-bybwd0axhweag7cy.brazilsouth-01.azurewebsites.net";

  static String urlBaseAPI(String endpoint) {
    if (endpoint.startsWith('/')) {
      return '$_baseUrl$endpoint';
    } else {
      return '$_baseUrl/$endpoint';
    }
  }
}
