import 'package:kauto/data/address/datasource/dataSources.dart';
import 'package:kauto/data/address/model/add_model.dart';
import 'package:kauto/domain/address/address.dart';
import 'package:kauto/domain/address/repository/addrepository.dart';

class AddRepositoryImp implements Addrepository {
  final Datasources addDataSource;

  AddRepositoryImp({required this.addDataSource});

  @override
  Stream<List<Address>> getAdd({required String userId}) {
    return addDataSource.getAdd(userId: userId).map((snapshot) {
      return snapshot.docs
          .map((doc) => AddModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Future<void> saveAdd({
    required String userId,
    required String name,
    required String phone,
    required String address1,
    required String address2,
    required String city,
    required String pincode,
    required String state,
  }) async {
    return await addDataSource.saveAdd(
      userId: userId,
      name: name,
      phone: phone,
      address1: address1,
      address2: address2,
      city: city,
      pincode: pincode,
      state: state,
    );
  }
}
