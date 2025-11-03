
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:huntrradminweb/model/agent_model.dart';
import '../../../core/constants/failure.dart';
import '../../../core/constants/firebaseConstants.dart';
import '../../../core/constants/typedef.dart';

final agentRepositoryProvider = Provider<AgentRepository>((ref) {return AgentRepository();});

class AgentRepository {

  ///add agent

  FutureEither<AgentModel> addAgents(AgentModel agent) async {
    try {
      DocumentReference ref = FirebaseFirestore.instance
          .collection(FirebaseCollections.agentsCollection).doc();
      print('11111111111111111111111111111111111111111111111111');
      print(ref);
      print('1111111111111111111111111111111111111111111111111');

      AgentModel agentModel = agent.copyWith(reference: ref,id: ref.id);
      await ref.set(agentModel.toMap());
      return right(agentModel);
    }
    on FirebaseException catch(e){
      throw e.message!;
    }
    catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }

  ///update agent
  FutureVoid updateAgents(AgentModel agent) async {
    try {
      return right(await agent.reference!.update(agent.toMap()));
    }
    on FirebaseException catch(e){
      throw e.message!;
    }
    catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }


  /// agent stream with search
  Stream<List<AgentModel>> getAgents(String searchQuery) {
    final collection = FirebaseFirestore.instance.collection(FirebaseCollections.agentsCollection);

    if (searchQuery.isEmpty) {
      return collection
          .orderBy('createTime', descending: true)
          .where('delete', isEqualTo: false)
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => AgentModel.fromMap(doc.data())).toList());
    } else {
      return collection
          .where('delete', isEqualTo: false)
          .where('search', arrayContains: searchQuery.toUpperCase())
          .snapshots()
          .map((snapshot) =>
          snapshot.docs.map((doc) => AgentModel.fromMap(doc.data())).toList());
    }
  }

}