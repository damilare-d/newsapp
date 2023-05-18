import 'package:equatable/equatable.dart';

///The equatable package provides a simple way to define custom equality for objects.
///By extending the Equatable class and overriding the props method,
/// developers can define the properties that should be used to determine whether two
/// objects are equal

class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  const Post({
    required this.id,
    required this.body,
    required this.title,
  });

  @override
  List<Object> get props => [id, title, body];
}

///in this example we have a class post with  three properties
///to make the id equal to the title and the body
///we then extend the equatable package
///and override with the props methos
///
///now two posts object will be considered equal if they have
///the same id, title and body values , even if they are different objects with different references
///

class Articles {
  final String title;
  final String description;
  final String url;
  final String urlToImage;

  Articles(
      {required this.title,
      required this.description,
      required this.url,
      required this.urlToImage});

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlTomImage'],
    );
  }
}
