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
import 'package:rest_manager/views/home_page.view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rest_manager/controllers/activity.controller.dart';
import 'package:rest_manager/models/activity.model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../app_status.dart';

class FormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyForm(title: 'Configurações 🔧'),
    );
  }
}

class MyForm extends StatefulWidget {
  MyForm({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  // Controllers
  TextEditingController _workedHours = new TextEditingController();
  TextEditingController _restTime = new TextEditingController();

  // Variables
  bool booksValue = false;
  bool workoutValue = false;
  bool meditateValue = false;
  bool restValue = false;
  bool learningValue = false;
  ActivityController _controller = null;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Verifica se tem as informações já salvas no shared preferences
  _loadData() async {
    SharedPreferences preferences = await SharedPreferences
        .getInstance(); // Pega uma instancia do shared preferences

    // Se tiver algum valor salvo no shared preferences seta nas variáveis
    setState(() {
      booksValue = (preferences.getBool('booksValue') ?? false);
      workoutValue = (preferences.getBool('workoutValue') ?? false);
      meditateValue = (preferences.getBool('meditateValue') ?? false);
      restValue = (preferences.getBool('restValue') ?? false);
      learningValue = (preferences.getBool('learningValue') ?? false);

      _workedHours.text = (preferences.getString('_workedHours') ?? '0');
      _restTime.text = (preferences.getString('_restTime') ?? '0');
    });
  }

  // Salva as informações no shared preferences
  _setData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (booksValue) {
      Activity books = new Activity(
          title: 'Ler livros', actualTime: 0, missingTime: 0, percentage: 100);
      preferences.setString('books', books.toString());
    }

    setState(() {
      preferences.setBool('booksValue', booksValue);
      preferences.setBool('workoutValue', workoutValue);
      preferences.setBool('meditateValue', meditateValue);
      preferences.setBool('restValue', restValue);
      preferences.setBool('learningValue', learningValue);

      preferences.setString('_workedHours', _workedHours.text);
      preferences.setString('_restTime', _restTime.text);
    });
  }

  // Função que verifica se os campos  foram preenchidos antes de deixar salvar
  _validate(String text, String field) {
    if (text.isEmpty) {
      return "Informe $field";
    }
    return null;
  }

  // @brief Determina quantos itens estão marcados como true
  int _findTrue() {
    int counter = 0;

    if (booksValue) counter += 1;
    if (workoutValue) counter += 1;
    if (meditateValue) counter += 1;
    if (restValue) counter += 1;
    if (learningValue) counter += 1;

    return counter;
  }

  // @brief Verifica quanto tempo a pessoa terá de descanso por dia
  int _calculateTime() {
    // Essa função tem como base o método pomodoro, para cada hora de trabalho, deve-se tirar 10 minutos de descanso
    int totalTime = 0;

    // Aplica o método pomodoro e calcula os minutos de descanso de acordo com as horas de trabalho
    if (_workedHours.text.isNotEmpty && _workedHours.text != '0') {
      double aux = double.parse(_workedHours.text);
      totalTime += (aux * 10).round();
    }

    // Caso tenha tempo de descanso, transforma em números, converte pra minutos (int)
    if (_restTime.text.isNotEmpty && _restTime.text != '0') {
      double aux = double.parse(_restTime.text);
      double minutes = aux * 60; // Transforma as horas em minutos
      totalTime += minutes.round();
    }

    return totalTime;
  }

  // @brief Se a atividade de ler livros estiver marcada, calcula quantas páginas pode ler no tempo proposto
  int _calculatePages(int time) {
    // basseando numa estimativa de 3 minutos por página
    int totalPages = (time / 3).floor();

    return totalPages;
  }

  // @brief Limpa o banco de dados antes de salvar as novas informações
  _clearDatabase() async {
    ActivityController _controller =
        Provider.of<ActivityController>(context, listen: false);
    await _controller.getAll();

    int aux = _controller.list.length;

    // Percorre o banco deletando todas as configurações anteriores para manter apenas a atual
    while (aux > 0) {
      await _controller.delete(_controller.list.first.id);
      print(aux);
      aux--;
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<ActivityController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.cyan[700],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            // Horas trabalhadas
            TextFormField(
              controller: _workedHours,
              validator: (validation) =>
                  _validate(validation, " as horas trabalhadas"),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantas horas você trabalha por dia?",
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),

            // Tempo de descanso
            TextFormField(
              controller: _restTime,
              validator: (validation) =>
                  _validate(validation, " as horas de descanso"),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantas horas de descanso você tem por dia?",
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),

            // Distanciamento
            Padding(
              padding: EdgeInsets.all(20),
            ),

            // Text
            Text(
              "Agora marque as atividades que você deseja incluir na sua rotina:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),

            // Lista de coisas que a pessoa pode escolher

            // Op 01
            CheckboxListTile(
              value: booksValue,
              title: Text(
                "Ler livros",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onChanged: (bool newValue) {
                setState(() {
                  booksValue = newValue;
                });
              },
            ),

            // Op 02
            CheckboxListTile(
              value: workoutValue,
              title: Text(
                "Fazer exercícios físicos",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onChanged: (bool newValue) {
                setState(() {
                  workoutValue = newValue;
                });
              },
            ),

            // Op 03
            CheckboxListTile(
              value: meditateValue,
              title: Text(
                "Meditar",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onChanged: (bool newValue) {
                setState(() {
                  meditateValue = newValue;
                });
              },
            ),

            // Op 04
            CheckboxListTile(
              value: restValue,
              title: Text(
                "Descansar",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onChanged: (bool newValue) {
                setState(() {
                  restValue = newValue;
                });
              },
            ),

            // Op 05
            CheckboxListTile(
              value: learningValue,
              title: Text(
                "Aprender algo novo",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onChanged: (bool newValue) {
                setState(() {
                  learningValue = newValue;
                });
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          _setData();
          // Recebeu quantas atividades deve fazer por dia
          int counter = _findTrue();

          // Recebeu quanto tempo de descanso deve ter
          int totalTime = _calculateTime();

          // Se o tempo for maior que zero, divide entre as atividades selecionadas
          int activityTime = (totalTime / counter).floor();

          // Se a atividade de ler livros tiver sido marcada, vamos calcular quantas páginas
          // baseado em um estudo oferecido que mostra que em média uma pessoa consegue ler
          // uma página a cada 3 minutos
          int numPages = 0;

          if (booksValue) {
            // Se o livro tiver sido marcado realiza a lógica
            numPages = _calculatePages(activityTime);
          }

          // Apaga tudo que está no banco para reescrever as informações
          await _clearDatabase();

          // Salvando no banco as atividades selecionadas
          if (booksValue) {
            await _controller.create(Activity(
                title: "Ler livros",
                actualTime: numPages.toDouble(),
                missingTime: numPages,
                percentage: 0));
          }
          if (workoutValue) {
            await _controller.create(Activity(
                title: "Atividades Físicas",
                actualTime: activityTime.toDouble(),
                missingTime: activityTime,
                percentage: 0));
          }
          if (meditateValue) {
            await _controller.create(Activity(
                title: "Meditação",
                actualTime: activityTime.toDouble(),
                missingTime: activityTime,
                percentage: 0));
          }
          if (restValue) {
            await _controller.create(Activity(
                title: "Descansar",
                actualTime: activityTime.toDouble(),
                missingTime: activityTime,
                percentage: 0));
          }
          if (learningValue) {
            await _controller.create(Activity(
                title: "Aprender algo novo",
                actualTime: activityTime.toDouble(),
                missingTime: activityTime,
                percentage: 0));
          }

          //print(_controller.list.last.id);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyApp(),
            ),
          );
        },
        label: Text('Salvar'),
        backgroundColor: Colors.cyan[700],
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}
