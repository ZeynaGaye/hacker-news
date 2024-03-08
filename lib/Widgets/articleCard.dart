// import 'package:flutter/material.dart';
// import 'package:hacker_news/Database/DatabaseHelper.dart';
// import 'package:hacker_news/Models/story.dart';
// import 'package:hacker_news/Networking/hackerNewsAPI.dart';
// import 'package:hacker_news/Providers/ProviderState.dart';
// import 'package:hacker_news/Screens/ArticleDetails.dart';
// import 'package:provider/provider.dart';

// class ArticleCard extends StatelessWidget {
//   final Story story;

//   ArticleCard({Key? key, required this.story}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final hackerNewsAPI = Provider.of<HackerNewsAPI>(context);
//     final databaseHelper = Provider.of<DatabaseHelper>(context);

//     return GestureDetector(
//       onTap: () async {
//         // Check if details are already available in the list
//         if (story.url == null || story.url!.isEmpty) {
//           // Fetch story details only if necessary
//           //final storyDetails = await hackerNewsAPI.getStoryItem(story.id);

//           // Update local cache or state here
//           //Provider.of<AppState>(context, listen: false).addStory(storyDetails);

//           // Navigate to details screen
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ArticleDetails(story: storyDetails),
//             ),
//           );
//         } else {
//           // Details are already available, navigate directly
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ArticleDetails(story: story),
//             ),
//           );
//         }
//       },
//       child: Card(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(story.title ?? ''), // Access story properties directly
//               Text(story.author ?? ''),
//               Text(story.url ?? ''),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
