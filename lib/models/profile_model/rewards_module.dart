class UserRewardsModel {
  final List<String> rewardsimagePaths;

  UserRewardsModel({required this.rewardsimagePaths});

  factory UserRewardsModel.fromJson(Map<String, dynamic> json) {
    List<String> paths = [];
    if (json['images'] != null) {
      json['images'].forEach((v) {
        paths.add(v); // Assuming 'v' is a string URL
      });
    }
    return UserRewardsModel(rewardsimagePaths: paths);
  }
}
