import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object> get props => [];
}

class PostInitialState extends PostState {
  @override
  String toString() => 'PostInitialState';
}

class PostFailState extends PostState{
  @override
  String toString() => 'PostFailState';
}

class PostSuccessState extends PostState{
  @override
  String toString() => 'PostSuccessState';
}

class PostLoadingState extends PostState{
  @override
  String toString() => 'PostLoadingState';
}