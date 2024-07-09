import 'package:flutter_riverpod/flutter_riverpod.dart';

//Bottombar State
final appBottomBarIndexProvider = StateProvider<int>((ref) {
  return 0;
});
//Bottombar State
final appOrderTabIndexProvider = StateProvider<int>((ref) {
  return 0;
});

//One Signal Player ID
final onesignalDeviceIDProvider = StateProvider<String>((ref) {
  return '';
});
