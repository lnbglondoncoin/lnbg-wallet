class NFTModel {
  String image;
  String collectibleId;
  String collectionName;
  String? nftAddress;
  String name;

  NFTModel({
    required this.image,
    required this.collectibleId,
    required this.collectionName,
    this.nftAddress,
    required this.name,
  });

  factory NFTModel.fromJson(Map<String, dynamic> json) {
    return NFTModel(
      image: json['image'] as String,
      collectibleId: json['collectibleId'] as String,
      collectionName: json['collectionName'] as String,
      nftAddress: json['nftAddress'] as String?, // nullable cast
      name: json['name'] as String,
    );
  }
}
