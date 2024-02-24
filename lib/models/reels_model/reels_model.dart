class ReelsModel {
  bool? status;
  String? message;
  List<ReelsData>? data;

  ReelsModel({this.status, this.message, this.data});

  ReelsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ReelsData>[];
      json['data'].forEach((v) {
        data!.add(new ReelsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReelsData {
  String? reelId;
  String? title;
  String? description;
  String? showId;
  String? duration;
  List<String>? thumbnail;
  String? videoUrl;
  String? submitted;

  ReelsData(
      {this.reelId,
      this.title,
      this.description,
      this.showId,
      this.duration,
      this.thumbnail,
      this.videoUrl,
      this.submitted});

  ReelsData.fromJson(Map<String, dynamic> json) {
    reelId = json['reel_id'];
    title = json['title'];
    description = json['description'];
    showId = json['show_id'];
    duration = json['duration'];
    thumbnail = json['thumbnail'].cast<String>();
    videoUrl = json['video_url'];
    submitted = json['submitted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reel_id'] = this.reelId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['show_id'] = this.showId;
    data['duration'] = this.duration;
    data['thumbnail'] = this.thumbnail;
    data['video_url'] = this.videoUrl;
    data['submitted'] = this.submitted;
    return data;
  }
}
