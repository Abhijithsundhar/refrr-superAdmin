
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:huntrradminweb/Features/Leads/Repository/leads-repository.dart';
import 'package:huntrradminweb/model/admin-model.dart';
import 'package:huntrradminweb/model/leads-model.dart';
import '../../../core/common/snackbar.dart';




final leadsRepositoryProvider = Provider((ref) => LeadsRepository());

/// Admin Stream Provider with search support
final leadsStreamProvider = StreamProvider.family<List<LeadsModel>, String>((ref, searchQuery) {
  final repository = ref.watch(leadsRepositoryProvider);

  return repository.getLeads(searchQuery);
});


/// AdminController Provider
final leadsControllerProvider = StateNotifierProvider<LeadsController, bool>((ref) {
  return LeadsController(repository: ref.read(leadsRepositoryProvider));

});


class LeadsController extends StateNotifier<bool> {final LeadsRepository _repository;

LeadsController({required LeadsRepository repository}): _repository = repository, super(false);

/// Add leads
Future<void> addLeads({
  required LeadsModel leadsModel,
  required BuildContext context,
}) async {
  state = true;
  var snap=await _repository.addLeads(leadsModel);
  state = false;
  snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
    showCommonSnackbar(context,"Lead added successfully");
    Navigator.pop(context);
  });
}

///update lead
Future<void> updateLeads({
  required LeadsModel leadsModel,
  required BuildContext context,
}) async {
  state = true;
  var snap=await _repository.updateLeads(leadsModel);
  state = false;
  snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
    showCommonSnackbar(context,"Lead updated successfully");
    Navigator.pop(context);
  });
}

/// lead stream
Stream <List<LeadsModel>>getLeads(String searchQuery ){
  return _repository.getLeads(searchQuery);
}

}
