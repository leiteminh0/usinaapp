import 'package:flutter/material.dart';
import '../../models/unidade.dart';

class CadastroUnidade extends StatefulWidget {
  const CadastroUnidade({super.key});

  @override
  State<CadastroUnidade> createState() => _CadastroUnidadeState();
}

class _CadastroUnidadeState extends State<CadastroUnidade> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final unidade = Unidade(
        nome: _nomeController.text,
      );
      print('Unidade salva: ${unidade.nome}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unidade salva com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Unidade')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _salvar,
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
