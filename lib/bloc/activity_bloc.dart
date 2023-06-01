
import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/ativity_event.dart';
import '../states/activity_state.dart';
import 'dart:async';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  ActivityBloc() : super(AllActivitiesLoaded([])) {
    on<AddActivity>(_onAddActivity);
    on<DeleteActivity>(_onDeleteActivity);
    on<ActivateActivity>(_onActivateActivity);
  }

  void _onAddActivity(AddActivity event, Emitter<ActivityState> emit) {
    final currentState = state;

    if (currentState is AllActivitiesLoaded) {
      final updatedActivities = [...currentState.activities, event.activity];
      emit(AllActivitiesLoaded(updatedActivities));
    }
  }

  void _onDeleteActivity(DeleteActivity event, Emitter<ActivityState> emit) {
    final currentState = state;

    if (currentState is AllActivitiesLoaded) {
      final updatedActivities =
          currentState.activities.where((a) => a != event.activity).toList();
      emit(AllActivitiesLoaded(updatedActivities));
    }
  }

  void _onActivateActivity(
    ActivateActivity event,
    Emitter<ActivityState> emit,
  ) {
    final currentState = state;

    if (currentState is AllActivitiesLoaded) {
      final updatedActivities = currentState.activities
          .map((a) => a == event.activity ? a.copyWith(isActive: true) : a)
          .toList();
      emit(AllActivitiesLoaded(updatedActivities));
    }
  }
}







// class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
//   ActivityBloc() : super(AllActivitiesLoaded([])) {
//     on<AddActivity>(_onAddActivity);
//   }

//   void _onAddActivity(AddActivity event, Emitter<ActivityState> emit) {
//     final currentState = state as AllActivitiesLoaded;
//     final updatedActivities = [...currentState.activities, event.activity];
//     emit(AllActivitiesLoaded(updatedActivities));
//   }
   
  
// }





