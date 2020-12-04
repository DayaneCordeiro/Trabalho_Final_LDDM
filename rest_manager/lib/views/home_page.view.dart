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
        ));
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
                Text(_controller.list.length.toString()),
                for (int i = 0; i < _controller.list.length; i++)
                  Text(_controller.list[i].title)
                //ListTile(title: Text(_controller.list[i].title))
              ],
            );
          } else {
            return Text("Carregando");
          }
        }),
      ),
      backgroundColor: Colors.grey[800],
    );
  }
}
