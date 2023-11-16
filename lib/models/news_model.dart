import 'package:flutter/material.dart';

class News{
  final String title;
  final String description;
  final dynamic urlToImage;

  News({required this.title, required this.description, required this.urlToImage});

  factory News.fromJson(Map<String,dynamic> json){
    return News(
      title: json['title'] ?? 'No title Available',
      description: json['description'] ?? 'No description available',
      urlToImage: json['urlToImage'] ?? const Icon(Icons.error).toString()
    );
  }

}