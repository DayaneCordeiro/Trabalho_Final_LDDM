/*
 * MIT License

 * Copyright (c) 2020 Dayane Cordeiro

 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:

 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
*/

import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: AboutUsPage(title: 'Sobre este aplicativo'),
    );
  }
}

class AboutUsPage extends StatefulWidget {
  AboutUsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.cyan[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                'Este aplicativo foi desenvolvido pela bacharelanda em Engenharia de Computação, Dayane Cordeiro, em um trabalho acadêmico da ' +
                    'disciplina Laboratório de Desenvolvimento para Dispositívos Móveis na Pontifícia Universidade Católica de Minas Gerais. ' +
                    'O aplicativo tem por objetivo ajudar nas questões de cuidados mentais durante o período pandêmico causado pelo Covid 19, em ' +
                    'tempos de isolamento social e home office. A ideia principal do sistema é incentivar a inclusão de atividades saudáveis física e ' +
                    'psicologicamente na rotina com uma percepção visual do progresso durante cada dia. O cálculo do tempo de descanso é realizado' +
                    ' levando em consideração os tempos incluídos pelo usuário, sendo a extração dos minutos de descanso de acordo com a técnica Pomodoro,' +
                    ' somado ao tempo que pode ser pré definido para descanso.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}
