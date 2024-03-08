class Comment {
  int ?id;
  int ?storyId;
  String? author;
  String? content;
  DateTime ?createdAt;

  Comment({
    required this.id,
    required this.storyId,
    required this.author,
    required this.content,
    required this.createdAt,
  });
}