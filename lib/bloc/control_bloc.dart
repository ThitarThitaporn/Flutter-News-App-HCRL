import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:mini_assignment/bloc/control_event.dart';
import 'package:mini_assignment/bloc/control_state.dart';
import 'package:mini_assignment/model/article_model.dart';
import 'package:mini_assignment/pages/contentpage.dart';
import 'package:mini_assignment/services/news_repository.dart';
import 'package:http/http.dart' as http;

class ControlBloc extends Bloc<ControlEvent, NewsState> {
  final NewsRepository newsRepository;

  ControlBloc({
    required this.newsRepository,
    required NewsInitialState initialState,
  }) : super(NewsInitialState()) {
    on<FetchNewsEvent>((event, emit) async {
      Map<String, String> headers = {};
      if (event.requireAuthorization == true) {
        headers[HttpHeaders.authorizationHeader] =
            '920395cf9b7b4026af240dd81ba47694';
      } else {
        headers[HttpHeaders.authorizationHeader] = 'dsjhjshdjhskdkshdkdhksd';
      }

      emit(ControlLoading());
      try {
        final response = await http.get(
          Uri.parse('https://newsapi.org/v2/everything?q=keyword'),
          headers: headers,
        );
        // print(response.statusCode);
        // print(response.body);
        if (response.statusCode == 200) {
          // Decode the response body
          List<dynamic> articles = jsonDecode(response.body)['articles'];
          // Process the articles as needed, for example, convert them to ArticleModel objects
          List<ArticleModel> news = articles
              .map((article) => ArticleModel.fromJson(article))
              .toList();

          // Yield the ControlFinishState with the list of news
          print(news);
          emit(ControlFinishState(news));
        } else {
          if (kDebugMode) {
            print('Error: ${response.statusCode}');
          }
          emit(NewsErrorState(''));
        }
      } catch (e) {
        emit(NewsErrorState('Error: $e  thitar'));
      }
    });
  }
}



// class ControlBloc extends Bloc<NewsEvent, NewsState> {
//   ControlBloc() : super(initialState);

//   @override
//   Stream<NewsState> mapEventToState(NewsEvent event) async* {
//     if (event is FetchNewsEvent) {
//       yield NewsLoadingState(); // Indicate that the news is being loaded

//       try {
//         // Simulate API call or fetch news data
//         List<String> news = ["News 1", "News 2", "News 3"];
//         yield NewsLoadedState(news);
//       } catch (e) {
//         yield NewsErrorState("Error fetching news: $e");
//       }
//     }
//   }

//   Stream<NewsState> _mapFetchNewsEventToState(bool includeAuth) async* {
//     final String apiUrl =
//         'https://newsapi.org/v2/everything?q=keyword&apikey=920395cf9b7b4026af240dd81ba47694'; // Replace with your API endpoint

//     try {
//       final response = await http.get(
//         Uri.parse(apiUrl),
//         headers: includeAuth ? {'Authorization': 'Bearer YourAccessToken'} : {},
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);

//         // Extract the list of news from the Map based on your API response structure
//         final List<dynamic> articles = responseData['articles'];

//         List<String> newsTitles = articles
//             .map((item) => item['title']?.toString() ?? "")
//             .where((title) => title.isNotEmpty)
//             .toList();

//         yield NewsLoadedState(newsTitles);
//       } else {
//         yield NewsErrorState(
//             'Failed to fetch news. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       yield NewsErrorState('Error: $e');
//     }
//   }
// }
