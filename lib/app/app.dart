import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portfolio/core/cache/cache_service.dart';
import 'package:portfolio/core/network/network_service.dart';
import 'package:portfolio/core/repository/base_repository.dart';
import 'package:portfolio/modules/markets/data/crypto_markets_repository.dart';
import 'package:portfolio/modules/markets/presentation/cubit/markets_cubit.dart';
import 'package:portfolio/l10n/app_localizations.dart';
import 'package:portfolio/app/router.dart';
import 'package:portfolio/services/currency_manager.dart';
import 'package:portfolio/services/locale_manager.dart';
import 'package:provider/provider.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Provider.of<LocaleManager>(context).locale;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            final currencyManager = CurrencyManager();
            currencyManager.loadCurrency();
            return currencyManager;
          },
        ),
        RepositoryProvider(create: (context) => NetworkService()),
        RepositoryProvider(create: (context) => CacheService()),
        RepositoryProvider<IBaseRepository>(
          create: (context) {
            return BaseRepositoryImpl(
              networkService: context.read<NetworkService>(),
              cacheService: context.read<CacheService>(),
            );
          },
        ),
        RepositoryProvider<ICryptoMarketsRepository>(
          create: (context) {
            return CryptoMarketsRepositoryImpl(baseRepository: context.read<IBaseRepository>());
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MarketsCubit(
              cryptoMarketsRepository: context.read<ICryptoMarketsRepository>(),
              currencyManager: context.read<CurrencyManager>(),
            )..loadCryptoMarkets(),
          ),
        ],
        child: MaterialApp.router(
          title: 'Portfolio Tracker',
          theme: ThemeData.dark(useMaterial3: true),
          routerConfig: appRouter,
          locale: locale,
          supportedLocales: LocaleManager.supportedLocales,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
