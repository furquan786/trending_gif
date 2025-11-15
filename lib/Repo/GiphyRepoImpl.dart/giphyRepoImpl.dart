import 'package:gif/Repo/GiphyRepo/giphyRepo.dart';
import 'package:gif/Services/Apis/Api_Services/api_services.dart';

class Giphyrepoimpl implements GiphyRepo {
  ApiServices apiServices = ApiServices();

  @override
  Future<dynamic> fetchTrendingGifs(int limit, int offset) {
    return apiServices.fetchTrendingGifs(limit, offset);
  }

  @override
  Future<dynamic> searchGifs(String query, int limit, int offset) {
    return apiServices.searchGifs(query, limit, offset);
  }
}
