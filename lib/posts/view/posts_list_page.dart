import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/post_bloc.dart';
import './post_list.dart';
import 'package:http/http.dart' as http;



class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:const Text('Infinite Bloc List')),
      body: BlocProvider(
        create:(BuildContext context) => PostBloc(httpClient: http.Client())..add(PostFetched()),
        child:const PostList()

      ),

    );
  }
}