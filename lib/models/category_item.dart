import 'package:home/models/category.dart';

class CategoryItem {
  const CategoryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
    required this.image,
  });

  final String id;
  final String name;
  final int quantity;
  final Category category;
  final String? image;
}