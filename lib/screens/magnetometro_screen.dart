import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../services/sensor_math.dart';

class MagnetometroScreen extends StatefulWidget {
  const MagnetometroScreen({super.key});

  @override
  State<MagnetometroScreen> createState() => _MagnetometroScreenState();
}

class _MagnetometroScreenState extends State<MagnetometroScreen> {
  MagnetometerEvent? _ultimo;
  StreamSubscription<MagnetometerEvent>? _sub;

  @override
  void initState() {
    super.initState();
    _sub = magnetometerEventStream(
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
    return Scaffold(
      appBar: AppBar(title: const Text('Magnetômetro')),
      body: Center(
        child: Text(
          e == null
              ? 'Aguardando leitura...'
              : 'Campo (µT):\n'
                'x: ${e.x.toStringAsFixed(1)}\n'
                'y: ${e.y.toStringAsFixed(1)}\n'
                'z: ${e.z.toStringAsFixed(1)}\n\n'
                'Rumo aproximado: '
                '${rumoGraus(e.x, e.y).toStringAsFixed(0)}°\n\n'
                'Ímãs e capas magnéticas alteram a leitura.',
          style: const TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}