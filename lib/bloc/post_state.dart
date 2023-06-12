import 'package:equatable/equatable.dart';

import '../data/model.dart';

abstract class PostState extends Equatable {}

class PostInitialState extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoadingState extends PostState {
  @override
  List<Object> get props => [];
}

class PostLoadedState extends PostState {
  @override
  List<Post> postedDetails;
  PostLoadedState({
    required this.postedDetails,
  });

  List<Object> get props => throw UnimplementedError();
}

class PostErrorState extends PostState {
  String message;
  PostErrorState({
    required this.message,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}