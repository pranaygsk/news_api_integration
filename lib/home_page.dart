import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_api_integration/provider/news_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News API"),
      ),
      body: FutureBuilder(
        future: Provider.of<NewsProvider>(context, listen: false).fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            debugPrint(snapshot.connectionState.toString());
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            if (kDebugMode) {
              print(snapshot.error);
            }
            return const Center(child: Text("Error fetching Data"));
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
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) => ListView.builder(
        itemCount: newsProvider.articles.length,
        itemBuilder: (context, index) {
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
                  : ClipOval(child: Image.network(article.urlToImage,width: 50,height: 50,fit: BoxFit.cover,)),
            ),
          );
        },
      ),
    );
  }
}
