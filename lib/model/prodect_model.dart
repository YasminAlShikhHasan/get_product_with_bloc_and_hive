// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Products extends Equatable {
  int id;
  String name;
  String description;
  num price;
  String image;
  Products({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  Products copyWith({
    int? id,
    String? name,
    String? description,
    num? price,
    String? image,
  }) {
    return Products(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map) {
    return Products(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as num,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Products.fromJson(String source) =>
      Products.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Products(id: $id, name: $name, description: $description, price: $price, image: $image)';
  }

  @override
  bool operator ==(covariant Products other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        image.hashCode;
  }

  @override
  List<Object?> get props => [id, name, image, price, description];
}
