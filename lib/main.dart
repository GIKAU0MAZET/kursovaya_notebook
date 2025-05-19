import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/core/router/app_router.dart';
import 'package:kursovaya_notebook/feature/dashboard/bloc/dashboard_cubit.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_cubit.dart';

void main() {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [DashboardCubit.provider(), SubjectCubit.provider()],
      child: MaterialApp.router(
        routerConfig: AppRouter.config,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
