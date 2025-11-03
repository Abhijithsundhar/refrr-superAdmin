
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:huntrradminweb/model/agent_model.dart';
import '../../../core/common/snackbar.dart';
import '../Repository/agent-repository.dart';


final agentRepositoryProvider = Provider((ref) => AgentRepository());

/// agent Stream Provider with search support
final agentStreamProvider = StreamProvider.family<List<AgentModel>, String>((ref, searchQuery) {
  final repository = ref.watch(agentRepositoryProvider);

  return repository.getAgents(searchQuery);
});


/// AgentController Provider
final agentControllerProvider = StateNotifierProvider<AgentController, bool>((ref) {
  return AgentController(repository: ref.read(agentRepositoryProvider));

});


class AgentController extends StateNotifier<bool> {final AgentRepository _repository;

AgentController({required AgentRepository repository}): _repository = repository, super(false);

/// Add agent
Future<void> addAgent({
  required AgentModel agentModel,
  required BuildContext context,
}) async {
  state = true;
  var snap=await _repository.addAgents(agentModel);
  state = false;
  snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
    showCommonSnackbar(context,"Agent added successfully");
    Navigator.pop(context);
  });
}

///update Agent
Future<void> updateAgent({
  required AgentModel agentModel,
  required BuildContext context,
}) async {
  state = true;
  var snap=await _repository.updateAgents(agentModel);
  state = false;
  snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
    showCommonSnackbar(context,"Agent updated successfully");
    Navigator.pop(context);
  });
}

/// agent stream
Stream <List<AgentModel>>getAgent(String searchQuery ){
  return _repository.getAgents(searchQuery);
}

}
