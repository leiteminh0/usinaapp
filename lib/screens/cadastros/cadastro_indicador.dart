import 'package:flutter/material.dart';

import '../../models/indicador.dart';

class CadastroIndicador extends StatefulWidget {
  const CadastroIndicador({super.key});

  @override
  State<CadastroIndicador> createState() => _CadastroIndicadorState();
}

class _CadastroIndicadorState extends State<CadastroIndicador> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _descricaoController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  void _salvar() {
    final formularioValido = _formKey.currentState?.validate() ?? false;
    if (!formularioValido) {
      return;
    }

    final indicador = Indicador(
      nome: _nomeController.text.trim(),
      descricao: _descricaoController.text.trim(),
      url: _urlController.text.trim(),
    );

    debugPrint(
      'Indicador salvo: ${indicador.nome}, ${indicador.descricao}, ${indicador.url}',
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text('Indicador cadastrado com sucesso!'),
              ),
            ],
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Indicador'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE7F2E8),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF236B45),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.insights_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Novo indicador',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: const Color(0xFF164B32),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Preencha os dados para acompanhar um aspecto importante da sua operação.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF5E7363),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Informações do indicador',
              style: theme.textTheme.titleMedium?.copyWith(
                color: const Color(0xFF164B32),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nomeController,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.name],
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        hintText: 'Ex.: Produtividade da lavoura',
                        prefixIcon: Icon(Icons.label_outline_rounded),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o nome';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descricaoController,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.newline,
                      minLines: 4,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        hintText: 'Explique o que este indicador acompanha.',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 58),
                          child: Icon(Icons.notes_rounded),
                        ),
                        alignLabelWithHint: true,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe a descrição';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _urlController,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.url],
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'URL',
                        hintText: 'https://exemplo.com',
                        prefixIcon: Icon(Icons.link_rounded),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe a URL';
                        }

                        final uri = Uri.tryParse(value.trim());
                        final esquemaValido = uri?.scheme.toLowerCase() == 'http' ||
                            uri?.scheme.toLowerCase() == 'https';

                        if (uri == null ||
                            !uri.hasScheme ||
                            !uri.hasAuthority ||
                            !esquemaValido) {
                          return 'Informe uma URL válida';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _salvar,
              icon: const Icon(Icons.check_rounded),
              label: const Text('Salvar indicador'),
            ),
            const SizedBox(height: 12),
            Text(
              'Os campos marcados são obrigatórios. Os dados ainda não são persistidos nesta etapa.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF748177),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
