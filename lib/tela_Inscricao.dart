import 'package:flutter/material.dart';

class TelaInscricao extends StatefulWidget {
  const TelaInscricao({Key? key}) : super(key: key);

  @override
  State<TelaInscricao> createState() => _TelaInscricaoState();
}

class _TelaInscricaoState extends State<TelaInscricao> {
  final TextEditingController usuarioIncricao = TextEditingController();
  final TextEditingController emailIncricao = TextEditingController();
  final TextEditingController cpfIncricao = TextEditingController();
  final TextEditingController dtnascIncricao = TextEditingController();
  final TextEditingController tellIncricao = TextEditingController();
  final TextEditingController senhaIncricao = TextEditingController();
  bool IsChecked = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        title: const Text(''),
        backgroundColor: const Color.fromARGB(255, 168, 88, 9),
      ),
      body: Container(
          color: const Color.fromARGB(255, 168, 88, 9),
          child: ListView(scrollDirection: Axis.vertical, children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Container(
                color: Colors.transparent,
                height: 100,
                width: 200,
                child: Image.asset(
                  'Assets/Black_Brother.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                width: 100,
                height: 70,
                child: TextField(
                  controller: usuarioIncricao,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    hintText: 'Usuario',
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                width: 100,
                height: 70,
                child: TextField(
                  controller: emailIncricao,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    hintText: 'E-mail',
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                width: 100,
                height: 70,
                child: TextField(
                  controller: cpfIncricao,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    hintText: 'Cpf',
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                width: 100,
                height: 70,
                child: TextField(
                  controller: dtnascIncricao,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    hintText: 'Data nascimento',
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                width: 100,
                height: 70,
                child: TextField(
                  controller: tellIncricao,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    hintText: 'Telefone',
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                width: 100,
                height: 70,
                child: TextField(
                  controller: senhaIncricao,
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    hintText: 'Senha',
                    fillColor: Colors.white70,
                    filled: true,
                  ),
                ),
              ),
            ),
        Align(
            alignment: Alignment.center,
            child: Container(
              width: 200,
              child: Row(
                children: [
                  Checkbox( value: IsChecked, onChanged: (bool? newvalue){
                    setState(() {
                      IsChecked = newvalue ?? false;
                    });
                  }),
                  const Text('Termos de condições', style:TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold,),),
                ],
              ),
            ),
        ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(200, 40),
                        backgroundColor: const Color.fromARGB(255, 75, 174, 79),
                      ),
                      onPressed: () {
                        print(usuarioIncricao.text);
                        print(emailIncricao.text);
                        print(cpfIncricao.text);
                        print(dtnascIncricao.text);
                        print(tellIncricao.text);
                        print(senhaIncricao.text);
                      },
                      child: const Text(
                        'INSCREVER-SE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 168, 88, 9),
                        elevation: 0,
                      ),
                      onPressed: () {
                        print("cu");
                      },
                      child: const Text(
                        'Voltar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ])),
    );
  }
}
