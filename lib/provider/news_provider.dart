import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/news_model.dart';
import 'package:http/http.dart' as http;

class NewsProvider extends ChangeNotifier{
  final String apiKey = "e8bf3420bb5a44ea883b60f29100c8c0";
  final String apiUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=";

  List<News> _articles = [];
  List<News> get articles => _articles;

  Future<void> fetchData() async {
    try{
      final response = await http.get(Uri.parse(apiUrl+apiKey));

      if(response.statusCode == 200){
        final Map<String,dynamic> data = jsonDecode(response.body);
        final List<dynamic> articlesData = data['articles'] ?? [];

        _articles = articlesData.map((article) => News.fromJson(article)).toList();
        notifyListeners();
        debugPrint("Status code 200");
      }else{
        throw Exception("error fetching API");
      }
    }catch(error){
      debugPrint(error.toString());
    }
  }
}