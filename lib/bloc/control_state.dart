import 'package:mini_assignment/model/article_model.dart';

abstract class NewsState {}

class NewsInitialState extends NewsState {}

// enum FetchNewsEvent { fetch, refresh }

class ControlLoading extends NewsState {}

class NewsErrorState extends NewsState {
  final String error;

  NewsErrorState(this.error);
}

class ControlFinishState extends NewsState {
  final List<ArticleModel> news;

  ControlFinishState(this.news);
}

// class ControlFinishState extends NewsState {
//   final List<news> drinks;

//   ControlFinishState(this.drinks);
// }

// abstract class NewsState {}

// class NewsInitialState extends NewsState {}

// class NewsLoadedState extends NewsState {
//   final List<dynamic> news;

//   NewsLoadedState(this.news);
// }

// class NewsErrorState extends NewsState {
//   final String error;

//   NewsErrorState(this.error);
// }
