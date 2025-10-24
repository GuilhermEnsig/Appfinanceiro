import 'package:flutter/material.dart';

class HomePageInicial extends StatelessWidget {
  const HomePageInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Financeiro'),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.tealAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Bem-vindo ao App Financeiro 💰',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // 🔹 Botão "Minhas Finanças"
            ElevatedButton.icon(
              onPressed: () => Navigator.pushReplacementNamed(context, '/'),
              icon: const Icon(Icons.account_balance_wallet),
              label: const Text('Minhas Finanças'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Botão "Investimentos"
            ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/investimentos'),
              icon: const Icon(Icons.trending_up),
              label: const Text('Investimentos'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Botão "Relatórios"
            ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/relatorios'),
              icon: const Icon(Icons.bar_chart),
              label: const Text('Relatórios'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.teal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                textStyle: const TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
