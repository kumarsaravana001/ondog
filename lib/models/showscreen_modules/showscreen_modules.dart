class ShowDetailsModule {
  bool? status;
  List<ShowDetailsData>? data;

  ShowDetailsModule({this.status, this.data});

  ShowDetailsModule.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <ShowDetailsData>[];
      json['data'].forEach((v) {
        data!.add(ShowDetailsData.fromJson(v));
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

class ShowDetailsData {
  String? showId;
  String? showName;
  String? description;
  String? categoryId;
  List<String>? thumbnail;
  String? showTeaser;
  String? totalEpisodes;
  String? totalDuration;
  String? releaseDate;
  List<String>? language;
  List<String>? subtitle;
  String? director;
  String? producer;
  String? actorArtist;
  String? popularLink;
  String? homepage;
  String? submitted;
  String? categoryName;
  String? tags;

  ShowDetailsData({
    this.showId,
    this.showName,
    this.description,
    this.categoryId,
    this.thumbnail,
    this.showTeaser,
    this.totalEpisodes,
    this.totalDuration,
    this.releaseDate,
    this.language,
    this.subtitle,
    this.director,
    this.producer,
    this.actorArtist,
    this.popularLink,
    this.homepage,
    this.submitted,
    this.categoryName,
    this.tags,
  });

  ShowDetailsData.fromJson(Map<String, dynamic> json) {
    showId = json['show_id'];
    showName = json['show_name'];
    description = json['description'];
    categoryId = json['category_id'];
    thumbnail = json['thumbnail'].cast<String>();
    showTeaser = json['show_teaser'];
    totalEpisodes = json['total_episodes'];
    totalDuration = json['total_duration'];
    releaseDate = json['release_date'];
    language = json['language'].cast<String>();
    subtitle = json['subtitle'].cast<String>();
    director = json['director'];
    producer = json['producer'];
    actorArtist = json['actor_artist'];
    popularLink = json['popular_link'];
    homepage = json['homepage'];
    submitted = json['submitted'];
    categoryName = json['category_name'];
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_id'] = this.showId;
    data['show_name'] = this.showName;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['thumbnail'] = this.thumbnail;
    data['show_teaser'] = this.showTeaser;
    data['total_episodes'] = this.totalEpisodes;
    data['total_duration'] = this.totalDuration;
    data['release_date'] = this.releaseDate;
    data['language'] = this.language;
    data['subtitle'] = this.subtitle;
    data['director'] = this.director;
    data['producer'] = this.producer;
    data['actor_artist'] = this.actorArtist;
    data['popular_link'] = this.popularLink;
    data['homepage'] = this.homepage;
    data['submitted'] = this.submitted;
    data['category_name'] = this.categoryName;
    data['tags'] = this.tags;
    return data;
  }
}
