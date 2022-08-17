import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreApi {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  addProductsToDatabase() async {
    var x = {
      "origin_date": Timestamp.fromDate(DateTime.now()),
      "images": [
        "https://user-images.githubusercontent.com/57105611/185140143-5b4cbd88-ee46-467b-9f71-363f73d51574.jpg",
        "https://user-images.githubusercontent.com/57105611/185140450-8f90af8a-c495-4b7a-aa24-8e5f1a075d39.jpg",
        "https://user-images.githubusercontent.com/57105611/185140657-c1daab6c-bc94-4944-9f7e-2f4a27767904.jpg",
      ],
      "sizes": {"S": 4, "XL": 1, "XS": 6, "L": 3, "M": 4},
      "price": 1499,
      "base_text": "Conscious choice",
      "rating": 4.20,
      "name": "Ribbed cut-out dress",
      "discount": 0.5,
      "description":
          "Fitted, calf-length dress in ribbed jersey with a sweetheart neckline and cut-out sections at the front with narrow straps that tie at the back of the neck. Long sleeves and gathered elastication at the front for a draped effect. Unlined",
      "colors_available": ["#ff0000", "#D82E2F", "#5DA3FA", "#6EC72D"],
      "p_id": "EspqKGCCWndsANtbVYnk",
      "tags": ["Ladies", "Clothes", "Hoodies", "Winter", "Sweat Shirt"]
    };

    final docID = await _firebaseFirestore.collection('Products').add(x);
    print(docID);
  }
}
