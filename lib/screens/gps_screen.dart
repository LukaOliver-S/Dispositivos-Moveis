import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GpsScreen extends StatefulWidget {
  const GpsScreen({super.key});

  @override
  State<GpsScreen> createState() => _GpsScreenState();
}

class _GpsScreenState extends State<GpsScreen> {
  Position? _posicao;
  String _status = 'Verificando permissões...';
  StreamSubscription<Position>? _sub;

  @override
  void initState() {
    super.initState();
    _iniciar();
  }

  Future<void> _iniciar() async {
    // 1. O serviço de localização (GPS) está ligado?
    if (!await Geolocator.isLocationServiceEnabled()) {
      setState(() => _status = 'Ative o serviço de localização.');
      return;
    }

    // 2. Pede permissão, se ainda não foi concedida
    var permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
    }
    if (permissao == LocationPermission.denied ||
        permissao == LocationPermission.deniedForever) {
      setState(() => _status = 'Permissão de localização negada.');
      return;
    }

    // 3. Assina as atualizações de posição
    _sub = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // atualiza a cada 5 m percorridos
      ),
    ).listen(
      (pos) => setState(() {
        _posicao = pos;
        _status = 'Recebendo posição';
      }),
      onError: (e) => setState(() => _status = 'Erro: $e'),
    );
  }

  @override
  void dispose() {
    _sub?.cancel(); // desliga o GPS ao sair da tela
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = _posicao;
    return Scaffold(
      appBar: AppBar(title: const Text('GPS')),
      body: Center(
        child: Text(
          p == null
              ? _status
              : 'Latitude: ${p.latitude.toStringAsFixed(6)}\n'
                'Longitude: ${p.longitude.toStringAsFixed(6)}\n'
                'Altitude: ${p.altitude.toStringAsFixed(1)} m\n'
                'Velocidade: ${(p.speed * 3.6).toStringAsFixed(1)} km/h',
          style: const TextStyle(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}