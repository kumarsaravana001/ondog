class ShowEpisodeDetailsModule {
  bool? status;
  List<ShowEpisodeDetailsData>? data;

  ShowEpisodeDetailsModule({this.status, this.data});

  ShowEpisodeDetailsModule.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ShowEpisodeDetailsData>[];
      json['data'].forEach((v) {
        data!.add(new ShowEpisodeDetailsData.fromJson(v));
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

class ShowEpisodeDetailsData {
  String? episodeId;
  String? episodeTitle;
  String? description;
  String? showId;
  List<String>? episodeBanner;
  String? releaseDate;
  String? submitted;
  String? showName;

  ShowEpisodeDetailsData(
      {this.episodeId,
      this.episodeTitle,
      this.description,
      this.showId,
      this.episodeBanner,
      this.releaseDate,
      this.submitted,
      this.showName});

  ShowEpisodeDetailsData.fromJson(Map<String, dynamic> json) {
    episodeId = json['episode_id'];
    episodeTitle = json['episode_title'];
    description = json['description'];
    showId = json['show_id'];
    episodeBanner = json['episode_banner'].cast<String>();
    releaseDate = json['release_date'];
    submitted = json['submitted'];
    showName = json['show_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['episode_id'] = this.episodeId;
    data['episode_title'] = this.episodeTitle;
    data['description'] = this.description;
    data['show_id'] = this.showId;
    data['episode_banner'] = this.episodeBanner;
    data['release_date'] = this.releaseDate;
    data['submitted'] = this.submitted;
    data['show_name'] = this.showName;
    return data;
  }
}
