class Story {
  int? id;
  String? title;
  String? author;
  String? url;
  String? content;
  bool? isFavorite;
  String? kids;

  Story({
    this.id,
    this.title,
    this.author,
    this.url,
    this.content,
    this.isFavorite,
    this.kids,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'url': url,
      'content': content,
      'is_favorite': isFavorite  ,
      'kids': kids,
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      url: map['url'],
      content: map['content'],
      isFavorite: map['is_favorite'] == 1,
      kids: map['kids'],
    );
  }
}
