class PurchaseUrl {
  final String url;

  PurchaseUrl({required this.url});

  factory PurchaseUrl.fromJson(String jsonUrl) {
    return PurchaseUrl(url: jsonUrl);
  }
}
