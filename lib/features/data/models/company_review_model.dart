class ReviewModel {
  String? reviewId;
  String? reviewTitle;
  String? reviewText;
  int? reviewRating;
  bool? reviewIsVerified;
  bool? reviewIsPending;
  int? reviewLikes;
  String? reviewLanguage;
  String? reviewTime;
  String? reviewExperiencedTime;
  String? replyText;
  String? consumerId;
  String? consumerName;
  String? consumerImage;
  int? consumerReviewCount;
  String? consumerCountry;
  bool? consumerIsVerified;
  int? consumerReviewCountSameDomain;

  ReviewModel({
    this.reviewId,
    this.reviewTitle,
    this.reviewText,
    this.reviewRating,
    this.reviewIsVerified,
    this.reviewIsPending,
    this.reviewLikes,
    this.reviewLanguage,
    this.reviewTime,
    this.reviewExperiencedTime,
    this.replyText,
    this.consumerId,
    this.consumerName,
    this.consumerImage,
    this.consumerReviewCount,
    this.consumerCountry,
    this.consumerIsVerified,
    this.consumerReviewCountSameDomain,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    reviewId: json["review_id"],
    reviewTitle: json["review_title"],
    reviewText: json["review_text"],
    reviewRating: json["review_rating"],
    reviewIsVerified: json["review_is_verified"],
    reviewIsPending: json["review_is_pending"],
    reviewLikes: json["review_likes"],
    reviewLanguage: json["review_language"],
    reviewTime: json["review_time"],
    reviewExperiencedTime: json["review_experienced_time"] ?? '',
    replyText: json["reply_text"] ?? '',
    consumerId: json["consumer_id"],
    consumerName: json["consumer_name"],
    consumerImage: json["consumer_image"],
    consumerReviewCount: json["consumer_review_count"],
    consumerCountry: json["consumer_country"],
    consumerIsVerified: json["consumer_is_verified"],
    consumerReviewCountSameDomain: json["consumer_review_count_same_domain"],
  );

  Map<String, dynamic> toJson() => {
    "review_id": reviewId,
    "review_title": reviewTitle,
    "review_text": reviewText,
    "review_rating": reviewRating,
    "review_is_verified": reviewIsVerified,
    "review_is_pending": reviewIsPending,
    "review_likes": reviewLikes,
    "review_language": reviewLanguage,
    "review_time": reviewTime,
    "review_experienced_time": reviewExperiencedTime,
    "reply_text": replyText,
    "consumer_id": consumerId,
    "consumer_name": consumerName,
    "consumer_image": consumerImage,
    "consumer_review_count": consumerReviewCount,
    "consumer_country": consumerCountry,
    "consumer_is_verified": consumerIsVerified,
    "consumer_review_count_same_domain": consumerReviewCountSameDomain,
  };
}
