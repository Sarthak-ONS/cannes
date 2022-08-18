import 'package:cannes/Models/review_model_screen_arguements.dart';
import 'package:cannes/Providers/cart.dart';
import 'package:cannes/Providers/product_config_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/cart_product_model.dart';
import '../Models/product_model.dart';
import '../Widgets/custom_small_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key, required this.pid}) : super(key: key);

  final String pid;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    print(widget.pid);
  }

  final double kPadding = 15;

  String? selectedSize;
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('Products')
            .doc(widget.pid)
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Please try again later!'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  Text('Fetching Product Details')
                ],
              ),
            );
          }

          Timestamp or = snapshot.data.get("origin_date");
          Product currentProduct = Product(
            name: snapshot.data.get("name"),
            sizes: snapshot.data.get("sizes"),
            description: snapshot.data.get("description"),
            pID: snapshot.data.get("p_id"),
            colors: snapshot.data.get("colors_available"),
            originDateTime:
                DateTime.fromMicrosecondsSinceEpoch(or.microsecondsSinceEpoch),
            price: double.parse(snapshot.data.get("price").toString()),
            baseText: snapshot.data.get("base_text"),
            discount: snapshot.data.get("discount"),
            images: snapshot.data.get("images"),
            rating: snapshot.data.get("rating"),
            tags: snapshot.data.get("tags"),
          );

          return Stack(
            children: [
              ListView(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: PageView.builder(
                      itemCount: snapshot.data.get("images").length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          snapshot.data.get("images")[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: kPadding, top: kPadding),
                    child: const Text(
                      "H&M",
                      style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: kPadding),
                    child: Text(
                      snapshot.data.get("name"),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PoppinsRegular',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: kPadding),
                    child: Text(
                      "${NumberFormat.currency(
                        locale: 'en_IN',
                        symbol: '₹',
                      ).format(snapshot.data.get("price"))} Per Unit",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: kPadding),
                    child: const Text(
                      "Choose a Color",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: kPadding),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    height: 75,
                    child: SelectFromColorWidget(
                        colors: snapshot.data.get("colors_available")),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: kPadding),
                    child: const Text(
                      "Choose a Size",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: kPadding),
                    margin: const EdgeInsets.only(top: 5.0),
                    height: 60,
                    child: SelectFromSizeWidget(
                      sizes: snapshot.data.get('sizes'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: kPadding, right: kPadding),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AddToCartButton(
                          currentProduct: currentProduct,
                          size: selectedSize,
                          colorOfChosenSize: selectedColor,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Timestamp or = snapshot.data.get("origin_date");
                            Product currentProduct = Product(
                              name: snapshot.data.get("name"),
                              sizes: snapshot.data.get("sizes"),
                              description: snapshot.data.get("description"),
                              pID: snapshot.data.get("p_id"),
                              colors: snapshot.data.get("colors_available"),
                              originDateTime:
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      or.microsecondsSinceEpoch),
                              price: double.parse(
                                  snapshot.data.get("price").toString()),
                              baseText: snapshot.data.get("base_text"),
                              discount: snapshot.data.get("discount"),
                              images: snapshot.data.get("images"),
                              rating: snapshot.data.get("rating"),
                              tags: snapshot.data.get("tags"),
                            );
                            List<CartProductModel> productsListInCart =
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .products!;

                            for (var element in productsListInCart) {
                              if (element.product!.pID == currentProduct.pID) {
                                print(true);
                              }
                            }
                          },
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(color: Colors.black),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orangeAccent),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 15.0, left: kPadding, right: kPadding),
                    child: Text(
                      snapshot.data.get("description"),
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: kPadding),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/reviewScreen',
                          arguments: ReviewPageModelArguements(
                            pid: snapshot.data.get("p_id"),
                            userID: "userId To BE Added",
                            title: snapshot.data.get("name"),
                          ),
                        );
                      },
                      child: Row(
                        children: const [
                          Text(
                            "Write A Review",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Icon(
                            Icons.create,
                            size: 17,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 10, horizontal: kPadding),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    color: const Color(0xff5CB270).withOpacity(0.5),
                    child: Column(
                      children: const [
                        Text(
                          "By 2030, we aim to only work with reycled, organic, or other more sustainablity sourced materials.",
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Right now, we are at 80%.",
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                            "Curious about what we are doing, check out are work!"),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 30,
                left: 10,
                child: FloatinCustomIcon(
                  iconData: Icons.arrow_back,
                  callBack: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Positioned(
                top: 30,
                right: 10,
                child: FloatinCustomIcon(
                  iconData: CupertinoIcons.heart,
                  callBack: () {},
                ),
              ),
              Positioned(
                top: 70,
                right: 10,
                child: Stack(
                  children: [
                    Center(
                      child: FloatinCustomIcon(
                        iconData: CupertinoIcons.cart,
                        callBack: () {},
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 8,
                        child: Text(
                          Provider.of<CartProvider>(context)
                              .products!
                              .length
                              .toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SelectFromColorWidget extends StatefulWidget {
  const SelectFromColorWidget({Key? key, required this.colors})
      : super(key: key);

  final List? colors;

  @override
  State<SelectFromColorWidget> createState() => _SelectFromColorWidgetState();
}

class _SelectFromColorWidgetState extends State<SelectFromColorWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.colors!.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            print(widget.colors![index]);
            setState(() {
              _selectedIndex = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, right: 0),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: _selectedIndex == index
                  ? const Border(
                      bottom: BorderSide(color: Colors.black, width: 1.5))
                  : null,
            ),
            child: Container(
              margin: const EdgeInsets.only(right: 5, top: 0),
              width: 60,
              decoration: BoxDecoration(
                color: Color(int.parse(widget.colors![index])),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SelectFromSizeWidget extends StatefulWidget {
  const SelectFromSizeWidget({Key? key, required this.sizes}) : super(key: key);

  final Map sizes;

  @override
  State<SelectFromSizeWidget> createState() => _SelectFromSizeWidgetState();
}

class _SelectFromSizeWidgetState extends State<SelectFromSizeWidget> {
  @override
  void initState() {
    super.initState();
  }

  int findInAList(String str, List l) {
    for (int i = 0; i < l.length; i++) {
      if (l[i] == str) {
        return i;
      }
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductConfigProvider>(
      builder: (context, myvalue, child) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.sizes.length,
          itemBuilder: (BuildContext context, int index) {
            Map x = widget.sizes;
            print(x.containsKey(myvalue.selectedSize));

            int _selectedIndex =
                findInAList(myvalue.selectedSize!, x.keys.toList());
            return GestureDetector(
              onTap: () {
                Provider.of<ProductConfigProvider>(context, listen: false)
                    .chnageSizeOfProduct(size: x.keys.toList()[index]);
                // setState(() {
                //   _selectedIndex = index;
                //   print(x.keys.toList()[index]);
                // });
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: CircleAvatar(
                  radius: 22,
                  backgroundColor:
                      _selectedIndex == index ? Colors.black : Colors.black38,
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Text(
                      x.keys.toList()[index],
                      style: TextStyle(
                          color: _selectedIndex == index
                              ? Colors.black
                              : Colors.grey),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class AddToCartButton extends StatefulWidget {
  const AddToCartButton(
      {Key? key,
      required this.currentProduct,
      required this.size,
      required this.colorOfChosenSize})
      : super(key: key);

  final Product currentProduct;
  final String? size;
  final String? colorOfChosenSize;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  void initState() {
    super.initState();
    // initProviders();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Provider.of<CartProvider>(context, listen: false).addToProductList(
          CartProductModel(
            product: widget.currentProduct,
            configurationOfProduct: {
              widget.size!: widget.colorOfChosenSize!,
            },
          ),
        );
      },
      child: const Text(
        'Add to Cart',
        style: TextStyle(color: Colors.black),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
