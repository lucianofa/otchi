import 'package:flutter/material.dart';
import 'package:ot/pages/home/tarefa_item_component.dart';
import 'package:ot/services/auth_service.dart';

import '../../models/tarefa.dart';
import '../../services/api.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                await AuthService.logout();
                Navigator.of(context).pushNamed('/login');
              },
              child: const Text('Deslogar'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('OT - Organizador de Tarefas'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/cadastrar_tarefa');
        },
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<Iterable<Tarefa>>(
              stream: API.listaTarefas(),
              initialData: const [],
              builder: (context, snapshot) {
                return ListView(
                  children: snapshot.data!.map((tarefa) => TarefaItemComponent(tarefa: tarefa)).toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
