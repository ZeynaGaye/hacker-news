import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hacker_news/Networking/hackerNewsAPI.dart';
import 'package:hacker_news/Models/story.dart';
import 'package:url_launcher/url_launcher.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Dernières Actualités',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder(
                future: HackerNewsAPI().getTopStories(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erreur: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    return FutureBuilder(
                      future: HackerNewsAPI().getStoryDetails(snapshot.data!),
                      builder: (context, storySnapshot) {
                        if (storySnapshot.connectionState ==
                            ConnectionState.waiting) {
                                            return const SpinKitHourGlass(
                              color: Colors.orange,
                            );
                        } else if (storySnapshot.hasError) {
                          return Text('Erreur: ${storySnapshot.error}');
                        } else if (storySnapshot.hasData) {
                          List<Story> stories = storySnapshot.data!;
                          return ListView.builder(
                            itemCount: stories.length,
                            itemBuilder: (context, index) {
                              final Story story = stories[index];
                              return ListTile(
                                title: Text(story.title ?? 'Pas de titre'),
                                subtitle: Text(story.author ?? 'Inconnu'),
                                trailing: IconButton(
                                  icon: Icon(Icons.link),
                                  onPressed: () {
                                    // Open the article URL in a web view or browser
                                    if (story.url!= null) {
                                      if (story.url!= null) {
                              // Lancer l'URL en utilisant le package url_launcher
                                    launch(story.url!);
                                 }

                                    }
                                  },
                                ),
                              );
                            },

                          );
                        } else {
                          return const Center(child: Text('Aucune donnée'));
                        }
                      },
                    );
                  } else {
                    return const Center(child: Text('Aucune donnée'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
