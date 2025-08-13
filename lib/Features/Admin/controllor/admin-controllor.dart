
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:huntrradminweb/model/admin-model.dart';

import '../../../core/common/snackbar.dart';
import '../Repository/admin-repository.dart';




final adminRepositoryProvider = Provider((ref) => AdminRepository());

/// Admin Stream Provider with search support
final adminStreamProvider = StreamProvider.family<List<AdminModel>, String>((ref, searchQuery) {
  final repository = ref.watch(adminRepositoryProvider);

  return repository.getAdmin(searchQuery);
});


/// AdminController Provider
final adminControllerProvider = StateNotifierProvider<AdminController, bool>((ref) {
  return AdminController(repository: ref.read(adminRepositoryProvider));

});

// ///firm stream provider
// final firmStreamProvider = StreamProvider.family<List<AddFirmModel>, String>((ref, searchQuery) {
//   final firestore = FirebaseFirestore.instance.collection(FirebaseCollections.addFirmCollection);
//
//   if (searchQuery.isEmpty) {
//     // If the search query is empty, fetch all customers ordered by created time
//     return firestore
//         .orderBy('createTime', descending: true)
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return AddFirmModel.fromMap(doc.data() as Map<String, dynamic>,);
//       }).toList();
//     });
//
//   } else {
//     // If search query is not empty, filter based on search field
//     return firestore
//         .where('search', arrayContains: searchQuery.toUpperCase())
//
//     // .where('search', arrayContains: searchQuery + '\uf8ff')
//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return AddFirmModel.fromMap(doc.data() as Map<String, dynamic>,);
//       }).toList();
//     });
//   }
// });



//----------------------------------------------------------------------------

class AdminController extends StateNotifier<bool> {final AdminRepository _repository;

AdminController({required AdminRepository repository}): _repository = repository, super(false);

/// Add admin
Future<void> addAdmin({
  required AdminModel adminModel,
  required BuildContext context,
}) async {
  state = true;
  var snap=await _repository.addAdmins(adminModel);
  state = false;
  snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
    showCommonSnackbar(context,"Admin added successfully");
    Navigator.pop(context);
  });
}

///update admin
Future<void> updateAdmin({
  required AdminModel adminModel,
  required BuildContext context,
}) async {
  state = true;
  var snap=await _repository.updateAdmin(adminModel);
  state = false;
  snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
    showCommonSnackbar(context,"Admin updated successfully");
    Navigator.pop(context);
  });
}

/// Admin stream
Stream <List<AdminModel>>getAdmin(String searchQuery ){
  return _repository.getAdmin(searchQuery);
}

}
