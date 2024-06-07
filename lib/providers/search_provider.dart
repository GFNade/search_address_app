import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/address_result.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/debounce.dart';  // Nếu bạn sử dụng debounce

class SearchProvider with ChangeNotifier {
  List<AddressResult> _results = [];
  List<AddressResult> get results => _results;

  String _searchQuery = ''; // Thêm trường searchQuery
  String get searchQuery => _searchQuery;

  set searchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  final Debouncer _debouncer = Debouncer(milliseconds: 1000);

  void searchAddress(String query) {
    _debouncer.run(() async {
      if (query.isEmpty) {
        _results = [];
        notifyListeners();
        return;
      }

      final response = await http.get(Uri.parse('https://geocode.search.hereapi.com/v1/geocode?q=$query&apiKey=n0C6GWYwgKUQ8W5cGvsB4lIq4zpwm9vJc2boXLEfyr0'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _results = (data['items'] as List).map((item) => AddressResult.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load results');
      }
    });
  }

  void openGoogleMaps(String coordinates) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$coordinates';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
