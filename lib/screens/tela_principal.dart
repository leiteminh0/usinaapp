import 'package:flutter/material.dart';
import 'cadastros/cadastro_indicador.dart';
import 'cadastros/cadastro_unidade.dart';
import 'cadastros/cadastro_equipamento.dart';
import 'cadastros/cadastro_tipo_informacao.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  bool cadastroAberto = false;

  Widget montarMenu() {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          child: Text(
            'Menu Principal',
            style: TextStyle(fontSize: 22),
          ),
        ),
        const ListTile(
          leading: Icon(Icons.home),
          title: Text('Início'),
        ),
        ListTile(
          leading: const Icon(Icons.app_registration),
          title: const Text('Cadastro'),
          trailing: Icon(
            cadastroAberto
                ? Icons.expand_less
                : Icons.expand_more,
          ),
          onTap: () {
            setState(() {
              cadastroAberto = !cadastroAberto;
            });
          },
        ),
        if (cadastroAberto) ...[
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Unidade'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CadastroUnidade()));
            },
          ),
          const ListTile(
            leading: Icon(Icons.chevron_right),
            title: Text('Setor'),
          ),
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Equipamento'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CadastroEquipamento()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Indicador'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CadastroIndicador()));
            },
          ),
          const ListTile(
            leading: Icon(Icons.chevron_right),
            title: Text('Funcionário'),
          ),
          ListTile(
            leading: const Icon(Icons.chevron_right),
            title: const Text('Tipo de Medição'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CadastroTipoInformacao()));
            },
          ),
          const ListTile(
            leading: Icon(Icons.chevron_right),
            title: Text('Parâmetro'),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usina App'),
      ),
      drawer: Drawer(
        child: montarMenu(),
      ),
      body: const Center(
        child: Text('Tela Principal'),
      ),
    );
  }
}
