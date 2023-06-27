part of './post_bloc.dart';

enum PostStatus{initial,success,failed}



final class PostState extends Equatable{

  const PostState({
    this.status = PostStatus.initial,
    this.hasReachedMax = false,
    this.posts = const <Post>[]

  });
  
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;


  PostState copyWith({
    PostStatus ? status,
    List<Post>? posts,
    bool? hasReachedMax,
  }){
    return PostState(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      posts: posts ?? this.posts
      
      
      );
  }

  @override
  String toString() {
    return ''' PostState:{status:$status,hasReachedMax:$hasReachedMax,posts:${posts.length}} ''';
  }

  @override
  List<Object> get props => [status,hasReachedMax,posts];

}