
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:huntrradminweb/Features/Account/Repository/offer-repository.dart';
import 'package:huntrradminweb/Features/Leads/Repository/leads-repository.dart';
import 'package:huntrradminweb/model/affiliate-model.dart';
import 'package:huntrradminweb/model/leads-model.dart';
import 'package:huntrradminweb/model/offer-model.dart';
import '../../../core/common/snackbar.dart';




final offerRepositoryProvider = Provider((ref) => OfferRepository());

/// offer Stream Provider with search support
final offerStreamProvider = StreamProvider.family<List<OfferModel>, String>((ref, searchQuery) {
  final repository = ref.watch(offerRepositoryProvider);

  return repository.getOffer(searchQuery);
});


/// offerController Provider
final offerControllerProvider = StateNotifierProvider<OfferController, bool>((ref) {
  return OfferController(repository: ref.read(offerRepositoryProvider));

});


class OfferController extends StateNotifier<bool> {final OfferRepository _repository;

OfferController({required OfferRepository repository}): _repository = repository, super(false);

/// Add offer
Future<void> addOffer({
  required OfferModel offerModel,
  required BuildContext context,
}) async {
  state = true;
  var snap=await _repository.addOffer(offerModel);
  state = false;
  snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
    showCommonSnackbar(context,"Offer added successfully");
    Navigator.pop(context);
  });
}

///update Offer
Future<void> updateOffer({
  required OfferModel offerModel,
  required BuildContext context,
}) async {
  state = true;
  var snap=await _repository.updateOffer(offerModel);
  state = false;
  snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
    showCommonSnackbar(context,"Offer updated successfully");
    Navigator.pop(context);
  });
}

/// offer stream
Stream <List<OfferModel>>getOffer(String searchQuery ){
  return _repository.getOffer(searchQuery);
}

}
