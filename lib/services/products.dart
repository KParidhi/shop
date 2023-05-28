import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home/pages/ItemForm.dart';
import 'package:home/services/product_list.dart';
import 'package:home/services/user_product.dart';

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProducts = ref.watch(userProductsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) =>  ItemForm(),
                ),
              );
            },
          ),
        ],
      ),
      body: ProductList(
        products: userProducts,
      ),
    );
  }
}