import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hacker_news/Database/DatabaseHelper.dart';
import 'package:hacker_news/Models/comment.dart';
import 'package:hacker_news/Models/story.dart';

class HackerNewsAPI {
  static List<int> list = [];

  Future<List<int>> getTopStories() async {
    try {
      var request = await http
          .get(Uri.parse(
              "https://hacker-news.firebaseio.com/v0/topstories.json"))
          .timeout(Duration(seconds: 10));
      String response = request.body;

      var responseSplit = response.substring(1, response.length - 1).split(",");

      for (var i in responseSplit) {
        list.add(int.parse(i));
      }
      print('La taille de la liste ${list.length}');
      return list;
    } on TimeoutException {
      return [];
    } catch (e) {
      print('Erreur lors de la récupération des articles populaires: $e');
      return [];
    }
  }

  Future<List<Story>> getStoryDetails(List<int> storyIds) async {
  List<Story> stories = [];

  for (var storyId in storyIds) {
    try {
      final response = await http.get(
        Uri.parse('https://hacker-news.firebaseio.com/v0/item/$storyId.json'),
      );

      if (response.statusCode == 200) {
        final storyData = json.decode(response.body);
        final story = Story(
          id: storyId,
          title: storyData['title'] ?? '',
          author: storyData['by'] ?? '',
          content: storyData['content']??'',
          url: storyData['url'] ?? '',
         
        );

        // Ajouter l'article à la liste des histoires
        stories.add(story);
        //  print('ID: ${story.id}');
        // print('Titre: ${story.title}');
        // print('Auteur: ${story.author}');
        // print('URL: ${story.url}');

        // Insérer l'article dans la base de données
        //await DatabaseHelper.instance.insertStory(story);
      }
    } catch (e) {
      print('Erreur lors de la récupération de l\'article avec l\'ID: $storyId - $e');
    }
  }

  return stories;
}

}
