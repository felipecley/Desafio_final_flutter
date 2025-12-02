
/*import 'package:flutter/material.dart';
import '../services/api.dart';
import '../models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override State<ProductsScreen> createState()=> _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>{
  List<Product> products=[];

  Future load() async {
    final data = await ApiService.getList("produtos");
    setState(()=> products = data.map<Product>((e)=> Product.fromJson(e)).toList());
  }

  @override void initState(){ super.initState(); load(); }

  @override Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Produtos")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){}, 
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (c,i){
          final p = products[i];
          return ListTile(
            title: Text(p.nome),
            subtitle: Text(p.descricao),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await ApiService.delete("produtos", p.id!);
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
import '../models/product.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> products = [];
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

      final data = await ApiService.getList("produtos");

      setState(() {
        products = data
            .map<Product>((e) => Product.fromJson(e as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      setState(() {
        error = 'Erro ao carregar produtos';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> _openProductForm({Product? existing}) async {
    final nomeCtrl = TextEditingController(text: existing?.nome ?? '');
    final descCtrl = TextEditingController(text: existing?.descricao ?? '');
    final precoCtrl = TextEditingController(
      text: existing != null ? existing.preco.toStringAsFixed(2) : '',
    );

    final isEditing = existing != null;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEditing ? 'Editar produto' : 'Novo produto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeCtrl,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: descCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                ),
                TextField(
                  controller: precoCtrl,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(labelText: 'Preço'),
                  onChanged: (v) {
                    // troca vírgula por ponto pra evitar erro
                    precoCtrl.value = precoCtrl.value.copyWith(
                      text: v.replaceAll(',', '.'),
                      selection: TextSelection.collapsed(
                        offset: v.replaceAll(',', '.').length,
                      ),
                    );
                  },
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
                    descCtrl.text.trim().isEmpty ||
                    precoCtrl.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preencha todos os campos'),
                    ),
                  );
                  return;
                }

                if (double.tryParse(precoCtrl.text.trim()) == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preço inválido'),
                    ),
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

    // Se o usuário clicou em SALVAR
    if (result == true) {
      final preco = double.parse(precoCtrl.text.trim());

      final body = {
        'nome': nomeCtrl.text.trim(),
        'descricao': descCtrl.text.trim(),
        'preco': preco,
        'data_atualizado': DateTime.now().toIso8601String(),
      };

      if (isEditing && existing!.id != null) {
        // EDITAR (PUT)
        await ApiService.put("produtos", existing.id!, body);
      } else {
        // CRIAR (POST)
        await ApiService.post("produtos", body);
      }

      await load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openProductForm(), // CADASTRAR
        child: const Icon(Icons.add),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : products.isEmpty
                  ? const Center(child: Text('Nenhum produto cadastrado.'))
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final p = products[index];
                        return ListTile(
                          title: Text(p.nome),
                          subtitle: Text(
                            '${p.descricao}\nR\$ ${p.preco.toStringAsFixed(2)}',
                          ),
                          isThreeLine: true,

                          // TOCAR NO ITEM → EDITAR
                          onTap: () => _openProductForm(existing: p),

                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () async {
                              await ApiService.delete("produtos", p.id!);
                              await load();
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}
