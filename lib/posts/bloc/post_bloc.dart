import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


//barrels
import '../model/model.dart';

part './post_event.dart';
part './post_state.dart';


const int postLimit = 20;


const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent,PostState>{

  final http.Client httpClient;


  PostBloc({required this.httpClient}):super(const PostState()){
    on<PostFetched>(_onPostFetched,transformer: throttleDroppable(throttleDuration));
  }



  Future <void> _onPostFetched(PostFetched event,Emitter<PostState>emit)async{
    if(state.hasReachedMax) return;
    try {
      if(state.status == PostStatus.initial){
        final List<Post> posts = await _fetchPosts();

        return emit(state.copyWith(
          posts: posts,
          status: PostStatus.success
        ));
      }

      final List<Post> posts = await _fetchPosts(state.posts.length);

      emit(
        posts.isEmpty ? state.copyWith(hasReachedMax: true) : state.copyWith(posts: List.of(state.posts)..addAll(posts))
      );


      
    } catch (_) {

      emit(state.copyWith(status:PostStatus.failed));

    }


  }




   Future<List<Post>> _fetchPosts([int startIndex = 0]) async{
    final url = Uri.https('jsonplaceholder.typicode.com','/posts',<String,String>{'_start':'$startIndex','_limit':'$postLimit'});
    final response = await httpClient.get(url);

    if(response.statusCode == 200){

      final body = jsonDecode(response.body) as List;


      return body.map((dynamic json) {
        final map = json as Map<String,dynamic>;
        return Post(
          body: map['body'] as String,
          id:map['id'] as int,
          title: map['title'] as String
        );
      },).toList();

    }


    throw Exception('error occured while trying to fetch data');




   }





}

