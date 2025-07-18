import 'package:go_router/go_router.dart';
import 'analytics_page.dart';

final List<GoRoute> analyticsRoutes = [
  GoRoute(
    path: '/analytics',
    name: 'analytics',
    builder: (context, state) => const AnalyticsPage(),
  ),
];
