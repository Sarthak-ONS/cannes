import 'package:cannes/Providers/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../Models/cart_product_model.dart';

class DisplayCartScreen extends StatefulWidget {
  const DisplayCartScreen({Key? key}) : super(key: key);

  @override
  State<DisplayCartScreen> createState() => _DisplayCartScreenState();
}

class _DisplayCartScreenState extends State<DisplayCartScreen> {
  final ScrollController? _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  bool showPayContainer = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, myValue, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Cart',
              style: TextStyle(color: Colors.black),
            ),
            elevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {},
            label: Text('Pay ${myValue.totalCost.toString()}'),
          ),
          body: NotificationListener<UserScrollNotification>(
            onNotification: (value) {
              if (value.direction == ScrollDirection.forward ||
                  value.direction == ScrollDirection.idle) {
                if (!showPayContainer) {
                  setState(() => showPayContainer = true);
                }
              } else if (value.direction == ScrollDirection.reverse) {
                if (showPayContainer) {
                  setState(() => showPayContainer = false);
                }
              }
              return true;
            },
            child: Stack(
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: _scrollController,
                  itemCount: myValue.products!.length,
                  itemBuilder: (context, index) {
                    if (myValue.products!.isEmpty) {
                      return const Center(
                        child: Text(
                          "OOPS!, Your Cart is Empty",
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white54,
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 100,
                                child: Image.network(myValue
                                    .products![index].product!.images![0]),
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    myValue.products![index].product!.name!,
                                  ),
                                  Text(
                                    "Price : ${myValue.products![index].product!.price!.toString()}",
                                  ),
                                  Text(
                                    "Quantity : ${myValue.products![index].qunatity.toString()}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Size : ${myValue.products![index].size}",
                                  ),
                                ],
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              print(myValue.products![index].size);
                              myValue.removeFromProductList(
                                CartProductModel(
                                  product: myValue.products![index].product,
                                  color: myValue.products![index].color,
                                  size: myValue.products![index].size,
                                ),
                                context,
                              );
                            },
                            icon: const Icon(
                              CupertinoIcons.delete,
                              color: Colors.redAccent,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
