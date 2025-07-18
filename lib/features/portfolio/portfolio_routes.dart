import 'package:go_router/go_router.dart';
import 'portfolio_page.dart';

final List<GoRoute> porfolioRoutes = [
  GoRoute(
    path: '/porfolio',
    name: 'porfolio',
    builder: (context, state) => const PortfolioPage(),
    routes: [
      GoRoute(
        path: 'details',
        name: 'porfolioDetails',
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
