import '../models/activity_model.dart';

abstract class ActivityState {}

class AllActivitiesLoaded extends ActivityState {
  final List<Activity> activities;

  AllActivitiesLoaded(this.activities);
}

class ActiveActivitiesLoaded extends ActivityState {
  final List<Activity> activities;

  ActiveActivitiesLoaded(this.activities);
}

class FinishedActivitiesLoaded extends ActivityState{
  final List<Activity> activities;


  FinishedActivitiesLoaded(this.activities);
}
