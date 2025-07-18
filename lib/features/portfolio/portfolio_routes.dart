import 'package:go_router/go_router.dart';
import 'portfolio_page.dart';

final List<GoRoute> portfolioRoutes = [
  GoRoute(
    path: '/portfolio',
    name: 'portfolio',
    builder: (context, state) => const PortfolioPage(),
    routes: [
      GoRoute(
        path: 'details',
        name: 'portfolioDetails',
        builder: (context, state) => const PortfolioDetailsPage(),
        routes: [
          GoRoute(
            path: 'asset',
            name: 'assetDetails',
            builder: (context, state) => const AssetDetailsPage(),
          ),
        ],
      ),
    ],
  ),
];
