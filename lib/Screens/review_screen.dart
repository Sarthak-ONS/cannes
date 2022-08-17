import 'package:cannes/Models/review_model_screen_arguements.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key, this.reviewPageModelArguements})
      : super(key: key);

  final ReviewPageModelArguements? reviewPageModelArguements;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Write A Review',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.reviewPageModelArguements!.title!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 25.0,
            ),
            const TextField(
              maxLines: 10,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  hintText: 'Please write a review'),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: const [Text('Attach A Image'), Icon(Icons.attach_file)],
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Submit Review'))
          ],
        ),
      ),
    );
  }
}
