import 'package:rostoms_app/features/common/data/models/base_model.dart';
import 'package:rostoms_app/features/products/domain/entities/review_entity.dart';

class ReviewModel extends BaseModel<ReviewEntity> {
  final int? rating;
  final String? comment;
  final String? reviewerName;

  ReviewModel({
    required this.rating,
    required this.comment,
    required this.reviewerName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json['rating'],
      comment: json['comment'],
      reviewerName: json['reviewerName'],
    );
  }

  @override
  ReviewEntity toEntity() {
    return ReviewEntity(
      rating: rating ?? 0,
      comment: comment ?? "No Comment",
      reviewerName: reviewerName ?? "Unknown",
    );
  }
}
