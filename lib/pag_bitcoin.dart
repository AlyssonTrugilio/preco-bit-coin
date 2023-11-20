import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePageBitcoin extends StatefulWidget {
  const HomePageBitcoin({super.key});

  @override
  State<HomePageBitcoin> createState() => _HomePageBitcoinState();
}

class _HomePageBitcoinState extends State<HomePageBitcoin> {
  String _preco = '0';

  void _recuperarDados() async {
    String url = 'https://blockchain.info/ticker';
    http.Response response;
    response = await http.get(Uri.parse(url));

    Map<String, dynamic> retornoApi = json.decode(response.body);

    setState(() {
      _preco = retornoApi["BRL"]["buy"].toString();
    });
  }

  /*Future _recuperandoDados() {
    return Future.delayed(Duration(seconds: 1), () => _recuperandoDados());
  } */

  void _zerarValor() {
    setState(() {
      _preco = '0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/bitcoin.png'),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
              child: Text(
                'R\$ $_preco',
                style: const TextStyle(fontSize: 30),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _recuperarDados,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15)),
                  child: const Text(
                    'Atualizar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  onPressed: _zerarValor,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 209, 145, 49),
                      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15)),
                  child: const Text(
                    'Zerar',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
