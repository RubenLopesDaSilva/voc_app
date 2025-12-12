import 'package:go_router/go_router.dart';
import 'package:voc_app/src/features/repetition/presentation/repetitions_screen.dart';
import 'package:voc_app/src/features/repetition/presentation/repetition_screen.dart';

enum AppRoutes {
  home('/'),
  repetitions('/repetitions'),
  repetition('/repetitions/repetition/:groupId');

  final String path;

  const AppRoutes(this.path);
}

final goRouter = GoRouter(
  initialLocation: AppRoutes.home.path,
  routes: [
    GoRoute(
      path: AppRoutes.home.path,
      name: AppRoutes.home.name,
      redirect: (context, state) {
        return AppRoutes.repetitions.path;
      },
    ),
    GoRoute(
      path: AppRoutes.repetitions.path,
      name: AppRoutes.repetitions.name,
      builder: (context, state) {
        return const RepetitionsScreen();
      },
      routes: [
        GoRoute(
          path: AppRoutes.repetition.path,
          name: AppRoutes.repetition.name,
          builder: (context, state) {
            final String groupId = state.pathParameters['groupId'].toString();
            return RepetitionScreen(groupId: groupId);
          },
          redirect: (context, state) {
            final String? groupId = state.pathParameters['groupId'];
            if (groupId == null || groupId.isEmpty) {
              return AppRoutes.repetitions.path;
            }
            return null;
          },
        ),
      ],
    ),
  ],
);
