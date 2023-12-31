class Book {
  String id;
  String title;
  String authors;
  String description;
  String publisher;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
    required this.publisher,
  });

  factory Book.fromJson(Map<String, dynamic> parsedJson) {
    final String id = parsedJson['id'];
    final String title = parsedJson['volumeInfo']['title'];
    String authors = (parsedJson['volumeInfo']['authors'] == null)
        ? ''
        : parsedJson['volumeInfo']['authors'].toString();
    authors = authors.replaceAll('[', '');
    authors = authors.replaceAll(']', '');
    final String description = (parsedJson['volumeInfo']['description'] == null)
        ? ''
        : parsedJson['volumeInfo']['description'];
    final String publisher = (parsedJson['volumeInfo']['publisher'] == null)
        ? ''
        : parsedJson['volumeInfo']['publisher'];
    return Book(
      id: id,
      title: title,
      authors: authors,
      description: description,
      publisher: publisher,
    );
  }

  /*Book.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson['id'] ?? parsedJson['id'],
        title = parsedJson['volumeInfo']['title'] ??
            parsedJson['volumeInfo']['title'],
        authors = parsedJson['volumeInfo']['authors'].toString(),
        description = parsedJson['volumeInfo']['description'] ??
            parsedJson['volumeInfo']['description'],
        publisher = parsedJson['volumeInfo']['publisher'] ??
            parsedJson['volumeInfo']['publisher'];*/

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'authors': authors,
      'description': description,
      'publisher': publisher,
    };
  }
}
