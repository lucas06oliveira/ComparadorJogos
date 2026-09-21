import '../models/jogo.dart';

/// Lista de jogos exibida no aplicativo, com preços fictícios (em reais)
/// usados apenas para fins de demonstração/estudo.
final List<Jogo> listaDeJogos = [
  const Jogo(
    nome: 'Elden Ring',
    precoSteam: 249.90,
    precoEpic: 259.90,
    precoXbox: 249.00,
    precoPlayStation: 249.00,
  ),
  const Jogo(
    nome: 'Cyberpunk 2077',
    precoSteam: 99.50,
    precoEpic: 89.99,
    precoXbox: 99.75,
    precoPlayStation: 109.90,
  ),
  const Jogo(
    nome: 'Grand Theft Auto V',
    precoSteam: 49.99,
    precoEpic: 39.99,
    precoXbox: 59.99,
    precoPlayStation: 54.99,
  ),
  const Jogo(
    nome: 'Red Dead Redemption 2',
    precoSteam: 89.99,
    precoEpic: 79.99,
    precoXbox: 99.99,
    precoPlayStation: 94.99,
  ),
  const Jogo(
    nome: 'Hogwarts Legacy',
    precoSteam: 149.90,
    precoEpic: 159.90,
    precoXbox: 149.00,
    precoPlayStation: 149.00,
  ),
  const Jogo(
    nome: 'EA Sports FC 24',
    precoSteam: 199.90,
    precoEpic: null, // não disponível na Epic Games
    precoXbox: 189.90,
    precoPlayStation: 199.90,
  ),
  const Jogo(
    nome: 'Minecraft',
    precoSteam: null, // não disponível na Steam
    precoEpic: 79.90,
    precoXbox: 79.90,
    precoPlayStation: 79.90,
  ),
  const Jogo(
    nome: 'Fortnite',
    precoSteam: 0,
    precoEpic: 0,
    precoXbox: 0,
    precoPlayStation: 0,
  ),
  const Jogo(
    nome: 'Assassin\'s Creed Mirage',
    precoSteam: 129.90,
    precoEpic: 119.90,
    precoXbox: 129.90,
    precoPlayStation: 129.90,
  ),
  const Jogo(
    nome: 'Spider-Man Remastered',
    precoSteam: 149.90,
    precoEpic: 149.90,
    precoXbox: null, // exclusivo Steam/Epic/PlayStation
    precoPlayStation: 139.90,
  ),
  const Jogo(
    nome: 'Forza Horizon 5',
    precoSteam: 179.90,
    precoEpic: null,
    precoXbox: 169.90,
    precoPlayStation: null, // exclusivo Xbox/PC
  ),
  const Jogo(
    nome: 'Baldur\'s Gate 3',
    precoSteam: 174.99,
    precoEpic: 174.99,
    precoXbox: 174.99,
    precoPlayStation: 174.99,
  ),
];
