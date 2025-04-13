class NFTModel {
  String image;
  String collectibleId;
  String collectionName;
  String nftAddress;
  String name;

  NFTModel({
    required this.image,
    required this.collectibleId,
    required this.collectionName,
    required this.nftAddress,
    required this.name,
  });

  // From JSON to NFTModel
  factory NFTModel.fromJson(Map<String, dynamic> json) {
    return NFTModel(
      image: json['image'] as String,
      collectibleId: json['collectibleId'] as String,
      collectionName: json['collectionName'] as String,
      nftAddress: json['nftAddress'] as String,
      name: json['name'] as String,
    );
  }
}
