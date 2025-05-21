import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kursovaya_notebook/feature/dashboard/ui/page/dashboard_page.dart';
import 'package:kursovaya_notebook/feature/folders/ui/page/folder_list_page.dart';
import 'package:kursovaya_notebook/feature/folders/ui/page/folder_page.dart';
import 'package:kursovaya_notebook/feature/schedule/ui/page/schedule_page.dart';
import 'package:kursovaya_notebook/feature/subjects/ui/page/subject_page.dart';

abstract final class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final config = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: FoldersListScreen.path,
    debugLogDiagnostics: true,
    routes: [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: _rootNavigatorKey,
        builder:
            (context, state, navigationShell) => DashboardPage(
              navigationShell: navigationShell,
              folders: ['1 Курс'],
            ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: FoldersListScreen.path,
                pageBuilder:
                    (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const FoldersListScreen(),
                    ),
                routes: [
                  GoRoute(
                    path: ':folderId',
                    pageBuilder:
                        (context, state) => NoTransitionPage(
                          key: state.pageKey,
                          child: FolderPage(
                            folderId: state.pathParameters['folderId']!,
                          ),
                        ),
                    routes: [
                      GoRoute(
                        path: 'subjects/:subjectId',
                        pageBuilder:
                            (context, state) => NoTransitionPage(
                              key: state.pageKey,
                              child: SubjectPage(
                                folderId: state.pathParameters['folderId']!,
                                subjectId: state.pathParameters['subjectId']!,
                              ),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: SchedulePage.path,
                pageBuilder:
                    (context, state) => NoTransitionPage(
                      key: state.pageKey,
                      child: const SchedulePage(),
                    ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
