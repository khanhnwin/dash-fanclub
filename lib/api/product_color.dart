import 'package:flutter/material.dart';

// TODO: Move this class
abstract class SelectableOption {
  Color get color;

  const SelectableOption();
}

class ProductSize extends SelectableOption {
  const ProductSize(this.name);

  final String name;

  @override
  String toString() => name;

  @override
  Color get color => Colors.white;
}

class ProductColor extends SelectableOption {
  final String name;

  @override
  final Color color;

  const ProductColor({required this.name, required this.color});

  @override
  String toString() {
    return name;
  }
}
