import 'package:flutter/material.dart';
import 'login_screen.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const CircleAvatar(radius: 45, child: Icon(Icons.person, size: 48)),
          const SizedBox(height: 20),
          const Center(child: Text('Natan Maxwell', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          const SizedBox(height: 8),
          const Center(child: Text('Proprietário/CEO')),
          const SizedBox(height: 30),
          const ListTile(
            leading: Icon(Icons.email_outlined),
            title: Text('E-mail'),
            subtitle: Text('natan.maxwell@maxwellb2b.com'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Editar perfil'),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
