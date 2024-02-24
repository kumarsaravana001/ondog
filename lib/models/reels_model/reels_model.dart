class ReelsModule {
  bool? status;
  String? message;
  List<ReelsData>? data;

  ReelsModule({this.status, this.message, this.data});

  ReelsModule.fromJson(Map<String, dynamic> json) {
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
  String? videoId;
  String? episodeId;
  String? episodeNo;
  String? title;
  String? videoName;
  String? description;
  String? showId;
  String? duration;
  List<String>? thumbnail;
  String? url;
  String? teaserUrl;
  Null? metaTags;
  String? publishDate;
  String? teamDetails;
  String? partnerDetails;
  String? submitted;

  ReelsData(
      {this.videoId,
      this.episodeId,
      this.episodeNo,
      this.title,
      this.videoName,
      this.description,
      this.showId,
      this.duration,
      this.thumbnail,
      this.url,
      this.teaserUrl,
      this.metaTags,
      this.publishDate,
      this.teamDetails,
      this.partnerDetails,
      this.submitted});

  ReelsData.fromJson(Map<String, dynamic> json) {
    videoId = json['video_id'];
    episodeId = json['episode_id'];
    episodeNo = json['episode_no'];
    title = json['title'];
    videoName = json['video_name'];
    description = json['description'];
    showId = json['show_id'];
    duration = json['duration'];
    thumbnail = json['thumbnail'].cast<String>();
    url = json['url'];
    teaserUrl = json['teaser_url'];
    metaTags = json['meta_tags'];
    publishDate = json['publish_date'];
    teamDetails = json['team_details'];
    partnerDetails = json['partner_details'];
    submitted = json['submitted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['video_id'] = this.videoId;
    data['episode_id'] = this.episodeId;
    data['episode_no'] = this.episodeNo;
    data['title'] = this.title;
    data['video_name'] = this.videoName;
    data['description'] = this.description;
    data['show_id'] = this.showId;
    data['duration'] = this.duration;
    data['thumbnail'] = this.thumbnail;
    data['url'] = this.url;
    data['teaser_url'] = this.teaserUrl;
    data['meta_tags'] = this.metaTags;
    data['publish_date'] = this.publishDate;
    data['team_details'] = this.teamDetails;
    data['partner_details'] = this.partnerDetails;
    data['submitted'] = this.submitted;
    return data;
  }
}
