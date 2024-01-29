class HomeCategoryList {
  bool? status;
  List<CategoryListData>? data;

  HomeCategoryList({this.status, this.data});

  HomeCategoryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CategoryListData>[];
      json['data'].forEach((v) {
        data!.add(CategoryListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryListData {
  String? categoryId;
  String? categoryName;
  // String? tags;
  String? status;
  String? submitted;

  CategoryListData(
      {this.categoryId,
      this.categoryName,
      // this.tags,
      this.status,
      this.submitted});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'] as String;
    categoryName = json['category_name'] as String;
    // tags = json['tags'] as String;
    status = json['status'] as String;
    submitted = json['submitted'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    // data['tags'] = this.tags;
    data['status'] = this.status;
    data['submitted'] = this.submitted;
    return data;
  }
}
