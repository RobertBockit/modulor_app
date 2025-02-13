import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../models/product.dart'; // Make sure to import this for ChangeNotifier
var apiUrl = "https://mad-shop.onrender.com/api";

class AppState with ChangeNotifier {
  int _selectedIndex = 0;

  static var items; // Initial selected index

  int get selectedIndex => _selectedIndex; // Getter for selectedIndex

  void updateSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners(); // Notify listeners when the index changes
  }

  late final Future<List<Product>> _products;

  Future<List<Product>> get products => _products;

  static const int _pageSize = 10;

  String? _searchQuery;

  late final Future<List<String>> _categories;
  Future<List<String>> get categories => _categories;

  List<String> selectedCategories = [];

  final PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 0);

  void setSearchQuery(String newQuery) {
    _searchQuery = newQuery.trim().isEmpty ? null : newQuery.trim();
    pagingController.refresh();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await getProductsFromTheServer(pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey as int?);
      }
    } catch (error) {
      print(error);
      pagingController.error = error;
    }
  }

  Future<List<Product>> getProductsFromTheServer(num pageNum) async {
    http.Response response;
    if(_searchQuery==null) {
      response = await http.get(Uri.parse('$apiUrl/products?populate=*&pagination[page]=$pageNum&pagination[pageSize]=$_pageSize'));

    }else{
      response = await http.get(Uri.parse('$apiUrl/products?populate=*&filters[name][\$contains]=$_searchQuery'));
    }

    if (response.statusCode == 200) {
      var body = json.decode(response.body);

      return body["data"].map<Product>((e)=>Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<String>> getAllCategories() async {
    var response = await http
        .get(Uri.parse('https://dummyjson.com/products/category-list'));

    if (response.statusCode == 200) {
      List<String> body = List<String>.from(json.decode(response.body));
      return body.toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  void updateSelectedCategories(List<String> newCategories) {
    selectedCategories = newCategories;
    pagingController.refresh();
  }

  AppState() {
    // _products = getProductsFromTheServer(1);
    pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _categories = getAllCategories();
  }
}
