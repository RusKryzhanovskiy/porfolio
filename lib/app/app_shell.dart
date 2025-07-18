import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/l10n/app_localizations.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  static const _tabs = ['/markets', '/portfolio', '/analytics', '/profile'];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final loc = AppLocalizations.of(context)!;
    int currentIndex = _tabs.indexWhere((tab) => location.startsWith(tab));
    if (currentIndex == -1) currentIndex = 0;

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          context.replace(_tabs[index]);
        },
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.show_chart), label: loc.marketsTab),
          BottomNavigationBarItem(icon: const Icon(Icons.pie_chart), label: loc.portfolioTab),
          BottomNavigationBarItem(icon: const Icon(Icons.analytics), label: loc.analyticsTab),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: loc.profileTab),
        ],
      ),
    );
  }
}
