import 'package:flutter/material.dart';
import 'package:news_api_integration/provider/news_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("News API"),
      ),
      body: FutureBuilder(
        future: newsProvider.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint(snapshot.connectionState.toString());
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(child: Text("Error fetching Data"));
          } else if (newsProvider.articles.isEmpty) {
            return const Center(child: Text('No news available.'));
          } else {
            return const NewsScreen();
          }
        },
      ),
    );
  }
}

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);
    return ListView.builder(
      itemCount: newsProvider.articles.length,
      itemBuilder: (context, index) {
        debugPrint(newsProvider.articles.length as String?);
        final article = newsProvider.articles[index];
        return ListTile(
          title: Text(
            article.title,
          ),
          subtitle: Text(
            article.description,
          ),
          leading: CircleAvatar(
              child: article.urlToImage == const Icon(Icons.error).toString()
                  ? const Icon(Icons.error)
                  : Image.network(article.urlToImage)),
        );
      },
    );
  }
}
