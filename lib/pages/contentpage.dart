import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_assignment/bloc/control_bloc.dart';
import 'package:mini_assignment/bloc/control_event.dart';
import 'package:mini_assignment/bloc/control_state.dart';
import 'package:mini_assignment/model/article_model.dart';

class NewsCard extends StatelessWidget {
  final ArticleModel article;

  NewsCard(this.article);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(article.urlToImage,
              height: 150, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  article.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  'Published on ${article.publishedAt}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  @override
  Widget build(BuildContext context) {
    // final newsBloc = BlocProvider.of<ControlBloc>(context);
    // newsBloc.add(FetchNewsEvent.fetch);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News App',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<ControlBloc, NewsState>(
        builder: (context, state) {
          if (state is ControlLoading || state is NewsInitialState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ControlFinishState) {
            // Build the card list using state.newsItems
            return ListView.builder(
              //เลื่อนscroll ,ดี
              itemCount: state.news.length,
              itemBuilder: (context, index) {
                return NewsCard(state.news[index]);
              },
            );
          } else if (state is NewsErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error),
                  MaterialButton(
                    onPressed: () {
                      bool isNewsButton = true;
                      ControlBloc controlBloc =
                          BlocProvider.of<ControlBloc>(context);
                      controlBloc.add(FetchNewsEvent(
                        includeAuth: isNewsButton,
                        requireAuthorization: true,
                      ));
                      // Navigator.pushNamed(context, '/content');
                    },
                    color: const Color.fromARGB(255, 216, 216, 216),
                    child: Text(
                      'Refresh',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

//  ElevatedButton(
//                     onPressed: () {
//                       // newsBloc.add(FetchNewsEvent.refresh);
//                       bool isNewsButton = true;
//                       ControlBloc controlBloc =
//                           BlocProvider.of<ControlBloc>(context);
//                       controlBloc.add(FetchNewsEvent(
//                         includeAuth: isNewsButton,
//                         requireAuthorization: true,
//                       ));
//                       Navigator.pushNamed(context, '/content');
//                     },
//                     child: Text('Refresh'),
//                   ),},