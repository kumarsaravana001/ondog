class SearchModel {
  bool? status;
  List<SearchModel>? data;

  SearchModel({this.status, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SearchModel>[];
      json['data'].forEach((v) {
        data!.add(new SearchModel.fromJson(v));
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

class SearchModelData {
  String? categoryId;
  String? categoryName;
  List<String>? tags;
  String? status;
  String? submitted;

  SearchModelData(
      {this.categoryId,
      this.categoryName,
      this.tags,
      this.status,
      this.submitted});

  SearchModelData.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    tags = json['tags'].cast<String>();
    status = json['status'];
    submitted = json['submitted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['tags'] = this.tags;
    data['status'] = this.status;
    data['submitted'] = this.submitted;
    return data;
  }
}
