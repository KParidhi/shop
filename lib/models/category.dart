import 'package:flutter/material.dart';

enum Categories {
  books,
  stationary,
  electronics,
  daily_use,
  others
}

class Category {
  const Category(this.title, this.color);

  final String title;
  final Color color;
}