/// Representa um jogo e seu preço (em reais) em cada uma das quatro
/// plataformas comparadas pelo aplicativo.
///
/// Quando o jogo não está disponível em determinada plataforma, o valor
/// correspondente é `null`.
class Jogo {
  final String nome;
  final double? precoSteam;
  final double? precoEpic;
  final double? precoXbox;
  final double? precoPlayStation;

  const Jogo({
    required this.nome,
    this.precoSteam,
    this.precoEpic,
    this.precoXbox,
    this.precoPlayStation,
  });

  /// Todos os preços do jogo organizados por plataforma, na ordem em que
  /// devem ser exibidos na interface e no gráfico.
  Map<String, double?> get precosPorPlataforma => {
        'Steam': precoSteam,
        'Epic Games': precoEpic,
        'Xbox': precoXbox,
        'PlayStation': precoPlayStation,
      };

  /// Retorna o nome da plataforma com o menor preço disponível,
  /// ou `null` caso o jogo não esteja disponível em nenhuma plataforma.
  String? get plataformaMaisBarata {
    final disponiveis = precosPorPlataforma.entries
        .where((entrada) => entrada.value != null)
        .toList();
    if (disponiveis.isEmpty) return null;

    disponiveis.sort((a, b) => a.value!.compareTo(b.value!));
    return disponiveis.first.key;
  }

  /// Diferença entre o maior e o menor preço disponível para o jogo.
  double get economiaMaxima {
    final valores = precosPorPlataforma.values
        .where((preco) => preco != null)
        .cast<double>()
        .toList();
    if (valores.length < 2) return 0;

    valores.sort();
    return valores.last - valores.first;
  }
}
