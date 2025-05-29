class PostListItem {
  final String id;
  final String title;
  final String content;
  final String state;
  final DateTime? postedAt;
  final Poster user;

  PostListItem(
    this.id,
    this.title,
    this.content,
    this.state,
    this.postedAt,
    this.user,
  );
}

class Poster {
  final String id;
  final String firstName;
  final String lastName;

  Poster(
    this.id,
    this.firstName,
    this.lastName,
  );
}
