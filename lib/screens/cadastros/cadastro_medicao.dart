import 'package:flutter/material.dart';
import '../../models/medicao.dart';

class CadastroMedicao extends StatefulWidget {
  const CadastroMedicao({super.key});

  @override
  State<CadastroMedicao> createState() => _CadastroMedicaoState();
}

class _CadastroMedicaoState extends State<CadastroMedicao> {
  final _formKey = GlobalKey<FormState>();

  String? _safraSelecionada;
  String? _equipamentoSelecionado;
  String? _tipoInformacaoSelecionado;
  final _valorController = TextEditingController();
  DateTime? _data;
  TimeOfDay? _hora;

  final List<String> _safras = ['Safra 2023/2024', 'Safra 2024/2025', 'Safra 2025/2026'];
  final List<String> _equipamentos = ['Equipamento A', 'Equipamento B', 'Equipamento C'];
  final List<String> _tiposInformacao = ['Temperatura', 'Pressão', 'Vazão'];

  @override
  void dispose() {
    _valorController.dispose();
    super.dispose();
  }

  Future<void> _selecionarDataHora() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _data ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (data == null) return;

    if (!mounted) return;
    final hora = await showTimePicker(
      context: context,
      initialTime: _hora ?? TimeOfDay.now(),
    );
    if (hora == null) return;

    setState(() {
      _data = data;
      _hora = hora;
    });
  }

  String _formatarDataHora() {
    if (_data == null || _hora == null) return '';
    final d = _data!;
    final h = _hora!;
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}'
        ' ${h.hour.toString().padLeft(2, '0')}:${h.minute.toString().padLeft(2, '0')}';
  }

  void _salvar() {
    if (_formKey.currentState!.validate()) {
      DateTime? dataCompleta;
      if (_data != null && _hora != null) {
        dataCompleta = DateTime(
          _data!.year,
          _data!.month,
          _data!.day,
          _hora!.hour,
          _hora!.minute,
        );
      }
      final medicao = Medicao(
        safra: _safraSelecionada,
        equipamento: _equipamentoSelecionado,
        tipoInformacao: _tipoInformacaoSelecionado,
        valor: double.tryParse(_valorController.text.replaceAll(',', '.')),
        data: dataCompleta,
      );
      print(
        'Medicao salva: safra=${medicao.safra}, equipamento=${medicao.equipamento}, '
        'tipoInformacao=${medicao.tipoInformacao}, valor=${medicao.valor}, data=${medicao.data}',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Medição salva com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Medição')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                initialValue: _safraSelecionada,
                decoration: const InputDecoration(labelText: 'Safra'),
                items: _safras
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (value) => setState(() => _safraSelecionada = value),
                validator: (value) =>
                    value == null ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _equipamentoSelecionado,
                decoration: const InputDecoration(labelText: 'Equipamento'),
                items: _equipamentos
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (value) => setState(() => _equipamentoSelecionado = value),
                validator: (value) =>
                    value == null ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _tipoInformacaoSelecionado,
                decoration: const InputDecoration(labelText: 'Tipo de Informação'),
                items: _tiposInformacao
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (value) => setState(() => _tipoInformacaoSelecionado = value),
                validator: (value) =>
                    value == null ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _valorController,
                decoration: const InputDecoration(labelText: 'Valor'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Campo obrigatório';
                  }
                  final parsed = double.tryParse(value.replaceAll(',', '.'));
                  if (parsed == null) return 'Informe um número válido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                readOnly: true,
                controller: TextEditingController(text: _formatarDataHora()),
                decoration: const InputDecoration(
                  labelText: 'Data e Hora',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: _selecionarDataHora,
                validator: (_) {
                  if (_data == null || _hora == null) return 'Campo obrigatório';
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
