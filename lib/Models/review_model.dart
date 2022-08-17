class ReviewModel {
  final String? userID;
  final String? userName;
  final String? reviewDescription;
  final String? productID;
  final bool? containsImage;
  final String? imageUrl;

  ReviewModel(
      {this.userID,
      this.userName,
      this.reviewDescription,
      this.productID,
      this.containsImage,
      this.imageUrl});
}
