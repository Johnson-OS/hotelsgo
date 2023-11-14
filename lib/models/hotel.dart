
class Hotel{

  String name;
  int stars;
  int price;
  String currency;
  String image;
  double reviewScore;
  String review;
  String address;

  Hotel({
    required this.name,
    required this.stars,
    required this.price,
    required this.currency,
    required this.image,
    required this.reviewScore,
    required this.review,
    required this.address
  });

  factory Hotel.fromJsn(Map<String, dynamic> jsn) => Hotel(
    name: jsn['name'],
      stars: jsn['starts'],
      price: jsn['price'],
      currency: jsn['currency'],
      image: jsn['image'],
      reviewScore: double.parse(jsn['review_score'].toString()),
      review: jsn['review'],
      address: jsn['address']
  );

}