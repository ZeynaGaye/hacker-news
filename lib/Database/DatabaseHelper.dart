import 'dart:io';
import 'package:hacker_news/Models/story.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  late Database db;

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  DatabaseHelper._internal();
  static DatabaseHelper get instance => _instance;

  init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "news_DB");
    db = await openDatabase(path, version: 2, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE stories (
      title TEXT NOT NULL,
      author TEXT,
      url TEXT,
      content TEXT,
      is_favorite INTEGER DEFAULT 0,
      kids TEXT
    )
  ''');
  }

  Future<void> insertStory(Story story) async {
    // Convertir l'objet Story en map avant l'insertion
    Map<String, dynamic> storyMap = story.toMap();
    await db.insert('stories', storyMap);
    if (storyMap.length == 1) {
      print('Table stories created!');
    }
  }

  Future<List<Story>> getAllStories() async {
    var result = await db.query('stories');
    return result.map((e) => Story.fromMap(e)).toList();
  }
    Future<void> saveStory(Story story) async {
    // Check if the story already exists
    var existingStory = await db.query('stories', where: 'id = ?', whereArgs: [story.id]);

    if (existingStory.isEmpty) {
      // Insert the story if it doesn't exist
      await db.insert('stories', story.toMap());
    } else {
      // Update the story if it exists
      await db.update('stories', story.toMap(), where: 'id = ?', whereArgs: [story.id]);
    }
  }
}
