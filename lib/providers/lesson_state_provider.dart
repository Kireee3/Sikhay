import 'package:flutter_riverpod/flutter_riverpod.dart';

// The four possible states of our AI Tutor
enum LessonState { initial, loading, success, error }

class LessonStateNotifier extends Notifier<LessonState> {
  @override
  LessonState build() {
    return LessonState.initial;
  }

  void startLoading() => state = LessonState.loading;
  void setSuccess() => state = LessonState.success;
  void setError() => state = LessonState.error;
  void reset() => state = LessonState.initial;
}

final lessonStateProvider = NotifierProvider<LessonStateNotifier, LessonState>(() {
  return LessonStateNotifier();
});