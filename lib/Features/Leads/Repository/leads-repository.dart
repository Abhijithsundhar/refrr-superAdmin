
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:huntrradminweb/model/admin-model.dart';
import 'package:huntrradminweb/model/leads-model.dart';
import '../../../core/constants/failure.dart';
import '../../../core/constants/firebaseConstants.dart';
import '../../../core/constants/typedef.dart';

final leadsRepositoryProvider = Provider<LeadsRepository>((ref) {return LeadsRepository();});

class LeadsRepository {

  ///add leads

  FutureEither<LeadsModel> addLeads(LeadsModel leads) async {
    try {
      DocumentReference ref = FirebaseFirestore.instance
          .collection(FirebaseCollections.leadsCollection).doc();
      print('11111111111111111111111111111111111111111111111111');
      print(ref);
      print('1111111111111111111111111111111111111111111111111');

      LeadsModel leadsModel=leads.copyWith(reference: ref,);
      await ref.set(leadsModel.toMap());
      return right(leadsModel);
    }
    on FirebaseException catch(e){
      throw e.message!;
    }
    catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }

  ///update leads
  FutureVoid updateLeads(LeadsModel leads) async {
    try {
      return right(await leads.reference!.update(leads.toMap()));
    }
    on FirebaseException catch(e){
      throw e.message!;
    }
    catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }


  /// leads stream with search
  Stream<List<LeadsModel>> getLeads(String searchQuery) {
    final collection = FirebaseFirestore.instance.collection(FirebaseCollections.leadsCollection);

    if (searchQuery.isEmpty) {
      return collection
          .orderBy('createTime', descending: true)
          .where('delete', isEqualTo: false)
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => LeadsModel.fromMap(doc.data())).toList());
    } else {
      return collection
          .where('delete', isEqualTo: false)
          .where('search', arrayContains: searchQuery.toUpperCase())
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => LeadsModel.fromMap(doc.data())).toList());
    }
  }

}