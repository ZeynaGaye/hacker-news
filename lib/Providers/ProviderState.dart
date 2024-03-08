// import 'package:flutter/material.dart';
// import 'package:hacker_news/Models/comment.dart';
// import 'package:hacker_news/Models/story.dart';

// import 'package:hacker_news/Networking/hackerNewsAPI.dart';

// import 'dart:async';
// import 'dart:convert';
// import 'package:hacker_news/Database/DatabaseHelper.dart';
// import 'package:hacker_news/Models/comment.dart';
// import 'package:hacker_news/Models/story.dart';
// import 'package:http/http.dart' as http;

// class AppState with ChangeNotifier {
//   List<Story> _stories = [];
//   List<Comment> _comments = [];

//   List<Story> get stories => _stories;
//   List<Comment> get comments => _comments;

//   Future<List<Story>> fetchStories() async {
//     try {
//       final hackerNewsAPI = HackerNewsAPI();
//       final databaseHelper = DatabaseHelper();
//       final topStoriesIds = await hackerNewsAPI.getTopStories();

//       List<Story> fetchedStories = [];

//       if (topStoriesIds == null || topStoriesIds.isEmpty) {
//         print('Error: Top stories IDs not found or empty.');
//         return [];
//       }

//       for (final storyId in topStoriesIds) {
//         final story = await hackerNewsAPI.getStoryItem(storyId);
//         if (story == null) {
//           print('Error fetching story with ID: $storyId');
//           continue;
//         }

//         // Ajouter l'article à la base de données locale
//         await databaseHelper.insertStory(story);

//         fetchedStories.add(story);
//       }

//       addStories(fetchedStories);

//       return fetchedStories;
//     } catch (e) {
//       print('Error fetching stories: $e');
//       throw e;
//     }
//   }

//   void addStories(List<Story> stories) {
//     if (stories.isEmpty) {
//       print('Error: No stories to add.');
//       return;
//     }
//     _stories.addAll(stories);
//     notifyListeners();
//   }

//   void addStory(Story story) {
//     _stories.add(story);
//     notifyListeners();
//   }

//   void addComment(Comment comment) {
//     _comments.add(comment);
//     notifyListeners();
//   }
// }
