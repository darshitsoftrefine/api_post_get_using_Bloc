import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}
class FetchPostEvent extends PostEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}

