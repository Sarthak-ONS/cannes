class ReviewPageModelArguements {
  final String? pid;
  final String? userID;
  final String? title;

  ReviewPageModelArguements({this.pid, this.userID, this.title});

  Map<dynamic, dynamic> toMap() {
    return {
      "pid": pid,
      "user_id": userID,
      "title": title,
    };
  }
}
