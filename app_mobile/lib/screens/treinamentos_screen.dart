import 'package:flutter/material.dart';
import '../data/dados_mock.dart';

class TreinamentosScreen extends StatefulWidget {
  const TreinamentosScreen({super.key});

  @override
  State<TreinamentosScreen> createState() => _TreinamentosScreenState();
}

class _TreinamentosScreenState extends State<TreinamentosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Treinamentos')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: treinamentos.length,
        itemBuilder: (_, i) {
          final t = treinamentos[i];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.school_outlined, size: 36),
                  const SizedBox(height: 12),
                  Text(t.titulo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(t.categoria),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(value: t.progresso / 100),
                  const SizedBox(height: 8),
                  Text('${t.progresso}% concluído'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: t.progresso == 100
                              ? null
                              : () => setState(() => t.progresso = (t.progresso + 20).clamp(0, 100)),
                          child: Text(t.progresso == 100 ? 'CONCLUÍDO' : 'RETOMAR'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton(onPressed: () {}, child: const Text('DETALHES')),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
