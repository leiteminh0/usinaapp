import 'package:flutter/material.dart';
import '../../models/tipo_informacao.dart';

class CadastroTipoInformacao extends StatefulWidget {
  const CadastroTipoInformacao({super.key});

  @override
  State<CadastroTipoInformacao> createState() => _CadastroTipoInformacaoState();
}

class _CadastroTipoInformacaoState extends State<CadastroTipoInformacao> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  String? _unidadeMedidaSelecionada;

  final List<String> _unidadesMedida = [
    'Quilograma (kg)',
    'Litro (L)',
    'Metro (m)',
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final tipoInformacao = TipoInformacao(
        nome: _nomeController.text,
        unidadeMedida: _unidadeMedidaSelecionada,
      );
      print('TipoInformacao salvo: ${tipoInformacao.nome}, ${tipoInformacao.unidadeMedida}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tipo de Informação salvo com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Tipo de Informação')),
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
                initialValue: _unidadeMedidaSelecionada,
                decoration: const InputDecoration(labelText: 'Unidade de Medida'),
                items: _unidadesMedida
                    .map((u) => DropdownMenuItem(value: u, child: Text(u)))
                    .toList(),
                onChanged: (value) {
                  setState(() => _unidadeMedidaSelecionada = value);
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
