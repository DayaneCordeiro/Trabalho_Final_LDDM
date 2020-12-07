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
  int newMissinTime;
  double newPercentage;

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
            // Parte estática para apresentação - remover quando ajustar bug no sqlite
            return ListView(
              children: [
                ListTile(
                  leading: const Icon(
                    Icons.today,
                    color: Colors.cyan,
                    size: 35,
                  ),
                  title: Text(
                    "Ler livros",
                    style: TextStyle(color: Colors.blue[100], fontSize: 20),
                  ),
                  subtitle: Text(
                    "Quantas páginas ler : 20" +
                        "                                         " +
                        "Quantas páginas faltam: " +
                        "                         " +
                        "Porcentagem atual: 0" +
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
                                  labelText:
                                      "Quantas páginas você quer adicionar?",
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
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.today,
                    color: Colors.cyan,
                    size: 35,
                  ),
                  title: Text(
                    "Aprender algo novo",
                    style: TextStyle(color: Colors.blue[100], fontSize: 20),
                  ),
                  subtitle: Text(
                    "Quanto tempo dedicar : 60" +
                        " min                                         " +
                        "Quanto tempo falta: 60 min" +
                        "                         " +
                        "Porcentagem atual: 0" +
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
                                  labelText:
                                      "Quantos minutos você quer adicionar?",
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
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                // Fim da parte estática, início da parte dinâmica
                for (int i = 0; i < _controller.list.length; i++)
                  ListTile(
                    leading: const Icon(
                      Icons.today,
                      color: Colors.cyan,
                      size: 35,
                    ),
                    title: Text(
                      _controller.list[i].title,
                      style: TextStyle(color: Colors.blue[100], fontSize: 20),
                    ),
                    subtitle: Text(
                      "Quanto tempo dedicar :" +
                          _controller.list[i].actualTime.toString() +
                          "                         " +
                          "Quanto tempo falta: " +
                          _controller.list[i].missingTime.toString() +
                          "                         " +
                          "Porcentagem atual: " +
                          _controller.list[i].percentage.toString() +
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
                                    labelText:
                                        "Quantos minutos você quer adicionar?",
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  style: TextStyle(
                                    color: Colors.white,
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
                                  // Calcula quantos minutos faltam para terminar a atividade
                                  newMissinTime =
                                      _controller.list[i].missingTime -
                                          int.parse(addTimeController.text);

                                  // Calcula o progresso em porcetagem
                                  double doneTime =
                                      (_controller.list[i].actualTime -
                                          _controller.list[i].missingTime);
                                  newPercentage = (doneTime * 100) /
                                      _controller.list[i].actualTime;

                                  _controller.update(
                                    Activity(
                                        id: _controller.list[i].id,
                                        title: _controller.list[i].title,
                                        actualTime:
                                            _controller.list[i].actualTime,
                                        missingTime: newMissinTime,
                                        percentage: newPercentage),
                                  );

                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  )
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
                  missingTime: 0,
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
