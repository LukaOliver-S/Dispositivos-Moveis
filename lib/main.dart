import 'package:flutter/material.dart';
import 'screens/acelerometro_screen.dart';
import 'screens/giroscopio_screen.dart';
import 'screens/magnetometro_screen.dart';
import 'screens/gravidade_screen.dart';
import 'screens/rotacao_screen.dart';
import 'screens/gps_screen.dart';

void main() => runApp(const SensoresApp());

class SensoresApp extends StatelessWidget {
  const SensoresApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const Menu(),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    // Cada item leva a uma tela de um sensor
    final itens = <(String, Widget)>[
      ('Acelerômetro', const AcelerometroScreen()),
      ('Giroscópio', const GiroscopioScreen()),
      ('Magnetômetro', const MagnetometroScreen()),
      ('Gravidade', const GravidadeScreen()),
      ('Rotação (inclinação)', const RotacaoScreen()),
      ('GPS', const GpsScreen()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Sensores em Flutter')),
      body: ListView(
        children: [
          for (final (titulo, tela) in itens)
            ListTile(
              title: Text(titulo),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => tela),
              ),
            ),
        ],
      ),
    );
  }
}