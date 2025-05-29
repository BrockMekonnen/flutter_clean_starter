part of 'post_edit_bloc.dart';

sealed class PostEditEvent extends Equatable {
  const PostEditEvent();

  @override
  List<Object> get props => [];
}

class SavePostEvent extends PostEditEvent {
  final String? id;
  final String title;
  final String content;

  const SavePostEvent({
    required this.title,
    required this.content,
    this.id,
  });

  @override
  List<Object> get props => [];
}
