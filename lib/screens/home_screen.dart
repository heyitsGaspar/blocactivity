import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/activity_bloc.dart';
import '../events/ativity_event.dart';
import '../models/activity_model.dart';
import '../states/activity_state.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ActivityBloc _activityBloc = ActivityBloc();

  // @override
  // void initState() {
  //   super.initState();
  //   _activityBloc.add(LoadAllActivities());
  // }



  

  void _addActivity(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String name = '';
        String description = '';

        return AlertDialog(
          title: Text('Agregar Actividad'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Descripción',
                ),
                onChanged: (value) {
                  description = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () {
                if (name.isNotEmpty && description.isNotEmpty) {
                  final activity = Activity(name: name, description: description);
                  _activityBloc.add(AddActivity(activity));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  
 


  void _deleteActivity(Activity activity) {
    _activityBloc.add(DeleteActivity(activity));
  }

  void _activateActivity(Activity activity) {
    _activityBloc.add(ActivateActivity(activity));
    TabController? tabController = DefaultTabController.of(context);
    if (tabController != null) {
      tabController.index = 1; // Índice 1 corresponde a la pestaña de "Activas"
    }

  }

  void _finishActivity(Activity activity) {
    _activityBloc.add(FinishActivity(activity));
  }
  

  Widget _buildActivityList(List<Activity> activities) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];

        return ListTile(
          title: Text(activity.name),
          subtitle: Text(activity.description),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!activity.isFinished)
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteActivity(activity),
                ),
              if (!activity.isActive)
                IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () => _activateActivity(activity),
                ),
              if (activity.isActive)
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () => _finishActivity(activity),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTabContent(ActivityState state) {
    if (state is AllActivitiesLoaded) {
      return _buildActivityList(state.activities);
    } else if (state is ActiveActivitiesLoaded) {
      final activeActivities =
          state.activities.where((activity) => activity.isActive).toList();
      return _buildActivityList(activeActivities);
    } else if (state is FinishedActivitiesLoaded) {
      final finishedActivities =
          state.activities.where((activity) => activity.isFinished).toList();
      return _buildActivityList(finishedActivities);
    }

    return Container();
  }


  Widget _buildAllActivitiesTab(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(
      bloc: _activityBloc,
      builder: (context, state) {
        return _buildTabContent(state);
      },
    );
  }

  Widget _buildActiveActivitiesTab(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(
      bloc: _activityBloc,
      builder: (context, state) {
        if (state is ActiveActivitiesLoaded) {
          final activeActivities =
              state.activities.where((activity) => activity.isActive).toList();
          return _buildActivityList(activeActivities);
        }

        return Container();
      },
    );
  }

  Widget _buildFinishedActivitiesTab(BuildContext context) {
    return BlocBuilder<ActivityBloc, ActivityState>(
      bloc: _activityBloc,
      builder: (context, state) {
        if (state is FinishedActivitiesLoaded) {
          final finishedActivities = state.activities
              .where((activity) => activity.isFinished)
              .toList();
          return _buildActivityList(finishedActivities);
        }

        return Container();
      },
    );
  }
 @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Actividades'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Todas'),
              Tab(text: 'Activas'),
              Tab(text: 'Finalizadas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAllActivitiesTab(context),
            _buildActiveActivitiesTab(context),
            _buildFinishedActivitiesTab(context)
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _addActivity(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  
}
