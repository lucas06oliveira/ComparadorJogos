import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/jogo.dart';

/// Cores fixas usadas para identificar cada plataforma tanto no gráfico
/// quanto na legenda.
const Map<String, Color> coresPlataforma = {
  'Steam': Color(0xFF1B2838),
  'Epic Games': Color(0xFF2A2A2A),
  'Xbox': Color(0xFF107C10),
  'PlayStation': Color(0xFF0070D1),
};

/// Gráfico de barras que compara visualmente o preço de [jogo] em cada
/// plataforma. É aqui que a biblioteca fl_chart (obtida no pub.dev) é
/// efetivamente usada para acrescentar uma funcionalidade perceptível ao
/// aplicativo: a visualização gráfica da comparação de preços.
class GraficoPrecos extends StatelessWidget {
  final Jogo jogo;

  const GraficoPrecos({super.key, required this.jogo});

  @override
  Widget build(BuildContext context) {
    final formatoMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final plataformas = jogo.precosPorPlataforma.keys.toList();

    final maiorPreco = jogo.precosPorPlataforma.values
        .where((preco) => preco != null)
        .cast<double>()
        .fold<double>(0, (atual, preco) => preco > atual ? preco : atual);

    return SizedBox(
      height: 260,
      child: BarChart(
        BarChartData(
          maxY: maiorPreco == 0 ? 10 : maiorPreco * 1.2,
          alignment: BarChartAlignment.spaceAround,
          gridData: const FlGridData(show: true, drawVerticalLine: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (valor, meta) {
                  final indice = valor.toInt();
                  if (indice < 0 || indice >= plataformas.length) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      plataformas[indice],
                      style: const TextStyle(fontSize: 11),
                    ),
                  );
                },
              ),
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (grupo, grupoIndex, rod, rodIndex) {
                final plataforma = plataformas[grupo.x.toInt()];
                final preco = jogo.precosPorPlataforma[plataforma];
                final texto = preco == null
                    ? 'Indisponível'
                    : formatoMoeda.format(preco);
                return BarTooltipItem(
                  '$plataforma\n$texto',
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
          barGroups: List.generate(plataformas.length, (indice) {
            final plataforma = plataformas[indice];
            final preco = jogo.precosPorPlataforma[plataforma];
            final ehMaisBarato = plataforma == jogo.plataformaMaisBarata;

            return BarChartGroupData(
              x: indice,
              barRods: [
                BarChartRodData(
                  toY: preco ?? 0,
                  width: 28,
                  borderRadius: BorderRadius.circular(6),
                  color: preco == null
                      ? Colors.grey.shade300
                      : coresPlataforma[plataforma],
                  backDrawRodData: BackgroundBarChartRodData(
                    show: ehMaisBarato && preco != null,
                    toY: (maiorPreco == 0 ? 10 : maiorPreco * 1.2),
                    color: Colors.green.withOpacity(0.06),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
