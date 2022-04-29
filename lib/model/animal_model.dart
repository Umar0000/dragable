import 'package:flutter/material.dart';

@immutable
class AnimalModel {
  String? imageUrl;
  String? title;

  AnimalModel({
    this.imageUrl,
    required this.title,
  });
}
