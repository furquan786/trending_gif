abstract class GiphyRepo {
  Future<dynamic> fetchTrendingGifs(int limit, int offset);
  Future<dynamic> searchGifs(String query, int limit, int offset);
}
