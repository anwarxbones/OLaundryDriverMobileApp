
// import 'package:permission_handler/permission_handler.dart';

// class PermissionService {
//   // create singleton
//   static final PermissionService _permissionService =
//       PermissionService._internal();
//   factory PermissionService() => _permissionService;
//   PermissionService._internal();
//   Future<void> requestPermission() async {
//     // Request microphone permission
//     var microphonePermission = await Permission.microphone.request();

//     if (microphonePermission.isGranted) {
//       debugPrint('Microphone permission granted');
//     } else {
//       debugPrint('Microphone permission denied');
//     }

//     // Request phone permission
//     var phonePermission = await Permission.phone.request();
//     if (phonePermission.isGranted) {
//       debugPrint('Phone permission granted');
//     } else {
//       debugPrint('Phone permission denied');
//     }
//   }
// }
