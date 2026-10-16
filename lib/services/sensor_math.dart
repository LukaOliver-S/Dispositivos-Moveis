import 'dart:math';

/// Ângulo de um vetor no plano X/Y, em graus (0 a 360).
/// Com o aparelho na horizontal, funciona como rumo aproximado.
double rumoGraus(double x, double y) {
  var graus = atan2(y, x) * 180 / pi;
  if (graus < 0) graus += 360;
  return graus;
}

/// Gravidade estimada num eixo: total do acelerômetro menos o movimento do usuário.
double gravidadeEixo(double total, double usuario) => total - usuario;

/// Inclinação lateral (rolagem), em graus, a partir da gravidade.
double rolagemGraus(double ax, double ay, double az) =>
    atan2(ay, az) * 180 / pi;

/// Inclinação frente/trás (arfagem), em graus, a partir da gravidade.
double arfagemGraus(double ax, double ay, double az) =>
    atan2(-ax, sqrt(ay * ay + az * az)) * 180 / pi;