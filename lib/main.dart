import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

// modelos
import 'models/finance_data.dart';

// páginas
import 'pages/investimentos_page.dart';
import 'pages/relatorios_page.dart';
import 'pages/home_page.dart' as home;
import 'pages/homepage_inicial.dart' as inicio;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  runApp(
    ChangeNotifierProvider(
      create: (_) => FinanceData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App Financeiro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      // Rota inicial
      initialRoute: '/inicio',
      routes: {
        '/inicio': (context) => const inicio.HomePageInicial(),
        '/': (context) => const home.HomePage(),
        '/investimentos': (context) => const InvestimentosPage(),
        '/relatorios': (context) => const RelatoriosPage(),
      },
    );
  }
}
