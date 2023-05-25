import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:infinitelistapp/posts/bloc/post_event.dart';
import 'package:infinitelistapp/posts/bloc/post_state.dart';
import 'package:infinitelistapp/posts/models/post.dart';

const _postLimit = 20;
const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PostBloc extends Bloc<PostEvent, PostState> {
  ///PostBloc will be taking PostEvents as input and outputting PostStates.

  final http.Client httpClient;
  PostBloc({required this.httpClient}) : super(const PostState()) {
    ///todo
    on<PostFetched>(_onPostFetched,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _onPostFetched(
    PostFetched event,
    Emitter<PostState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(
          state.copyWith(
            status: PostStatus.success,
            hasReachedMax: false,
            posts: posts,
          ),
        );
      }
      final posts = await _fetchPosts(state.posts.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                hasReachedMax: false,
                posts: List.of(state.posts)..addAll(posts),
                status: PostStatus.success,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: PostStatus.faillure));
    }
  }

  ///newsapi key = 8884c0f656cf4dada57cf4465bbcaa2c
  ///on this particular day 25th of may the
  ///newsapikey seems to be invalid.

  // _fetchNewsPosts([int startIndex = 0]) async {
  //   final apiKey = '8884c0f656cf4dada57cf4465bbcaa2c';
  //   final url = Uri.https('newsapi.org', '/v2/top-headlines', {
  //     'country': 'us',
  //   });
  //   final response = await http.get(url, headers: {
  //     'X-Api-Key': apiKey,
  //   });
  //   if (response.statusCode == 200) {
  //     final body = json.decode(response.body);
  //     final articles = (body['articles'] as List)
  //         .map((articleJson) => Articles.fromJson(articleJson))
  //         .toList();
  //     return articles;
  //   }
  //   throw Exception('error fetching posts');
  // }

  Future<List<Post>> _fetchPosts([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https('jsonplaceholder.typicode.com', '/posts',
          <String, String>{'_start': '$startIndex', '_limit': '$_postLimit'}),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Post(
          id: map['id'] as int,
          title: map['title'] as String,
          body: map['body'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
