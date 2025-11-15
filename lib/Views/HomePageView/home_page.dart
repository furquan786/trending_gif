import 'package:flutter/material.dart';
import 'package:gif/Model/GiphyModel/giphyMode.dart';
import 'package:gif/Repo/GiphyRepoImpl.dart/giphyRepoImpl.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    // GiphyFlutterSDK.configure(apiKey: ApiInterface.apiKey);
    fetchTrendingGifs();
    print("##### Init State Called");
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchMoreGifs();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<GifData> listToShow =
        searchResults.isNotEmpty || searchController.text.isNotEmpty
        ? searchResults
        : giphyData;
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search GIFs...",
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  if (value.trim().isEmpty) {
                    setState(() => searchResults.clear());
                    return;
                  }
                  searchGif(value);
                },
              )
            : Text("Home Page"),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  searchResults.clear();
                }
                isSearching = !isSearching;
              });
            },
          ),
        ],
      ),

      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                controller: scrollController,
                itemCount: listToShow.length,
                itemBuilder: (context, index) {
                  if (index == giphyData.length) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Material(
                    elevation: 6,
                    borderRadius: BorderRadius.circular(12),
                    shadowColor: Colors.black54,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              listToShow[index].images.original.url!,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;

                                    return Center(
                                      child: CircularProgressIndicator(
                                        value:
                                            loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                    child: Icon(Icons.error, color: Colors.red),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                ),
              ),
      ),
    );
  }

  // ------------------------------------------------------
  // Buisness Logic start from here
  // ------------------------------------------------------

  List<GifData> giphyData = [];
  ScrollController scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();
  List<GifData> searchResults = [];

  var isLoading = false;
  bool isSearching = false;
  var limit = 20;
  var offset = 0;
  var totalCount = 0;
  var isPaginationLoading = false;
  var showError = "Something went wrong";

  Giphyrepoimpl giphyrepoimpl = Giphyrepoimpl();

  Future<void> fetchTrendingGifs() async {
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await giphyrepoimpl.fetchTrendingGifs(limit, offset);
      if (response.statusCode == 200) {
        var data = giphyResponseFromJson(response.body);
        setState(() {
          giphyData.addAll(data.data);
          totalCount = data.pagination.totalCount;
        });
        print("##### Total Count: $totalCount");
      } else {
        setState(() {
          showError = "Error: ${response.statusCode}";
        });
        print("##### Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        showError = "Exception: $e";
      });
      print("##### Exception: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void fetchMoreGifs() async {
    print("##### fetch more data called ");
    if (isPaginationLoading || giphyData.length >= totalCount) return;

    setState(() => isPaginationLoading = true);

    offset += limit;

    try {
      Response response = await giphyrepoimpl.fetchTrendingGifs(limit, offset);

      if (response.statusCode == 200) {
        var data = giphyResponseFromJson(response.body);

        setState(() {
          giphyData.addAll(data.data);
        });
      } else {
        setState(() {
          showError = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        showError = "Exception: $e";
      });
    } finally {
      setState(() => isPaginationLoading = false);
    }
  }

  Future<void> searchGif(String query) async {
    try {
      final res = await giphyrepoimpl.searchGifs(query, limit, 0);
      if (res.statusCode == 200) {
        final data = giphyResponseFromJson(res.body);
        setState(() {
          searchResults = data.data;
        });
      }
    } catch (e) {
      print("Search error: $e");
    }
  }
}
