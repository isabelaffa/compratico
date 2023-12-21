import 'package:flutter/material.dart';

class UseGuidePage extends StatefulWidget {
  const UseGuidePage({super.key});

  @override
  State<UseGuidePage> createState() => _UseGuidePageState();
}

class _UseGuidePageState extends State<UseGuidePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Manual de Uso'),
        backgroundColor: Color(0xFFFFDDD2),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Bem-vindo ao Guia do Comprático!\nAqui você encontra explições para aproveitar as principais funcionalidades do aplicativo.", textAlign: TextAlign.center),
                defaultTitle("Adicionar um item na lista"),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset("images/guide-1.jpeg", height: 80,),
                    ),
                    Flexible(child: Text("Para adicionar um novo item na sua lista de compras, você deve clicar no botão com o símbolo +, no canto inferior direito da tela.\n\nTambém é possível incluir um novo item no menu, localizado no canto esquerdo superior da tela."))
                  ],
                ),
                defaultTitle("Editar um item da lista"),
                Text("Para editar um item, pressione o item que deseja alterar e as informações editáveis do item serão exibidas na janela abaixo.", textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Image.asset("images/guide-3.jpeg"),
                ),
                defaultTitle("Marcar um item da lista como Comprado"),
                Text('Para marcar um item da lista como Comprado, clique na caixinha vazia ao lado do nome do item.\nUm item Comprado terá seu nome riscado e o ícone da categoria substituído por um "check"', textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Image.asset("images/guide-6.jpeg"),
                ),
                defaultTitle("Excluir um item da lista"),
                Text("Para excluir um item da lista deslize o item para a direita, até o final da tela.", textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Image.asset("images/guide-4.png"),
                ),
                defaultTitle("Organizar os itens da lista"),
                Text("Para organizar os itens da lista, clique no botão de opções, no canto superior direito. É possível organizar por ordem alfabética crescente ou descrescente e pelas categorias da sua lista.", textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25),
                  child: Image.asset("images/guide-5.jpeg"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget defaultTitle(String textData) {
  return Padding(
    padding: const EdgeInsets.all(25),
    child: Text(
      textData,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
      )
    ),
  );
}