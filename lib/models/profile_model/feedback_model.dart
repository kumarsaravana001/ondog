// Assuming feedbackModel is defined in a separate file
class feedbackModel {
  bool? status;
  String? message;

  feedbackModel({this.status, this.message});

  feedbackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}
