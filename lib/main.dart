import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pedra, Papel e Tesoura',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Pedra, Papel e Tesoura'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Opcao? _escolhaDoJogador;
  Opcao? _escolhaDoComputador;
  String? _resultado;

  void _jogar(Opcao escolhaDoJogador) {
    final random = Random();
    final escolhas = Opcao.values;
    final escolhaDoComputador = escolhas[random.nextInt(escolhas.length)];

    setState(() {
      _escolhaDoJogador = escolhaDoJogador;
      _escolhaDoComputador = escolhaDoComputador;
      if (_escolhaDoJogador != null && _escolhaDoComputador != null) {
        _resultado = determinarResultado(_escolhaDoJogador!, _escolhaDoComputador!);
      }
    });
  }

  Widget _buildOpcaoButton(Opcao opcao, String label) {
    return ElevatedButton(
      onPressed: () => _jogar(opcao),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Escolha uma opção:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildOpcaoButton(Opcao.pedra, 'Pedra'),
                const SizedBox(width: 10),
                _buildOpcaoButton(Opcao.papel, 'Papel'),
                const SizedBox(width: 10),
                _buildOpcaoButton(Opcao.tesoura, 'Tesoura'),
              ],
            ),
            const SizedBox(height: 20),
            if (_escolhaDoJogador != null && _escolhaDoComputador != null) ...[
              Text('Sua escolha: ${_escolhaDoJogador!.toString().split('.').last}'),
              Text('Escolha do computador: ${_escolhaDoComputador!.toString().split('.').last}'),
              const SizedBox(height: 20),
              Text(
                _resultado!,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

enum Opcao { pedra, papel, tesoura }

String determinarResultado(Opcao jogador, Opcao computador) {
  if (jogador == computador) {
    return "Empate!";
  } else if ((jogador == Opcao.pedra && computador == Opcao.tesoura) ||
      (jogador == Opcao.papel && computador == Opcao.pedra) ||
      (jogador == Opcao.tesoura && computador == Opcao.papel)) {
    return "Você ganhou!";
  } else {
    return "Você perdeu!";
  }
}
