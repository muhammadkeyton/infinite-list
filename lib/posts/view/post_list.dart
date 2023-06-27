import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_infinite_bloc/posts/bloc/post_bloc.dart';
import '../widgets/post_list_item.dart';

class PostList extends StatefulWidget {
  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) return context.read<PostBloc>().add(PostFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final currentScroll = _scrollController.offset;
    final maxScroll = _scrollController.position.maxScrollExtent;

    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (context, state) {
       switch (state.status) {
         case PostStatus.initial:
           return const Center(child:CircularProgressIndicator());

         case PostStatus.success:
          if(state.posts.isEmpty) return const Center(child:CircularProgressIndicator());

          return ListView.builder(
            itemBuilder: (BuildContext context,int index){

              return index >= state.posts.length ? 
              const Center(child: SizedBox(width:50,height:50,child: CircularProgressIndicator(strokeWidth: 1.5,),)): PostListItem(post:state.posts[index]);
            },
            itemCount: state.hasReachedMax ? state.posts.length:state.posts.length + 1,
            controller: _scrollController,
            
          );

          case PostStatus.failed:
           return const Center(child: Text("an error occurred couldn't fetch posts!"),);

           
          
       }
    });
  }
}
