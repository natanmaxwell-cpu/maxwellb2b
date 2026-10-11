import 'package:flutter/material.dart';
import '../data/dados_mock.dart';
import '../models/tarefa.dart';
import 'tarefas_screen.dart';
import 'tarefa_detalhes_screen.dart';
import 'treinamentos_screen.dart';
import 'perfil_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _dashboard(),
      TarefasScreen(onAbrirTarefa: _abrirTarefa),
      const TreinamentosScreen(),
      const PerfilScreen(),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.task_outlined), selectedIcon: Icon(Icons.task), label: 'Tarefas'),
          NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Treinamentos'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  void _abrirTarefa(Tarefa tarefa) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TarefaDetalhesScreen(tarefa: tarefa)),
    ).then((_) => setState(() {}));
  }

  Widget _dashboard() {
    final pendentes = tarefas.where((t) => t.status == StatusTarefa.pendente).length;
    final andamento = tarefas.where((t) => t.status == StatusTarefa.emAndamento).length;
    final concluidas = tarefas.where((t) => t.status == StatusTarefa.concluida).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('MaxwellB²'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none))],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Olá,', style: TextStyle(fontSize: 20)),
            const Text('Natan!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 28),
            const Text('Minhas Tarefas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                _status('Pendentes', '$pendentes', Icons.pending_actions),
                const SizedBox(width: 8),
                _status('Em andamento', '$andamento', Icons.timelapse),
                const SizedBox(width: 8),
                _status('Finalizadas', '$concluidas', Icons.check_circle_outline),
              ],
            ),
            const SizedBox(height: 30),
            const Text('Próximas tarefas', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...tarefas.where((t) => t.status != StatusTarefa.concluida).take(3).map(
              (t) => Card(
                child: ListTile(
                  leading: const Icon(Icons.task_outlined),
                  title: Text(t.titulo),
                  subtitle: Text(t.subtitulo),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _abrirTarefa(t),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _status(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
          child: Column(
            children: [
              Icon(icon),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
