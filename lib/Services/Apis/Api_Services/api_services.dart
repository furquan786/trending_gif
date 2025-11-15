import 'package:gif/Services/Apis/Api_Interface/api_interface.dart';
import 'package:gif/Services/Apis/Endpoints/endpoints.dart';
import 'package:http/http.dart' as http;

class ApiServices implements ApiInterface {
  @override
  Future<dynamic> fetchTrendingGifs(int limit, int offset) async {
    final url = Uri.parse(
      "${ApiInterface.baseUrl}${Endpoints.trendingGifs}api_key=${ApiInterface.apiKey}&limit=$limit&offset=$offset",
    );
    var response = await http.get(url);
    return response;
  }

  @override
  Future<dynamic> searchGifs(String query, int limit, int offset) async {
    final url = Uri.parse(
      "${ApiInterface.baseUrl}${Endpoints.searchGifs}api_key=${ApiInterface.apiKey}&q=$query&limit=$limit&offset=$offset",
    );
    var response = await http.get(url);
    return response;
  }
}
