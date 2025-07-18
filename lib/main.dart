import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/app.dart';
import 'services/locale_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and locale
  await Hive.initFlutter();
  final localeManager = LocaleManager();
  await localeManager.loadLocale();

  // Load environment variables
  await dotenv.load(fileName: '.env');
  // Create the app with providers
  runApp(ChangeNotifierProvider(create: (_) => localeManager, child: const PortfolioApp()));
}
