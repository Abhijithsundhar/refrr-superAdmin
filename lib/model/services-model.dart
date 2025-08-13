import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  final String image;
  final String name;
  final int startingPrice;
  final int endingPrice;
  final int commission;
  final int leadsGiven;
  final DateTime createTime;
  final bool delete;

  ServiceModel({
    required this.image,
    required this.name,
    required this.startingPrice,
    required this.endingPrice,
    required this.commission,
    required this.leadsGiven,
    required this.createTime,
    required this.delete,
  });

  ServiceModel copyWith({
    String? image,
    String? name,
    int? startingPrice,
    int? endingPrice,
    int? commission,
    int? leadsGiven,
    DateTime? createTime,
    bool? delete,
    DocumentReference? reference,
  }) {
    return ServiceModel(
      image: image ?? this.image,
      name: name ?? this.name,
      startingPrice: startingPrice ?? this.startingPrice,
      endingPrice: endingPrice ?? this.endingPrice,
      commission: commission ?? this.commission,
      leadsGiven: leadsGiven ?? this.leadsGiven,
      createTime: createTime ?? this.createTime,
      delete: delete ?? this.delete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'startingPrice': startingPrice,
      'endingPrice': endingPrice,
      'commission': commission,
      'leadsGiven': leadsGiven,
      'createTime': Timestamp.fromDate(createTime),
      'delete': delete,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map, {DocumentReference? reference}) {
    return ServiceModel(
      name: map['name'] as String? ?? '',
      image: map['image'] as String? ?? '',
      startingPrice: map['startingPrice'] as int? ?? 0,
      endingPrice: map['endingPrice'] as int? ?? 0,
      commission: map['commission'] is int ? map['commission'] as int : (map['commission'] as num?)?.toInt() ?? 0,
      leadsGiven: map['leadsGiven'] is int ? map['leadsGiven'] as int : (map['leadsGiven'] as num?)?.toInt() ?? 0,
      createTime: (map['createTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      delete: map['delete'] as bool? ?? false,
    );
  }
}
