class QuizDetailsModule {
  bool? status;
  List<QuizDetailsData>? data;

  QuizDetailsModule({this.status, this.data});

  QuizDetailsModule.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <QuizDetailsData>[];
      json['data'].forEach((v) {
        data!.add(QuizDetailsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuizDetailsData {
  String? questionId;
  String? question;
  String? choices;
  String? answer;
  String? showId;
  String? episodeId;
  String? submitted;

  QuizDetailsData(
      {this.questionId,
      this.question,
      this.choices,
      this.answer,
      this.showId,
      this.episodeId,
      this.submitted});

  QuizDetailsData.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    question = json['question'];
    choices = json['choices'];
    answer = json['answer'];
    showId = json['show_id'];
    episodeId = json['episode_id'];
    submitted = json['submitted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['question'] = this.question;
    data['choices'] = this.choices;
    data['answer'] = this.answer;
    data['show_id'] = this.showId;
    data['episode_id'] = this.episodeId;
    data['submitted'] = this.submitted;
    return data;
  }
}
