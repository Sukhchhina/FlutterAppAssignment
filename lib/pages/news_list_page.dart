import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';
import 'package:go_router/go_router.dart';

class NewsListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('News Headlines'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/greeting');
          },
        ),
      ),
      body: newsProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : newsProvider.error != null
          ? Center(child: Text(newsProvider.error!))
          : ListView.builder(
        itemCount: newsProvider.headlines.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(newsProvider.headlines[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => newsProvider.fetchHeadlines(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
