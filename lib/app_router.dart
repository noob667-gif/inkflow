import 'package:go_router/go_router.dart';
import 'screens/home_screen.dart';
import 'screens/pages_grid_screen.dart';
import 'screens/canvas_screen.dart';

class InkFlowRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/notebook/:notebookId/section/:sectionId',
        builder: (context, state) => PagesGridScreen(
          notebookId: state.pathParameters['notebookId']!,
          sectionId: state.pathParameters['sectionId']!,
        ),
      ),
      GoRoute(
        path: '/notebook/:notebookId/section/:sectionId/page/:pageId',
        builder: (context, state) {
          final notebookId = state.pathParameters['notebookId']!;
          final sectionId = state.pathParameters['sectionId']!;
          final pageId = state.pathParameters['pageId']!; // pass this required param
          return const CanvasScreen( );
        },
      ),
    ],
  );
}
