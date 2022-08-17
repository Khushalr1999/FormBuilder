class formModel {
  String? title;
  String? question;
  String? options;
  List<String>? ansOption;
  formModel({this.title, this.question, this.options, this.ansOption});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['question'] = question;
    data['options'] = options;
    data['ansOptions'] = ansOption;
    return data;
  }
}
