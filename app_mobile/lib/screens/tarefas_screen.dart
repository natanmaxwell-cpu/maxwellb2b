import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/tarefa.dart';

class TarefasScreen extends StatefulWidget {
  final ValueChanged<Tarefa> onAbrirTarefa;

  const TarefasScreen({
    super.key,
    required this.onAbrirTarefa,
  });

  @override
  State<TarefasScreen> createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  String filtro = 'Todas';

  List<Tarefa> tarefas = [];
  bool carregando = true;
  String? erro;

  @override
  void initState() {
    super.initState();
    carregarTarefas();
  }

  Future<void> carregarTarefas() async {
    try {
      final resposta = await http.get(
        Uri.parse('http://192.168.15.8:5229/api/tarefas'),
      );

      if (resposta.statusCode == 200) {
        final List<dynamic> dados = jsonDecode(resposta.body);

        setState(() {
          tarefas = dados.map<Tarefa>((item) {
            return Tarefa(
              id: item['id'],
              titulo: item['titulo'],
              subtitulo: 'Tarefa recebida da API',
              status: _converterStatus(item['status']),
              solicitante: 'API',
            );
          }).toList();

          carregando = false;
        });
      } else {
        setState(() {
          erro = 'Erro ao carregar tarefas: ${resposta.statusCode}';
          carregando = false;
        });
      }
    } catch (e) {
      setState(() {
        erro = 'Não foi possível conectar à API.';
        carregando = false;
      });
    }
  }

  StatusTarefa _converterStatus(String status) {
    switch (status) {
      case 'Pendente':
        return StatusTarefa.pendente;

      case 'Em andamento':
        return StatusTarefa.emAndamento;

      case 'Concluída':
        return StatusTarefa.concluida;

      default:
        return StatusTarefa.pendente;
    }
  }

  List<Tarefa> get filtradas {
    if (filtro == 'Pendentes') {
      return tarefas
          .where((t) => t.status == StatusTarefa.pendente)
          .toList();
    }

    if (filtro == 'Em progresso') {
      return tarefas
          .where((t) => t.status == StatusTarefa.emAndamento)
          .toList();
    }

    if (filtro == 'Concluídas') {
      return tarefas
          .where((t) => t.status == StatusTarefa.concluida)
          .toList();
    }

    return tarefas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: carregando
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : erro != null
                ? Center(
                    child: Text(
                      erro!,
                      textAlign: TextAlign.center,
                    ),
                  )
                : Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            'Todas',
                            'Pendentes',
                            'Em progresso',
                            'Concluídas'
                          ].map((item) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ChoiceChip(
                                label: Text(item),
                                selected: filtro == item,
                                onSelected: (_) {
                                  setState(() {
                                    filtro = item;
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: filtradas.length,
                          itemBuilder: (_, i) {
                            final t = filtradas[i];

                            return Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.task_outlined,
                                ),
                                title: Text(
                                  t.titulo,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(t.subtitulo),
                                trailing: const Icon(
                                  Icons.chevron_right,
                                ),
                                onTap: () => widget.onAbrirTarefa(t),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}