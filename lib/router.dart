import 'package:go_router/go_router.dart';
import 'app_shell.dart';
import 'features/portfolio/portfolio_routes.dart';
import 'features/markets/presentation/markets_routes.dart';
import 'features/analytics/analytics_routes.dart';
import 'features/profile/profile_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/porfolio',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [...porfolioRoutes, ...marketsRoutes, ...analyticsRoutes, ...profileRoutes],
    ),
  ],
);
