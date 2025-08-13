
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:huntrradminweb/model/admin-model.dart';
import '../../../core/constants/failure.dart';
import '../../../core/constants/firebaseConstants.dart';
import '../../../core/constants/typedef.dart';

final adminRepositoryProvider = Provider<AdminRepository>((ref) {return AdminRepository();});

class AdminRepository {

  ///add admin

  FutureEither<AdminModel> addAdmins(AdminModel admins) async {
    try {
      DocumentReference ref = FirebaseFirestore.instance
          .collection(FirebaseCollections.adminsCollection).doc();
      print('11111111111111111111111111111111111111111111111111');
      print(ref);
      print('1111111111111111111111111111111111111111111111111');

      AdminModel adminModel=admins.copyWith(reference: ref,);
      await ref.set(adminModel.toMap());
      return right(adminModel);
    }
    on FirebaseException catch(e){
      throw e.message!;
    }
    catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }

  ///update admin
  FutureVoid updateAdmin(AdminModel admins) async {
    try {
      return right(await admins.reference!.update(admins.toMap()));
    }
    on FirebaseException catch(e){
      throw e.message!;
    }
    catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }

  ///admin stream
  /// Admin stream with search
  Stream<List<AdminModel>> getAdmin(String searchQuery) {
    final collection = FirebaseFirestore.instance.collection(FirebaseCollections.adminsCollection);

    if (searchQuery.isEmpty) {
      return collection
          .orderBy('createTime', descending: true)
          .where('delete', isEqualTo: false)
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => AdminModel.fromMap(doc.data())).toList());
    } else {
      return collection
          .where('delete', isEqualTo: false)
          .where('search', arrayContains: searchQuery.toUpperCase())
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => AdminModel.fromMap(doc.data())).toList());
    }
  }

}