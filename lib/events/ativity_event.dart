import '../models/activity_model.dart';

abstract class ActivityEvent {}

class AddActivity extends ActivityEvent {
  final Activity activity;

  AddActivity(this.activity);
}

class DeleteActivity extends ActivityEvent {
  final Activity activity;

  DeleteActivity(this.activity);
}

class ActivateActivity extends ActivityEvent {
  final Activity activity;

  ActivateActivity(this.activity);
}

class FinishActivity extends ActivityEvent{
  final Activity activity;

  FinishActivity(this.activity);
}

