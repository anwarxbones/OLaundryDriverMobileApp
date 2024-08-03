import 'package:hive/hive.dart';

part 'add_ons_model.g.dart';

@HiveType(typeId: 1)
class AddOns extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final double price;

  @HiveField(2)
  final String name;

  AddOns({
    required this.id,
    required this.price,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'name': name,
    };
  }

  factory AddOns.fromMap(Map<String, dynamic> map) {
    return AddOns(
      id: map['id'] as int,
      price: map['price'] as double,
      name: map['name'] as String,
    );
  }
}
