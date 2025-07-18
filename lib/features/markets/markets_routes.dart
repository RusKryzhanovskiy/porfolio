import 'package:go_router/go_router.dart';
import 'package:portfolio/features/markets/presentation/pages/markets_page.dart';

final List<GoRoute> marketsRoutes = [
  GoRoute(path: '/markets', name: 'markets', builder: (context, state) => const MarketsPage()),
];
