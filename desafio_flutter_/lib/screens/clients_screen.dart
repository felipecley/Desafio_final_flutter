
/*import 'package:flutter/material.dart';
import '../services/api.dart';
import '../models/client.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});
  @override State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen>{
  List<Client> clients=[];

  Future load() async {
    final data = await ApiService.getList("clientes");
    setState(()=> clients = data.map<Client>((e)=> Client.fromJson(e)).toList());
  }

  @override void initState(){ super.initState(); load(); }

  @override Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Clientes")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){}, 
      ),
      body: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (c,i){
          final cli = clients[i];
          return ListTile(
            title: Text("${cli.nome} ${cli.sobrenome}"),
            subtitle: Text(cli.email),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await ApiService.delete("clientes", cli.id!);
                load();
              },
            ),
          );
        }
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import '../services/api.dart';
import '../models/client.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  List<Client> clients = [];
  bool loading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    try {
      setState(() {
        loading = true;
        error = null;
      });

      final data = await ApiService.getList("clientes");

      setState(() {
        clients = data
            .map<Client>((e) => Client.fromJson(e as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      setState(() {
        error = 'Erro ao carregar clientes';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _openClientForm({Client? existing}) async {
    final nomeCtrl = TextEditingController(text: existing?.nome ?? '');
    final sobrenomeCtrl = TextEditingController(text: existing?.sobrenome ?? '');
    final emailCtrl = TextEditingController(text: existing?.email ?? '');
    final idadeCtrl = TextEditingController(
        text: existing != null ? existing.idade.toString() : '');

    final isEditing = existing != null;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Editar cliente' : 'Novo cliente'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeCtrl,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: sobrenomeCtrl,
                  decoration: const InputDecoration(labelText: 'Sobrenome'),
                ),
                TextField(
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                ),
                TextField(
                  controller: idadeCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Idade'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () {
                if (nomeCtrl.text.trim().isEmpty ||
                    sobrenomeCtrl.text.trim().isEmpty ||
                    emailCtrl.text.trim().isEmpty ||
                    idadeCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos')),
                  );
                  return;
                }

                if (int.tryParse(idadeCtrl.text.trim()) == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Idade inválida')),
                  );
                  return;
                }

                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (result == true) {
      final idade = int.parse(idadeCtrl.text.trim());

      final body = {
        'nome': nomeCtrl.text.trim(),
        'sobrenome': sobrenomeCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
        'idade': idade,
        'foto': '',
      };

      if (isEditing && existing!.id != null) {
        await ApiService.put("clientes", existing.id!, body);
      } else {
        await ApiService.post("clientes", body);
      }

      await load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _openClientForm(),
        child: const Icon(Icons.add),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : clients.isEmpty
                  ? const Center(child: Text('Nenhum cliente cadastrado.'))
                  : ListView.builder(
                      itemCount: clients.length,
                      itemBuilder: (context, index) {
                        final c = clients[index];

                        return ListTile(
                          title: Text("${c.nome} ${c.sobrenome}"),
                          subtitle: Text("${c.email} • ${c.idade} anos"),

                          onTap: () => _openClientForm(existing: c),

                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await ApiService.delete("clientes", c.id!);
                              await load();
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}
