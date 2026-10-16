import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GiroscopioScreen extends StatefulWidget {
  const GiroscopioScreen({super.key});

  @override
  State<GiroscopioScreen> createState() => _GiroscopioScreenState();
}

class _GiroscopioScreenState extends State<GiroscopioScreen> {
  GyroscopeEvent? _ultimo;
  StreamSubscription<GyroscopeEvent>? _sub;

  @override
  void initState() {
    super.initState();
    _sub = gyroscopeEventStream(
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
      appBar: AppBar(title: const Text('Giroscópio')),
      body: Center(
        child: Text(
          e == null
              ? 'Aguardando leitura...'
              : 'x: ${e.x.toStringAsFixed(2)}\n'
                'y: ${e.y.toStringAsFixed(2)}\n'
                'z: ${e.z.toStringAsFixed(2)}\n\n'
                'Gire o aparelho e observe os valores mudarem.',
          style: const TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}