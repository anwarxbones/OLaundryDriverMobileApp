import 'package:hive/hive.dart';

part 'add_ons_model.g.dart';

@HiveType(typeId: 1)
class AddOns extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final double price;

  AddOns({
    required this.id,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
    };
  }

  factory AddOns.fromMap(Map<String, dynamic> map) {
    return AddOns(
      id: map['id'] as int,
      price: map['price'] as double,
    );
  }
}
