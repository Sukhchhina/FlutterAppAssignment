import 'package:flutter/material.dart';
import '../services/news_service.dart';

class NewsProvider with ChangeNotifier {
  final NewsService _newsService;

  // Constructor with named parameter
  NewsProvider({required NewsService newsService}) : _newsService = newsService;

  List<String> _headlines = [];
  bool _isLoading = false;
  String? _error;

  List<String> get headlines => _headlines;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchHeadlines() async {
    _isLoading = true;
    notifyListeners();

    try {
      _headlines = await _newsService.fetchHeadlines();
      _error = null;
    } catch (e) {
      _error = 'Failed to load headlines';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
