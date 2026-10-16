import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../services/sensor_math.dart';

class RotacaoScreen extends StatefulWidget {
  const RotacaoScreen({super.key});

  @override
  State<RotacaoScreen> createState() => _RotacaoScreenState();
}

class _RotacaoScreenState extends State<RotacaoScreen> {
  AccelerometerEvent? _ultimo;
  StreamSubscription<AccelerometerEvent>? _sub;

  @override
  void initState() {
    super.initState();
    _sub = accelerometerEventStream(
      samplingPeriod: SensorInterval.normalInterval,
    )
        .listen((e) => setState(() => _ultimo = e), onError: (_) {});
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final e = _ultimo;
    final texto = e == null
        ? 'Aguardando leitura...'
        : 'Lateral (rolagem): '
          '${rolagemGraus(e.x, e.y, e.z).toStringAsFixed(0)}°\n'
          'Frente/trás (arfagem): '
          '${arfagemGraus(e.x, e.y, e.z).toStringAsFixed(0)}°\n\n'
          'Inclinação estimada pela gravidade.\n'
          'Não é a orientação completa do sensor de rotação.';

    return Scaffold(
      appBar: AppBar(title: const Text('Rotação (inclinação)')),
      body: Center(
        child: Text(texto,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center),
      ),
    );
  }
}