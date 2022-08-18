import 'package:cannes/Providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayCartScreen extends StatefulWidget {
  const DisplayCartScreen({Key? key}) : super(key: key);

  @override
  State<DisplayCartScreen> createState() => _DisplayCartScreenState();
}

class _DisplayCartScreenState extends State<DisplayCartScreen> {
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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Text(
        //       "Total Products :  ${Provider.of<CartProvider>(context).products!.length.toString()}",
        //       style: const TextStyle(
        //         color: Colors.black,
        //         fontSize: 15,
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, myValue, child) {
          return ListView.builder(
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Image.network(
                          myValue.products![index].product!.images![0]),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          myValue.products![index].product!.name!,
                        ),
                        Text(
                          "Price : ${myValue.products![index].product!.price!.toString()}",
                        ),
                        Text(
                          "Quantity : ${myValue.products![index].qunatity.toString()}",
                        ),
                        Text(
                          "Size : ${myValue.products![index].size}",
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
