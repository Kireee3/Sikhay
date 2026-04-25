import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';
import 'auth_provider.dart';

// 1. Fetch the progress for a SPECIFIC topic
final topicProgressProvider = FutureProvider.family<ProgressModel?, String>((ref, topicId) async {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;

  final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .collection('progress')
      .doc(topicId)
      .get();

  if (doc.exists && doc.data() != null) {
    return ProgressModel.fromMap(doc.id, doc.data()!);
  }

  // If they haven't started the topic yet, return a blank slate
  return ProgressModel(
    topicId: topicId,
    conceptsLearned: [],
    struggledConcepts: [],
    percentComplete: 0.0,
    lastVisited: DateTime.now(),
  );
});

// 2. The Controller to handle XP and Logging
class ProgressController {
  final String userId;
  ProgressController(this.userId);

  // Call this when they understand a concept
  Future<void> markConceptLearned(String topicId, String conceptId) async {
    final ref = FirebaseFirestore.instance.collection('users').doc(userId).collection('progress').doc(topicId);
    
    // Add concept to list and update last visited
    await ref.set({
      'conceptsLearned': FieldValue.arrayUnion([conceptId]),
      'lastVisited': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // Award 10 XP to the main user profile
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'xp': FieldValue.increment(10),
    });
  }

  // Call this when they click the 🤔 or 😕 emoji
  Future<void> logStruggle(String topicId, String conceptId) async {
    final ref = FirebaseFirestore.instance.collection('users').doc(userId).collection('progress').doc(topicId);
    await ref.set({
      'struggledConcepts': FieldValue.arrayUnion([conceptId]),
    }, SetOptions(merge: true));
  }
}

// 3. Expose the controller to the UI
final progressControllerProvider = Provider<ProgressController?>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return null;
  return ProgressController(user.uid);
});