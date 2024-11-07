import 'package:flutter/material.dart';

class TelaPlanos extends StatefulWidget {
  const TelaPlanos({super.key});

  @override
  State<TelaPlanos> createState() => _TelaPlanosState();
}

class _TelaPlanosState extends State<TelaPlanos> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(fontFamily: 'BlackBrothers'),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: const Color.fromARGB(255, 168, 88, 9),
        ),
        body: Container(
          color: const Color.fromARGB(255, 168, 88, 9),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 40, right: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Antes de concluir o cadastro, escolha um plano',
                    style: TextStyle(fontSize: 23, color: Colors.white)),
                Container(
                  height: 600,
                  width: 600,
                  decoration: ShapeDecoration(
                      color: Colors.black,
                      shape: Border.all(
                        color: Colors.white,
                        width: 4.0,
                      )),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: const [
                      //Playteste do LISTVIEW
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50),
                      ),
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50),
                      ),
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50),
                      ),
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50),
                      ),
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50),
                      ),
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50, color: Colors.white),
                      ),
                      Text(
                        'data',
                        style: TextStyle(fontSize: 50),
                      ),
                    ],
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
