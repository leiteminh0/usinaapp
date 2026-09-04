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
              Icon(Icons.check_circle_outline_rounded, color: Colors.white),
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
        title: const Text('Novo indicador'),
      ),
      body: Stack(
        children: [
          const _FormBackgroundDecor(),
          Form(
            key: _formKey,
            child: ListView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 34),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cadastre um novo\nindicador.',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              color: const Color(0xFF171717),
                              fontWeight: FontWeight.w800,
                              height: 1.05,
                              letterSpacing: -1.1,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Dados claros para decisões melhores.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF777777),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3CBD4).withOpacity(0.78),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                      child: const Icon(
                        Icons.insights_outlined,
                        color: Color(0xFF242424),
                        size: 27,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informações essenciais',
                          style: TextStyle(
                            color: Color(0xFF242424),
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Preencha os dados abaixo para identificar e acompanhar este indicador.',
                          style: TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 13,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                              child: Icon(Icons.notes_outlined),
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
                            prefixIcon: Icon(Icons.link_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Informe a URL';
                            }

                            final uri = Uri.tryParse(value.trim());
                            final esquemaValido =
                                uri?.scheme.toLowerCase() == 'http' ||
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
                  icon: const Icon(Icons.arrow_forward_rounded, size: 19),
                  label: const Text('Salvar indicador'),
                ),
                const SizedBox(height: 13),
                Text(
                  'Os dados ainda não são persistidos nesta etapa.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFFA8A8A8),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FormBackgroundDecor extends StatelessWidget {
  const _FormBackgroundDecor();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 10,
            right: -62,
            child: Container(
              width: 170,
              height: 170,
              decoration: const BoxDecoration(
                color: Color(0x22E7A1B0),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 24,
            left: -92,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                color: Color(0x1CF3CBD4),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
