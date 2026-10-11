import 'package:flutter/material.dart';
import '../models/tarefa.dart';

class TarefaDetalhesScreen extends StatefulWidget {
  final Tarefa tarefa;
  const TarefaDetalhesScreen({super.key, required this.tarefa});

  @override
  State<TarefaDetalhesScreen> createState() => _TarefaDetalhesScreenState();
}

class _TarefaDetalhesScreenState extends State<TarefaDetalhesScreen> {
  void alterar(StatusTarefa status) {
    setState(() => widget.tarefa.status = status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(status == StatusTarefa.concluida ? 'Tarefa aprovada.' : 'Tarefa rejeitada.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.tarefa;
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da tarefa')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.titulo, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Text('Solicitante: ${t.solicitante}'),
            const SizedBox(height: 10),
            Text('Departamento: ${t.departamento}'),
            const SizedBox(height: 10),
            Text('Data: ${t.data}'),
            const SizedBox(height: 24),
            const Text('Descrição', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(t.descricao),
            const SizedBox(height: 32),
            if (t.status != StatusTarefa.concluida)
              Row(
                children: [
                  Expanded(child: ElevatedButton(onPressed: () => alterar(StatusTarefa.concluida), child: const Text('APROVAR'))),
                  const SizedBox(width: 12),
                  Expanded(child: OutlinedButton(onPressed: () => alterar(StatusTarefa.pendente), child: const Text('REJEITAR'))),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
