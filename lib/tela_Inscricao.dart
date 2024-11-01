import 'package:flutter/material.dart';

class TelaInscricao extends StatefulWidget {
  const TelaInscricao({Key? key}) : super(key: key);

  @override
  State<TelaInscricao> createState() => _TelaInscricaoState();
}

class _TelaInscricaoState extends State<TelaInscricao> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Iscrever-se',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: Container(
          color: Color.fromARGB(255, 168, 88, 9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.white,
                width: 300,
                height: 50,
              ),
              Container(
                color: Colors.white,
                width: 300,
                height: 50,
              ),
              Container(
                color: Colors.white,
                width: 300,
                height: 50,
              ),
              Container(
                color: Colors.white,
                width: 300,
                height: 50,
              ),
              Container(
                color: Colors.white,
                width: 300,
                height: 50,
              ),
              Container(
                color: Colors.white,
                width: 300,
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  backgroundColor: const Color.fromARGB(255, 75, 174, 79),
                ),
                onPressed: () {
                  print('Inscrito');
                },
                child: Text(
                  'INSCREVER-SE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ));
  }
}
