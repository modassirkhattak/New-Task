// product_model.dart
class ProductModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String brand;
  final String sku;
  final int weight;
  final Dimensions dimensions;
  final String warrantyInformation;
  final String shippingInformation;
  final String availabilityStatus;
  final List<Review> reviews;
  final String returnPolicy;
  final int minimumOrderQuantity;
  final Meta meta;
  final List<String> images;
  final String thumbnail;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int? ?? 0, // Default to 0 if null
      title: json['title'] as String? ?? '', // Default to empty string if null
      description:
          json['description'] as String? ??
          '', // Default to empty string if null
      category:
          json['category'] as String? ?? '', // Default to empty string if null
      price:
          (json['price'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
      discountPercentage:
          (json['discountPercentage'] as num?)?.toDouble() ??
          0.0, // Default to 0.0 if null
      rating:
          (json['rating'] as num?)?.toDouble() ?? 0.0, // Default to 0.0 if null
      stock: json['stock'] as int? ?? 0, // Default to 0 if null
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          [], // Default to empty list if null
      brand: json['brand'] as String? ?? '', // Default to empty string if null
      sku: json['sku'] as String? ?? '', // Default to empty string if null
      weight: json['weight'] as int? ?? 0, // Default to 0 if null
      dimensions: Dimensions.fromJson(
        json['dimensions'] as Map<String, dynamic>? ?? {},
      ), // Default to empty map if null
      warrantyInformation:
          json['warrantyInformation'] as String? ??
          '', // Default to empty string if null
      shippingInformation:
          json['shippingInformation'] as String? ??
          '', // Default to empty string if null
      availabilityStatus:
          json['availabilityStatus'] as String? ??
          '', // Default to empty string if null
      reviews:
          (json['reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [], // Default to empty list if null
      returnPolicy:
          json['returnPolicy'] as String? ??
          '', // Default to empty string if null
      minimumOrderQuantity:
          json['minimumOrderQuantity'] as int? ?? 0, // Default to 0 if null
      meta: Meta.fromJson(
        json['meta'] as Map<String, dynamic>? ?? {},
      ), // Default to empty map if null
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [], // Default to empty list if null
      thumbnail:
          json['thumbnail'] as String? ?? '', // Default to empty string if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      'brand': brand,
      'sku': sku,
      'weight': weight,
      'dimensions': dimensions.toJson(),
      'warrantyInformation': warrantyInformation,
      'shippingInformation': shippingInformation,
      'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((r) => r.toJson()).toList(),
      'returnPolicy': returnPolicy,
      'minimumOrderQuantity': minimumOrderQuantity,
      'meta': meta.toJson(),
      'images': images,
      'thumbnail': thumbnail,
    };
  }
}

class Dimensions {
  final double width;
  final double height;
  final double depth;

  Dimensions({required this.width, required this.height, required this.depth});

  factory Dimensions.fromJson(Map<String, dynamic> json) {
    return Dimensions(
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      depth: (json['depth'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'width': width, 'height': height, 'depth': depth};
  }
}

class Review {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'] as int? ?? 0,
      comment: json['comment'] as String? ?? '',
      date: json['date'] as String? ?? '',
      reviewerName: json['reviewerName'] as String? ?? '',
      reviewerEmail: json['reviewerEmail'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date,
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}

class Meta {
  final String createdAt;
  final String updatedAt;
  final String barcode;
  final String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      barcode: json['barcode'] as String? ?? '',
      qrCode: json['qrCode'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'barcode': barcode,
      'qrCode': qrCode,
    };
  }
}
