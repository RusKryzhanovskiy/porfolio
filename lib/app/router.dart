import 'package:go_router/go_router.dart';
import 'app_shell.dart';
import '../modules/portfolio/portfolio_routes.dart';
import '../modules/markets/presentation/markets_routes.dart';
import '../modules/analytics/analytics_routes.dart';
import '../modules/profile/profile_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/portfolio',
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [...portfolioRoutes, ...marketsRoutes, ...analyticsRoutes, ...profileRoutes],
    ),
  ],
);
