import 'package:equatable/equatable.dart';
import 'package:infinitelistapp/posts/models/post.dart';

enum PostStatus { initial, success, faillure }

class PostState extends Equatable {
  final PostStatus status;
  final List<Post> posts;
  final bool hasReachedMax;
  final List<Articles> articles;

  const PostState({
    this.posts = const <Post>[],
    this.hasReachedMax = false,
    this.status = PostStatus.initial,
    this.articles = const <Articles>[],
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    bool? hasReachedMax,
    List<Articles>? articles,
  }) {
    return PostState(
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        posts: posts ?? this.posts,
        articles: articles ?? this.articles);
  }

  @override
  String toString() {
    return "PostState{ status: $status,hasReachedMAx: $hasReachedMax, posts: ${posts.length}}";
  }

  @override
  List<Object> get props => [status, posts, hasReachedMax, articles];
}
