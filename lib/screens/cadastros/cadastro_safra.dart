import 'package:flutter/material.dart';
import '../../models/safra.dart';

class CadastroSafra extends StatefulWidget {
  const CadastroSafra({super.key});

  @override
  State<CadastroSafra> createState() => _CadastroSafraState();
}

class _CadastroSafraState extends State<CadastroSafra> {
  final _formKey = GlobalKey<FormState>();

  final _nomeSafraController = TextEditingController();
  DateTime? _dataInicio;
  DateTime? _dataFim;

  @override
  void dispose() {
    _nomeSafraController.dispose();
    super.dispose();
  }

  Future<void> _selecionarDataInicio() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataInicio ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (data != null) {
      setState(() => _dataInicio = data);
    }
  }

  Future<void> _selecionarDataFim() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataFim ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (data != null) {
      setState(() => _dataFim = data);
    }
  }

  String _formatarData(DateTime? data) {
    if (data == null) return '';
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      final safra = Safra(
        nomeSafra: _nomeSafraController.text,
        dataInicio: _dataInicio,
        dataFim: _dataFim,
      );
      print('Safra salva: ${safra.nomeSafra}, ${safra.dataInicio}, ${safra.dataFim}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Safra salva com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Safra')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeSafraController,
                decoration: const InputDecoration(labelText: 'Nome da Safra'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: _formatarData(_dataInicio)),
                decoration: const InputDecoration(
                  labelText: 'Data de Início',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: _selecionarDataInicio,
                validator: (_) {
                  if (_dataInicio == null) return 'Campo obrigatório';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: _formatarData(_dataFim)),
                decoration: const InputDecoration(
                  labelText: 'Data de Fim',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: _selecionarDataFim,
                validator: (_) {
                  if (_dataFim == null) return 'Campo obrigatório';
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
