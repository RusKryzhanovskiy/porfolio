import 'package:go_router/go_router.dart';
import 'package:portfolio/modules/profile/presentation/pages/profile_page.dart';

final List<GoRoute> profileRoutes = [
  GoRoute(path: '/profile', name: 'profile', builder: (context, state) => const ProfilePage()),
];
