
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:huntrradminweb/model/offer-model.dart';
import '../../../core/constants/failure.dart';
import '../../../core/constants/firebaseConstants.dart';
import '../../../core/constants/typedef.dart';

final offerRepositoryProvider = Provider<OfferRepository>((ref) {return OfferRepository();});

class OfferRepository {

  ///add offer

  FutureEither<OfferModel> addOffer(OfferModel offer) async {
    try {
      DocumentReference ref = FirebaseFirestore.instance
          .collection(FirebaseCollections.offersCollection).doc();
      print('11111111111111111111111111111111111111111111111111');
      print(ref);
      print('1111111111111111111111111111111111111111111111111');

      OfferModel offerModel = offer.copyWith(reference: ref,id: ref.id);
      await ref.set(offerModel.toMap());
      return right(offerModel);
    }
    on FirebaseException catch(e){
      throw e.message!;
    }
    catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }

  ///update offer
  FutureVoid updateOffer(OfferModel offer) async {
    try {
      return right(await offer.reference!.update(offer.toMap()));
    }
    on FirebaseException catch(e){
      throw e.message!;
    }
    catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }


  /// offer stream with search
  Stream<List<OfferModel>> getOffer(String searchQuery) {
    final collection = FirebaseFirestore.instance.collection(FirebaseCollections.offersCollection);

    if (searchQuery.isEmpty) {
      return collection
          .orderBy('createTime', descending: true)
          .where('delete', isEqualTo: false)
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => OfferModel.fromMap(doc.data())).toList());
    } else {
      return collection
          .where('delete', isEqualTo: false)
          .where('search', arrayContains: searchQuery.toUpperCase())
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => OfferModel.fromMap(doc.data())).toList());
    }
  }

}