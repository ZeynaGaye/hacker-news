import 'package:flutter/material.dart';
import 'package:hacker_news/Database/DatabaseHelper.dart';
import 'package:hacker_news/Networking/hackerNewsAPI.dart';
import 'package:hacker_news/Screens/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialiser la base de données
  await DatabaseHelper.instance.init();

  // Récupérer les articles depuis l'API
  final newsApi = HackerNewsAPI();
  try {
    final topStories = await newsApi.getTopStories();
    final stories = await newsApi.getStoryDetails(topStories);

    // Sauvegarder chaque article dans la base de données
    for (final story in stories) {
      await DatabaseHelper.instance.saveStory(story);
    }

    runApp(MaterialApp(
      title: 'Hacker News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    ));
  } on Exception catch (e) {

    print('Erreur lors de la récupération ou de la sauvegarde des articles : $e');
    
  }
}


