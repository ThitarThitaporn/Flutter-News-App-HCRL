import 'dart:convert';
import 'package:mini_assignment/model/article_model.dart';
import 'package:http/http.dart';

class NewsRepository {
  static const String _apikey = "920395cf9b7b4026af240dd81ba47694";
  String _baseUrl = "https://newsapi.org/v2/everything";

  Future<List<ArticleModel>> getArticles(String keyword) async {
    String url = "$_baseUrl?q=$keyword&apiKey=$_apikey";

    try {
      Response res = await get(Uri.parse(url));

      if (res.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(res.body);

        List<dynamic> body = json['articles'];

        List<ArticleModel> articles =
            body.map((dynamic item) => ArticleModel.fromJson(item)).toList();

        return articles;
      } else {
        throw ("Can't get the Articles");
      }
    } catch (e) {
      throw ("Error fetching articles: $e");
    }
  }

  Future<void> fetchNews() async {
    // Implement the logic to fetch news using this method if needed
  }
}
