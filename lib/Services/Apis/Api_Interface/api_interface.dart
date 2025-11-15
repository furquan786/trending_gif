abstract class ApiInterface {
  static const String apiKey = "GLD1O5ZVMImmqpdpdp7e0yQfP2akYomx";

  static const baseUrl = "https://api.giphy.com";

  Future<dynamic> fetchTrendingGifs(int limit, int offset);
  Future<dynamic> searchGifs(String query, int limit, int offset);
}
