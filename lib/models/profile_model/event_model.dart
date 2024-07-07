class EventModel {
  bool? status;
  List<EventData>? data;

  EventModel({this.status, this.data});

  EventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <EventData>[];
      json['data'].forEach((v) {
        data!.add(new EventData.fromJson(v));
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

class EventData {
  String? id;
  String? eventTitle;
  String? eventDate;
  String? imagePath;
  String? submitted;

  EventData(
      {this.id,
      this.eventTitle,
      this.eventDate,
      this.imagePath,
      this.submitted});

  EventData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventTitle = json['event_title'];
    eventDate = json['event_date'];
    imagePath = json['image_path'];
    submitted = json['submitted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_title'] = this.eventTitle;
    data['event_date'] = this.eventDate;
    data['image_path'] = this.imagePath;
    data['submitted'] = this.submitted;
    return data;
  }
}
