import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coupinos_api_post_get_using_bloc/bloc/post_event.dart';
import 'package:equatable/equatable.dart';

import '../data/model.dart';
import '../data/repository.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository repository;


  PostBloc({required this.repository}) : super(PostInitialState()) {
    on((event, emit) async {
      if(event is FetchPostEvent) {
        List<Post>? postDetails = await repository.getpostDetails();
        emit(PostLoadedState(postedDetails: postDetails!));
      }
      else if(event is PostErrorState){
        emit(PostErrorState(message: "Error"));
      }
    });
  }

  PostState get initialState => PostInitialState();

}