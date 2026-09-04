import 'package:flutter/material.dart';

import 'cadastros/cadastro_equipamento.dart';
import 'cadastros/cadastro_indicador.dart';
import 'cadastros/cadastro_tipo_informacao.dart';
import 'cadastros/cadastro_unidade.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  bool cadastroAberto = false;

  Widget montarMenu() {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF236B45), Color(0xFF164B32)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Color(0x33FFFFFF),
                  child: Icon(
                    Icons.agriculture_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Menu Principal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Gestão agrícola inteligente',
                  style: TextStyle(
                    color: Color(0xFFD7EBDD),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Início'),
          ),
          ListTile(
            leading: const Icon(Icons.app_registration_rounded),
            title: const Text('Cadastro'),
            trailing: Icon(
              cadastroAberto ? Icons.expand_less : Icons.expand_more,
              color: const Color(0xFF236B45),
            ),
            onTap: () {
              setState(() {
                cadastroAberto = !cadastroAberto;
              });
            },
          ),
          if (cadastroAberto) ...[
            _itemCadastro(
              titulo: 'Unidade',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CadastroUnidade(),
                  ),
                );
              },
            ),
            _itemCadastro(titulo: 'Setor'),
            _itemCadastro(
              titulo: 'Equipamento',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CadastroEquipamento(),
                  ),
                );
              },
            ),
            _itemCadastro(
              titulo: 'Indicador',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CadastroIndicador(),
                  ),
                );
              },
            ),
            _itemCadastro(titulo: 'Funcionário'),
            _itemCadastro(
              titulo: 'Tipo de Medição',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CadastroTipoInformacao(),
                  ),
                );
              },
            ),
            _itemCadastro(titulo: 'Parâmetro'),
          ],
        ],
      ),
    );
  }

  Widget _itemCadastro({required String titulo, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 40, right: 16),
      leading: const Icon(Icons.chevron_right_rounded, size: 20),
      title: Text(titulo),
      onTap: onTap,
      enabled: onTap != null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usina App'),
      ),
      drawer: Drawer(
        child: montarMenu(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Painel da usina',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: const Color(0xFF164B32),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Organize seus dados agrícolas com clareza.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF637268),
              ),
            ),
            const SizedBox(height: 22),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF236B45), Color(0xFF164B32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x22236B45),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gestão que cresce\ncom a sua operação.',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Acesse os cadastros pelo menu e mantenha sua usina em movimento.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFFD7EBDD),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(
                    Icons.agriculture_rounded,
                    color: Color(0xFFC9E6C7),
                    size: 60,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Acesso rápido',
              style: theme.textTheme.titleLarge?.copyWith(
                color: const Color(0xFF164B32),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _AcessoRapidoCard(
                    icon: Icons.insights_rounded,
                    titulo: 'Indicadores',
                    subtitulo: 'Cadastre e acompanhe',
                    cor: const Color(0xFFE4F2E7),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CadastroIndicador(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _AcessoRapidoCard(
                    icon: Icons.precision_manufacturing_rounded,
                    titulo: 'Equipamentos',
                    subtitulo: 'Mantenha atualizado',
                    cor: const Color(0xFFF7ECD9),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CadastroEquipamento(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AcessoRapidoCard extends StatelessWidget {
  const _AcessoRapidoCard({
    required this.icon,
    required this.titulo,
    required this.subtitulo,
    required this.cor,
    required this.onTap,
  });

  final IconData icon;
  final String titulo;
  final String subtitulo;
  final Color cor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: titulo,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cor,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF236B45),
                    size: 24,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Color(0xFF164B32),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitulo,
                  style: const TextStyle(
                    color: Color(0xFF718076),
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
