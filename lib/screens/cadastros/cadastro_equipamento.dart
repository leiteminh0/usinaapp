import 'package:flutter/material.dart';
import '../../models/equipamento.dart';

class CadastroEquipamento extends StatefulWidget {
  const CadastroEquipamento({super.key});

  @override
  State<CadastroEquipamento> createState() => _CadastroEquipamentoState();
}

class _CadastroEquipamentoState extends State<CadastroEquipamento> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  String? _unidadeSelecionada;

  final List<String> _unidades = [
    'Unidade A',
    'Unidade B',
    'Unidade C',
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final equipamento = Equipamento(
        nome: _nomeController.text,
        unidade: _unidadeSelecionada,
      );
      print('Equipamento salvo: ${equipamento.nome}, ${equipamento.unidade}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Equipamento salvo com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Equipamento')),
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
              DropdownButtonFormField<String>(
                initialValue: _unidadeSelecionada,
                decoration: const InputDecoration(labelText: 'Unidade'),
                items: _unidades
                    .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                    .toList(),
                onChanged: (value) {
                  setState(() => _unidadeSelecionada = value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
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
