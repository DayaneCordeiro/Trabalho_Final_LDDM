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
import 'package:flutter_mobx/flutter_mobx.dart';
import 'form.view.dart';
import 'about_us.view.dart';
import 'package:provider/provider.dart';
import '../controllers/activity.controller.dart';
import 'package:rest_manager/models/activity.model.dart';
import '../app_status.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ActivityController>.value(
          value: ActivityController(),
        )
      ],
      child: MaterialApp(
        title: 'Gerenciador de descanso',
        debugShowCheckedModeBanner: false,
        home: MyHomePage(title: 'Gerenciador de descanso'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Variables
  ActivityController _controller;
  var addTimeController = new TextEditingController();
  int newMissingTime;
  double newPercentage;

  // @brief Retorna o texto da primeira linha de acordo com o tipo de Atividade
  String _retornaPrimeiraLinhaTexto(String title) {
    if (title == "Ler livros") {
      return "Quantas páginas ler hoje";
    } else {
      return "Quanto minutos dedicar hoje";
    }
  }

  // @brief Retorna o texto da segunda linha de acordo com o tipo de Atividade
  String _retornaSegundaLinhaTexto(String title) {
    if (title == "Ler livros") {
      return "Quantas páginas faltam";
    } else {
      return "Quantos minutos faltam";
    }
  }

  // @brief Retorna o texto do modal de acordo com a atividade
  String _retornaTextoModal(String title) {
    if (title == "Ler livros") {
      return "Quantas páginas você leu?";
    } else {
      return "Quantos minutos você fez?";
    }
  }

  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<ActivityController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.cyan[700],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormApp(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.error_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutUs(),
                ),
              );
            },
          )
        ],
      ),
      body: Scrollbar(
        child: Observer(builder: (_) {
          if (_controller.status == AppStatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (_controller.status == AppStatus.success) {
            return ListView(
              children: [
                for (int i = 0; i < _controller.list.length; i++)
                  Card(
                      color: Colors.grey[700],
                      child: ListTile(
                        leading: const Icon(
                          Icons.today,
                          color: Colors.cyan,
                          size: 35,
                        ),
                        title: Text(
                          _controller.list[i].title,
                          style:
                              TextStyle(color: Colors.blue[100], fontSize: 20),
                        ),
                        subtitle: Text(
                          _retornaPrimeiraLinhaTexto(
                                  _controller.list[i].title) +
                              ": " +
                              _controller.list[i].actualTime
                                  .toInt()
                                  .toString() +
                              "                                          " +
                              _retornaSegundaLinhaTexto(
                                  _controller.list[i].title) +
                              ": " +
                              _controller.list[i].missingTime.toString() +
                              "                                           " +
                              "Porcentagem atual: " +
                              _controller.list[i].percentage
                                  .toStringAsPrecision(3) +
                              "%",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        isThreeLine: true,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Form(
                                  child: Container(
                                    height: 150,
                                    child: TextFormField(
                                      controller: addTimeController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: _retornaTextoModal(
                                            _controller.list[i].title),
                                        labelStyle: TextStyle(fontSize: 14),
                                      ),
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    child: new Text('CANCELAR'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: new Text('SALVAR'),
                                    onPressed: () {
                                      // Calcula quantos minutos faltam para terminar a atividade e atualiza a tela
                                      newMissingTime =
                                          _controller.list[i].missingTime -
                                              int.parse(addTimeController.text);

                                      // Calcula o progresso em porcetagem e atualiza a tela7
                                      double doneTime =
                                          (_controller.list[i].actualTime -
                                              newMissingTime);
                                      newPercentage = (doneTime * 100) /
                                          _controller.list[i].actualTime;

                                      _controller.update(
                                        Activity(
                                            id: _controller.list[i].id,
                                            title: _controller.list[i].title,
                                            actualTime:
                                                _controller.list[i].actualTime,
                                            missingTime: newMissingTime,
                                            percentage: newPercentage),
                                      );

                                      addTimeController.clear();

                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )),
              ],
            );
          } else {
            return Text("Carregando");
          }
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          for (int i = 0; i < _controller.list.length; i++) {
            _controller.update(
              Activity(
                  id: _controller.list[i].id,
                  title: _controller.list[i].title,
                  actualTime: _controller.list[i].actualTime,
                  missingTime: _controller.list[i].actualTime.toInt(),
                  percentage: 0),
            );
          }
        },
        label: Text('Zerar progresso'),
        backgroundColor: Colors.cyan[700],
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}
