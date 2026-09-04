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
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 16),
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF6DDE2), Color(0xFFF3CBD4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withOpacity(0.75)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Color(0xCCFFFFFF),
                  child: Icon(
                    Icons.agriculture_outlined,
                    color: Color(0xFF171717),
                    size: 26,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'Menu Principal',
                  style: TextStyle(
                    color: Color(0xFF171717),
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.4,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Gestão agrícola, do seu jeito.',
                  style: TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'NAVEGAÇÃO',
              style: TextStyle(
                color: Color(0xFFA8A8A8),
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.3,
              ),
            ),
          ),
          const SizedBox(height: 6),
          const ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 24),
            leading: Icon(Icons.home_outlined, size: 22),
            title: Text('Início'),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            leading: const Icon(Icons.grid_view_outlined, size: 22),
            title: const Text('Cadastro'),
            trailing: Icon(
              cadastroAberto ? Icons.remove : Icons.add,
              color: const Color(0xFF777777),
              size: 19,
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
      contentPadding: const EdgeInsets.only(left: 48, right: 24),
      leading: const Icon(Icons.arrow_outward_rounded, size: 16),
      title: Text(
        titulo,
        style: const TextStyle(fontSize: 14.5),
      ),
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              tooltip: 'Perfil',
              onPressed: () {},
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.68),
                foregroundColor: const Color(0xFF242424),
              ),
              icon: const Icon(Icons.person_outline_rounded, size: 20),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: montarMenu(),
      ),
      body: Stack(
        children: [
          const _BackgroundDecor(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 6, 20, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá, produtor.',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: const Color(0xFF171717),
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Tudo o que importa para sua operação, em um só lugar.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF777777),
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 26),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(22, 22, 18, 22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF3CBD4), Color(0xFFFBECEF)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white.withOpacity(0.82)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1AE7A1B0),
                          blurRadius: 28,
                          offset: Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Um campo mais\ninteligente.',
                                style: TextStyle(
                                  color: Color(0xFF171717),
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  height: 1.05,
                                  letterSpacing: -0.9,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Cadastre, organize e acompanhe cada detalhe da sua usina.',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF5F5A5B),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.56),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          child: const Icon(
                            Icons.spa_outlined,
                            color: Color(0xFF171717),
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 34),
                  Text(
                    'Acesso rápido',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF171717),
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.35,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Comece por onde precisa hoje.',
                    style: TextStyle(
                      color: Color(0xFF777777),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _AcessoRapidoCard(
                          icon: Icons.insights_outlined,
                          titulo: 'Indicadores',
                          subtitulo: 'Cadastre e acompanhe',
                          cor: const Color(0xFFF6DDE2),
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
                          icon: Icons.precision_manufacturing_outlined,
                          titulo: 'Equipamentos',
                          subtitulo: 'Mantenha atualizado',
                          cor: const Color(0xFFEDE9E9),
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
          ),
        ],
      ),
    );
  }
}

class _BackgroundDecor extends StatelessWidget {
  const _BackgroundDecor();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: 80,
            right: -55,
            child: Container(
              width: 170,
              height: 170,
              decoration: const BoxDecoration(
                color: Color(0x20E7A1B0),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: -90,
            child: Container(
              width: 210,
              height: 210,
              decoration: const BoxDecoration(
                color: Color(0x18F3CBD4),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
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
        borderRadius: BorderRadius.circular(28),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 17, 16, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: cor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF242424),
                    size: 23,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Color(0xFF242424),
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitulo,
                  style: const TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 14),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: Color(0xFFA8A8A8),
                    size: 19,
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
