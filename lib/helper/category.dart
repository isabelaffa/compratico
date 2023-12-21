import 'package:flutter/material.dart';

class CategoryHelper {
  Map<String, dynamic> getCategoryDecoration(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return {
          'icon': Icons.local_dining,
          'color': Color(0xFFF79256),
          // Adicione mais propriedades conforme necessário
        };
      case 'beverages':
        return {
          'icon': Icons.local_drink,
          'color': Color(0xFF7DCFB6),
          // Adicione mais propriedades conforme necessário
        };
      case 'hygiene':
        return {
          'icon': Icons.shower,
          'color': Color(0xFFFBD1A2),
          // Adicione mais propriedades conforme necessário
        };
      case 'cleaning':
        return {
          'icon': Icons.sanitizer,
          'color': Color(0xFF1D4E89),
          // Adicione mais propriedades conforme necessário
        };
      case 'frozen':
        return {
          'icon': Icons.ac_unit,
          'color': Color(0xFF00B2CA),
          // Adicione mais propriedades conforme necessário
        };
      default:
        return {
          'icon': Icons.shopping_cart,
          'color': Colors.grey,
          // Adicione mais propriedades conforme necessário
        };
    }
  }
}
