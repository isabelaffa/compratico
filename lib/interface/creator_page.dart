import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreatorPage extends StatefulWidget {
  const CreatorPage({super.key});

  @override
  State<CreatorPage> createState() => _CreatorPageState();
}

class _CreatorPageState extends State<CreatorPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFDDD2),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    const Flexible(child: Text("Oi, eu sou a Isabela!", style: TextStyle(color: Color(0xFFC0565A), fontSize: 28, fontWeight: FontWeight.w700))),
                    Image.asset("images/creator.png", height: 200,)
                  ],
                ),
                SizedBox(height: 40,),
                Text("Eu sou estudante no curso de Sistemas de Informação na PUC Minas e Desenvolvedora na Construtora Barbosa Mello.\n", textAlign: TextAlign.center,),
                Text("Meu foco é desenvolvimento em Javascript aplicado a modelagem de processos de negócios.\n", textAlign: TextAlign.center,),
                Text("Esse aplicativo foi feito com muito carinho e dedicação para o trabalho final da matéria de Desenvolvimento de Aplicações Móveis, no 2º semestre de 2023.", textAlign: TextAlign.center,),
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