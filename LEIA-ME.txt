COMO USAR ESTE PROJETO
=======================

Este pacote contém apenas os arquivos de código-fonte do app
(pubspec.yaml e a pasta lib/), sem as pastas de plataforma
(android/ios/windows/etc.), pois estas são geradas automaticamente
pelo Flutter e variam conforme o SDK instalado na sua máquina.

Passo a passo:

1. Instale o Flutter SDK (https://flutter.dev) e confirme que
   `flutter doctor` roda sem erros.

2. Crie um novo projeto Flutter em branco:

   flutter create comparador_jogos

3. Substitua o pubspec.yaml gerado pelo deste pacote e substitua
   toda a pasta lib/ gerada pela pasta lib/ deste pacote (ela contém
   main.dart e as subpastas models/, data/ e widgets/).

4. Dentro da pasta do projeto, rode:

   flutter pub get
   flutter run

   (Se for rodar como app Windows e aparecer o erro "No Windows
   desktop project configured", rode antes:
   flutter config --enable-windows-desktop
   flutter create --platforms=windows .
   Ou, mais simples, rode em um emulador Android ou no Chrome:
   flutter run -d chrome)

BIBLIOTECA EXTERNA UTILIZADA (pub.dev)
=======================================
fl_chart (https://pub.dev/packages/fl_chart)

Usada em lib/widgets/grafico_precos.dart para desenhar um gráfico de
barras (BarChart) que compara visualmente o preço do jogo selecionado
nas quatro plataformas (Steam, Epic Games, Xbox e PlayStation). O
gráfico reage ao toque (tooltip mostrando o preço exato de cada barra)
e destaca com uma cor de fundo a plataforma mais barata. Sem essa
biblioteca, a comparação seria só uma lista de números — o gráfico é
o que dá a funcionalidade visual perceptível pedida na atividade.

Também foi usado o pacote intl (https://pub.dev/packages/intl) para
formatar todos os preços no padrão de moeda brasileiro (R$ 000,00).

ESTRUTURA DO CÓDIGO
====================
lib/
  main.dart                 -> tela principal (lista de jogos + painel do gráfico)
  models/jogo.dart          -> classe Jogo (nome, preços por plataforma,
                                cálculo da plataforma mais barata e da economia)
  data/lista_jogos.dart     -> lista fixa de jogos de exemplo com preços fictícios
  widgets/grafico_precos.dart -> gráfico de barras (fl_chart) do jogo selecionado
  widgets/cartao_jogo.dart  -> item da lista usado para selecionar o jogo

FUNCIONALIDADES IMPLEMENTADAS
==============================
- Lista com 12 jogos, cada um com preço (ou indisponibilidade) nas
  quatro plataformas.
- Ao tocar em um jogo da lista, o gráfico de barras no topo é
  atualizado (setState) para mostrar a comparação daquele jogo.
- Gráfico de barras (fl_chart) com uma barra por plataforma, cores
  diferentes por plataforma, tooltip ao tocar e destaque visual para
  a plataforma mais barata.
- Faixa de destaque em texto informando a plataforma mais barata e a
  economia em reais em relação à plataforma mais cara.
- Tratamento de jogos indisponíveis em alguma plataforma (barra cinza
  e texto "Indisponível" no tooltip), sem gerar erros.
- Preços formatados como moeda brasileira usando o pacote intl.
