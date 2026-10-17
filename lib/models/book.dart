class Book {
  final int id;
  final String title;
  final String author;
  final String category;
  final String description;
  final int year;
  bool isAvailable;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.year,
    this.isAvailable = true,
  });
}