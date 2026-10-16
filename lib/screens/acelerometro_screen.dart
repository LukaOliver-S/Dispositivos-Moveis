import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AcelerometroScreen extends StatefulWidget {
  const AcelerometroScreen({super.key});

  @override
  State<AcelerometroScreen> createState() => _AcelerometroScreenState();
}

class _AcelerometroScreenState extends State<AcelerometroScreen> {
  AccelerometerEvent? _ultimo;
  StreamSubscription<AccelerometerEvent>? _sub;

  @override
  void initState() {
    super.initState();
    // normalInterval: taxa moderada, suficiente para a tela
    _sub = accelerometerEventStream(
      samplingPeriod: SensorInterval.normalInterval,
    )
        .listen(
          (e) => setState(() => _ultimo = e),
          onError: (_) {}, // alguns aparelhos não têm o sensor
        );
  }

  @override
  void dispose() {
    _sub?.cancel(); // evita gastar bateria ao sair da tela
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final e = _ultimo;
    return Scaffold(
      appBar: AppBar(title: const Text('Acelerômetro')),
      body: Center(
        child: Text(
          e == null
              ? 'Aguardando leitura...'
              : 'x: ${e.x.toStringAsFixed(2)} m/s²\n'
                'y: ${e.y.toStringAsFixed(2)} m/s²\n'
                'z: ${e.z.toStringAsFixed(2)} m/s²\n\n'
                'Parado na mesa, z fica perto de 9.8 (gravidade).',
          style: const TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}