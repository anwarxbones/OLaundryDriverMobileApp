import 'dart:convert';

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? businessName;
  String? name;
  dynamic email;
  String? mobile;
  dynamic gender;
  String? addressName;
  String? dateOfBirth;
  String? city;
  String? state;
  String? zipCode;
  String? addressLine1;
  String? addressLine2;
  DateTime? mobileVerifiedAt;
  bool? isActive;
  dynamic alternativePhone;
  String? profilePhotoPath;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.businessName,
    this.name,
    this.email,
    this.mobile,
    this.gender,
    this.addressName,
    this.dateOfBirth,
    this.city,
    this.state,
    this.zipCode,
    this.addressLine1,
    this.addressLine2,
    this.mobileVerifiedAt,
    this.isActive,
    this.alternativePhone,
    this.profilePhotoPath,
  });

  @override
  String toString() {
    return 'User(id: $id, firstName: $firstName, lastName: $lastName, name: $name, email: $email, mobile: $mobile, gender: $gender, mobileVerifiedAt: $mobileVerifiedAt, isActive: $isActive, alternativePhone: $alternativePhone, profilePhotoPath: $profilePhotoPath)';
  }

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as int?,
        firstName: data['first_name'] as String?,
        lastName: data['last_name'] as String?,
        businessName: data['business_name'] as String?,
        name: data['name'] as String?,
        email: data['email'] as dynamic,
        mobile: data['mobile'] as String?,
        gender: data['gender'] as dynamic,
        addressName: data['address_name'] as String?,
        dateOfBirth: data['date_of_birth'] as String?,
        city: data['city'] as String?,
        state: data['state'] as String?,
        zipCode: data['zip_code'] as String?,
        addressLine1: data['address_line'] as String?,
        addressLine2: data['address_line_2'] as String?,
        mobileVerifiedAt: data['mobile_verified_at'] == null
            ? null
            : DateTime.parse(data['mobile_verified_at'] as String),
        isActive: data['is_active'] == 1 || data['is_active'] == true
            ? true
            : false as bool?,
        alternativePhone: data['alternative_phone'] as dynamic,
        profilePhotoPath: data['profile_photo_path'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'business_name': businessName,
        'name': name,
        'email': email,
        'mobile': mobile,
        'gender': gender,
        'address_name': addressName,
        'date_of_birth': dateOfBirth,
        'city': city,
        'state': state,
        'zip_code': zipCode,
        'address_line': addressLine1,
        'address_line_2': addressLine2,
        'mobile_verified_at': mobileVerifiedAt?.toIso8601String(),
        'is_active': isActive,
        'alternative_phone': alternativePhone,
        'profile_photo_path': profilePhotoPath,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
