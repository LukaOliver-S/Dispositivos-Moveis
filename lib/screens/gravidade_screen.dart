import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../services/sensor_math.dart';

class GravidadeScreen extends StatefulWidget {
  const GravidadeScreen({super.key});

  @override
  State<GravidadeScreen> createState() => _GravidadeScreenState();
}

class _GravidadeScreenState extends State<GravidadeScreen> {
  AccelerometerEvent? _total;
  UserAccelerometerEvent? _usuario;
  StreamSubscription<AccelerometerEvent>? _subTotal;
  StreamSubscription<UserAccelerometerEvent>? _subUsuario;

  @override
  void initState() {
    super.initState();
    // Dois streams: o total (com gravidade) e o movimento do usuário (sem gravidade)
    _subTotal = accelerometerEventStream(
      samplingPeriod: SensorInterval.normalInterval,
    )
        .listen((e) => setState(() => _total = e), onError: (_) {});
    _subUsuario =
        userAccelerometerEventStream(
          samplingPeriod: SensorInterval.normalInterval,
        )
            .listen((e) => setState(() => _usuario = e), onError: (_) {});
  }

  @override
  void dispose() {
    _subTotal?.cancel();
    _subUsuario?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = _total;
    final u = _usuario;
    final texto = (t == null || u == null)
        ? 'Aguardando leitura...'
        : 'Gravidade estimada:\n'
          'x: ${gravidadeEixo(t.x, u.x).toStringAsFixed(2)}\n'
          'y: ${gravidadeEixo(t.y, u.y).toStringAsFixed(2)}\n'
          'z: ${gravidadeEixo(t.z, u.z).toStringAsFixed(2)}\n\n'
          'Vale 9.8 no eixo que aponta para baixo.';

    return Scaffold(
      appBar: AppBar(title: const Text('Gravidade')),
      body: Center(
        child: Text(texto,
            style: const TextStyle(fontSize: 22),
            textAlign: TextAlign.center),
      ),
    );
  }
}