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
    if (text == '0' || text.isEmpty) {
      return "Informe $field";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
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
                  _validate(_workedHours.text, " as horas trabalhadas"),
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
                  _validate(_restTime.text, " as horas de descanso"),
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
          SharedPreferences preferences = await SharedPreferences.getInstance();
          print(_restTime.text);
          print('teste mermão');
          print(preferences.getBool('booksValue').toString());
          print(preferences.getString('_restTime'));
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
