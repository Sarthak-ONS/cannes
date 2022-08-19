import 'package:cannes/Providers/cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

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

  double increaseHeight = 0;

  bool showPayContainer = false;

  getModalbottomSheet() {
    return showBottomSheet(
      context: context,
      builder: (context) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 300,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: NotificationListener<UserScrollNotification>(
        onNotification: (value) {
          if (value.direction == ScrollDirection.forward) {
            if (!showPayContainer) {
              for (var i = 0; i < 300; i++) {
                increaseHeight++;
              }
              setState(() => showPayContainer = true);
            }
          } else if (value.direction == ScrollDirection.reverse) {
            if (showPayContainer) {
              for (var i = 0; i < 300; i++) {
                increaseHeight++;
              }
              setState(() => showPayContainer = false);
            }
          }
          return true;
        },
        child: Consumer<CartProvider>(
          builder: (context, myValue, child) {
            return Stack(
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
                            onPressed: () {},
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
                showPayContainer
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 3),
                          curve: Curves.fastOutSlowIn,
                          height: increaseHeight,
                          color: Colors.red,
                        ),
                      )
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }
}
