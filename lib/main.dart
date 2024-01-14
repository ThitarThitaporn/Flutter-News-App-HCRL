import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_assignment/bloc/control_bloc.dart';
import 'package:mini_assignment/bloc/control_state.dart';
import 'package:mini_assignment/pages/contentpage.dart';
import 'package:mini_assignment/pages/homepage.dart';
import 'package:mini_assignment/services/news_repository.dart';

void main(List<String> args) {
  runApp(BlocProvider(
    create: (context) => ControlBloc(
      initialState: NewsInitialState(), // Corrected the initial state
      newsRepository: NewsRepository(),
    ),
    child: MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/content': (context) => const ContentPage(),
      },
    ),
  ));
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<ControlBloc>(
          // create: (context) => ControlBloc(
          //   initialState: NewsInitialState(), // Corrected the initial state
          //   newsRepository: NewsRepository(),
          // ),
//         )
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: HomePage(),
//       ),
//     );
//   }
// }
