import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:home/services/product.dart';


class UserProductsNotifier extends StateNotifier<List<Product>> {
  UserProductsNotifier() : super(const []);

  void addProduct(String title) {
    final newProduct = Product(title: title);
    state = [newProduct, ...state];
  }
}

final userProductsProvider =
StateNotifierProvider<UserProductsNotifier, List<Product>>(
      (ref) => UserProductsNotifier(),
);