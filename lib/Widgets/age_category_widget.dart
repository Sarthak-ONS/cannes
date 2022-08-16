import 'package:flutter/material.dart';

import '../list_main_categories.dart';

class AgeCategoryWidget extends StatelessWidget {
  const AgeCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: listMainCategories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                listMainCategories[index],
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 22,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
