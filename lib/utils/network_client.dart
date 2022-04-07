class NetworkClient {
  String createUrlWithSearchTerm(String baseUrl, String query, int limit) {
    String formulateQuery = query.split(" ").join('+') + "&limit=$limit";
    return baseUrl + formulateQuery;
  }
}
