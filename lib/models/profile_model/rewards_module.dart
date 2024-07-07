class RewardsUrl {
  final String rewardurl;

  RewardsUrl({required this.rewardurl});

  factory RewardsUrl.fromJson(String jsonUrl) {
    return RewardsUrl(rewardurl: jsonUrl);
  }
}
