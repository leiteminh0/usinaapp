import 'package:flutter/material.dart';
import '../../models/unidade_medida.dart';

class CadastroUnidadeMedida extends StatefulWidget {
  const CadastroUnidadeMedida({super.key});

  @override
  State<CadastroUnidadeMedida> createState() => _CadastroUnidadeMedidaState();
}

class _CadastroUnidadeMedidaState extends State<CadastroUnidadeMedida> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _simboloController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _simboloController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final unidadeMedida = UnidadeMedida(
        nome: _nomeController.text,
        simbolo: _simboloController.text,
      );
      print('UnidadeMedida salva: ${unidadeMedida.nome}, ${unidadeMedida.simbolo}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unidade de Medida salva com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Unidade de Medida')),
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
              const SizedBox(height: 16),
              TextFormField(
                controller: _simboloController,
                decoration: const InputDecoration(labelText: 'Símbolo'),
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
