import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart'; // Bringing in your new data model!

// 1. The core Firebase Auth instance
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

// 2. The Auth State Stream (This magically watches if the user is logged in or out)
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

// 3. Fetching the Custom User Profile from Firestore
final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  // Watch the auth state
  final user = ref.watch(authStateProvider).value;
  
  if (user == null) return null; // Not logged in

  // If logged in, fetch their custom data (XP, Level, Language) from Firestore
  final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
  
  if (doc.exists && doc.data() != null) {
    // Unpack the database document directly into your strongly-typed Dart object
    return UserProfile.fromMap(doc.id, doc.data()!);
  }
  return null; 
});