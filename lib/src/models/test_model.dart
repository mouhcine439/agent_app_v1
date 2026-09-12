class TestModel {
  String id, title, body;

  TestModel({
    required this.id,
    required this.title,
    required this.body,
  });
  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'].toString(),
      title: json['title'].toString(),
      body: json['body'].toString(),
    );
  }
}
