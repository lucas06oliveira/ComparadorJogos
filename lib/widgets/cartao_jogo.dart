import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/jogo.dart';
import 'grafico_precos.dart';

/// Item de lista que representa um jogo. Mostra o nome, a plataforma mais
/// barata (com destaque de cor) e fica visualmente selecionado quando é o
/// jogo atualmente exibido no gráfico.
class CartaoJogo extends StatelessWidget {
  final Jogo jogo;
  final bool selecionado;
  final VoidCallback aoTocar;

  const CartaoJogo({
    super.key,
    required this.jogo,
    required this.selecionado,
    required this.aoTocar,
  });

  @override
  Widget build(BuildContext context) {
    final formatoMoeda = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    final plataformaBarata = jogo.plataformaMaisBarata;
    final precoBarato = plataformaBarata == null
        ? null
        : jogo.precosPorPlataforma[plataformaBarata];

    return Card(
      elevation: selecionado ? 3 : 1,
      color: selecionado ? Colors.indigo.shade50 : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selecionado ? Colors.indigo : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: ListTile(
        onTap: aoTocar,
        title: Text(
          jogo.nome,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: plataformaBarata == null
            ? const Text('Sem preços cadastrados')
            : Text('Mais barato: $plataformaBarata • ${formatoMoeda.format(precoBarato)}'),
        trailing: plataformaBarata == null
            ? null
            : CircleAvatar(
                radius: 6,
                backgroundColor: coresPlataforma[plataformaBarata],
              ),
      ),
    );
  }
}
