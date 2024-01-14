import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_assignment/bloc/control_bloc.dart';
import 'package:mini_assignment/bloc/control_event.dart';
import 'package:mini_assignment/bloc/control_state.dart';
import 'package:mini_assignment/pages/contentpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News App',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  onPressed: () {
                    bool isNewsButton = true;
                    ControlBloc controlBloc =
                        BlocProvider.of<ControlBloc>(context);
                    controlBloc.add(FetchNewsEvent(
                      includeAuth: isNewsButton,
                      requireAuthorization: true,
                    ));
                    Navigator.pushNamed(context, '/content');
                  },
                  color: const Color.fromARGB(255, 216, 216, 216),
                  child: const Text(
                    'News',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    bool isNewsButton = false;
                    ControlBloc controlBloc =
                        BlocProvider.of<ControlBloc>(context);
                    controlBloc.add(FetchNewsEvent(
                      includeAuth: isNewsButton,
                      requireAuthorization: false,
                    ));

                    Navigator.pushNamed(context, '/content');
                  },
                  color: const Color.fromARGB(255, 216, 216, 216),
                  child: const Text(
                    'News no Auth',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
