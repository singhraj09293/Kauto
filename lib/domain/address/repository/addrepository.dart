import 'package:kauto/domain/address/address.dart';

abstract class Addrepository {
  Future<void> saveAdd({
    required String userId,
    required String name,
    required String phone,
    required String address1,
    required String address2,
    required String city,
    required String pincode,
    required String state,
  });
  Stream<List<Address>> getAdd({required String userId});
}
