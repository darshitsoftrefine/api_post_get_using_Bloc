import 'package:coupinos_api_post_get_using_bloc/data/repository.dart';
import 'package:coupinos_api_post_get_using_bloc/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/post_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      home: BlocProvider(
        create: (context) => PostBloc(repository: CoupinosLogin()),
        child: HomePage(),
      ),
    );
  }
}
