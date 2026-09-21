import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'data/lista_jogos.dart';
import 'models/jogo.dart';
import 'widgets/cartao_jogo.dart';
import 'widgets/grafico_precos.dart';

void main() {
  runApp(const ComparadorJogosApp());
}

class ComparadorJogosApp extends StatelessWidget {
  const ComparadorJogosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comparador de Preços de Jogos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const TelaComparador(),
    );
  }
}

class TelaComparador extends StatefulWidget {
  const TelaComparador({super.key});

  @override
  State<TelaComparador> createState() => _TelaComparadorState();
}

class _TelaComparadorState extends State<TelaComparador> {
  // Jogo atualmente exibido no gráfico de comparação.
  late Jogo _jogoSelecionado;

  @override
  void initState() {
    super.initState();
    _jogoSelecionado = listaDeJogos.first;
  }

  void _selecionarJogo(Jogo jogo) {
    setState(() {
      _jogoSelecionado = jogo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatoMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final plataformaBarata = _jogoSelecionado.plataformaMaisBarata;
    final economia = _jogoSelecionado.economiaMaxima;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comparador de Preços de Jogos'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ---------- Painel de comparação (gráfico) ----------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Text(
                  _jogoSelecionado.nome,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                GraficoPrecos(jogo: _jogoSelecionado),
                const SizedBox(height: 4),
                if (plataformaBarata != null) ...[
                  _FaixaDeDestaque(
                    plataforma: plataformaBarata,
                    economia: economia,
                    formatoMoeda: formatoMoeda,
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
          ),

          // ---------- Lista de jogos disponíveis ----------
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Escolha um jogo para comparar',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
              itemCount: listaDeJogos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, indice) {
                final jogo = listaDeJogos[indice];
                return CartaoJogo(
                  jogo: jogo,
                  selecionado: jogo.nome == _jogoSelecionado.nome,
                  aoTocar: () => _selecionarJogo(jogo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Faixa de destaque mostrando a plataforma mais barata e a economia
/// possível em relação à plataforma mais cara, para o jogo selecionado.
class _FaixaDeDestaque extends StatelessWidget {
  final String plataforma;
  final double economia;
  final NumberFormat formatoMoeda;

  const _FaixaDeDestaque({
    required this.plataforma,
    required this.economia,
    required this.formatoMoeda,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.trending_down, size: 18, color: Colors.green),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              economia > 0
                  ? 'Mais barato na $plataforma (economize ${formatoMoeda.format(economia)})'
                  : 'Mesmo preço em todas as plataformas disponíveis',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
