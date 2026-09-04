import 'package:flutter_test/flutter_test.dart';
import 'package:usina_app/main.dart';

void main() {
  testWidgets('exibe o painel inicial e os acessos rápidos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const UsinaApp());

    expect(find.text('Painel da usina'), findsOneWidget);
    expect(find.text('Indicadores'), findsOneWidget);
    expect(find.text('Equipamentos'), findsOneWidget);
  });

  testWidgets('abre o cadastro de indicador pelo menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const UsinaApp());

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cadastro'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Indicador'));
    await tester.pumpAndSettle();

    expect(find.text('Novo indicador'), findsOneWidget);
    expect(find.text('Salvar indicador'), findsOneWidget);
  });

  testWidgets('mostra validações nos campos obrigatórios', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const UsinaApp());

    await tester.tap(find.text('Indicadores'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Salvar indicador'));
    await tester.pump();

    expect(find.text('Informe o nome'), findsOneWidget);
    expect(find.text('Informe a descrição'), findsOneWidget);
    expect(find.text('Informe a URL'), findsOneWidget);
  });

  testWidgets('valida URL e confirma o cadastro com dados válidos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const UsinaApp());

    await tester.tap(find.text('Indicadores'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byLabelText('Nome'), 'Produtividade');
    await tester.enterText(
      find.byLabelText('Descrição'),
      'Acompanha a produção por hectare.',
    );
    await tester.enterText(find.byLabelText('URL'), 'https://exemplo.com');
    await tester.tap(find.text('Salvar indicador'));
    await tester.pump();

    expect(find.text('Indicador cadastrado com sucesso!'), findsOneWidget);
  });
}
