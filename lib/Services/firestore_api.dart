import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreApi {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  addProductsToDatabase() async {
    var x = {
      "origin_date": Timestamp.fromDate(DateTime.now()),
      "images": [
        "https://lp2.hm.com/hmgoepprod?set=quality%5B79%5D%2Csource%5B%2Fcc%2F78%2Fcc783b01c22bb9a1f73293e2ac74c6d4c2727298.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BDESCRIPTIVESTILLLIFE%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url[file:/product/main]",
        "https://lp2.hm.com/hmgoepprod?set=format%5Bwebp%5D%2Cquality%5B79%5D%2Csource%5B%2F5e%2F83%2F5e83ee58dc42378d023e93f13718a65cb1b8c6a8.jpg%5D%2Corigin%5Bdam%5D%2Ccategory%5B%5D%2Ctype%5BDESCRIPTIVEDETAIL%5D%2Cres%5Bm%5D%2Chmver%5B2%5D&call=url%5Bfile%3A%2Fproduct%2Fmain%5D"
      ],
      "sizes": {"S": 4, "XL": 1, "XS": 6, "L": 3, "M": 4},
      "price": 799,
      "base_text": "",
      "rating": 4.72,
      "name": "Relaxed Fit Sweatshirt",
      "discount": 0.5,
      "description":
          "Top in sweatshirt fabric made from a cotton blend. Relaxed fit with dropped shoulders and ribbing around the neckline, cuffs and hem. Soft brushed inside.",
      "colors_available": ["#A020F0", "#D3D3D3", "#FFFFFF", "#918E85 "],
      "p_id": "EspqKGCCWndsANtbVYnk",
      "tags": ["Men", "Clothes", "Winter", "Hoodies"]
    };

    final docID = await _firebaseFirestore.collection('Products').add(x);
    print(docID);
  }
}
