import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:stars_race/src/app.dart';

void main() => runApp(MyApp());

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
      ThemeData(primarySwatch: Colors.blue, fontFamily: 'MaxwellRegular'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Built with S2 and Flutter Web by Julio Bitencourt',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 50,
          child: FlareActor(
            'assets/flare/starsRace.flr',
            animation: "Animate",
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon,
      Color color, String route) {
    return InkWell(
      child: Card(
        elevation: 0,
        color: Colors.teal,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Icon(
                icon,
                size: 40,
                color: color,
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                child: Text(
                  title,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
    );
  }
}

//      body: Stack(
//        children: <Widget>[
//          Container(
//            decoration: BoxDecoration(
//              gradient: LinearGradient(
//                begin: Alignment.topRight,
//                end: Alignment.bottomLeft,
//                colors: [Color(0XFF107dac), Color(0XFF71c7ec)],
//              ),
//            ),
//          ),
//          SafeArea(
//            child: CustomScrollView(
//              slivers: <Widget>[
//                SliverList(
//                  delegate: SliverChildListDelegate(
//                    [
//                      Row(
//                        children: <Widget>[
//                          Expanded(
//                            child: Text(
//                              'The live stars race',
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.w700,
//                                  fontSize: 40),
//                              textAlign: TextAlign.center,
//                            ),
//                          ),
//                        ],
//                      ),
//                      Row(
//                        children: <Widget>[
//                          Expanded(
//                            child: Text(
//                              'of the main cross platform mobile techs',
//                              style: TextStyle(color: Colors.white),
//                              textAlign: TextAlign.center,
//                            ),
//                          ),
//                        ],
//                      ),
//                      SizedBox(height: 30),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.end,
//                        children: <Widget>[
//                          Flexible(
//                            flex: 1,
//                            child: Container(),
//                          ),
//                          Flexible(
//                            flex: 5,
//                            child: Card(
//                              child: Container(
//                                height: 100,
//                              ),
//                            ),
//                          ),
//                          Flexible(
//                            flex: 6,
//                            child: Card(
//                              child: Container(
//                                height: 120,
//                              ),
//                            ),
//                          ),
//                          Flexible(
//                            flex: 5,
//                            child: Card(
//                              child: Container(
//                                height: 80,
//                              ),
//                            ),
//                          ),
//                          Flexible(
//                            flex: 1,
//                            child: Container(),
//                          ),
//                        ],
//                      )
//                    ],
//                  ),
//                ),
//                SliverGrid(
//                  delegate: SliverChildListDelegate(
//                    [
//                      _buildCard(context, "Quadro de Horários",
//                          Icons.calendar_today, Colors.blue[400], "calendar"),
//                      _buildCard(context, "Desempenho", Icons.show_chart,
//                          Colors.redAccent, "performance"),
//                      _buildCard(context, "Financeiro", Icons.attach_money,
//                          Colors.orange, "financeiro"),
//                      _buildCard(context, "Quadro de Horários",
//                          Icons.calendar_today, Colors.blue[400], "calendar"),
//                      _buildCard(context, "Desempenho", Icons.show_chart,
//                          Colors.redAccent, "performance"),
//                      _buildCard(context, "Financeiro", Icons.attach_money,
//                          Colors.orange, "financeiro"),
//                      _buildCard(context, "Documentos", Icons.folder_open,
//                          Colors.lime[600], "document"),
//                      _buildCard(context, "Dados Pessoais",
//                          Icons.person_outline, Colors.green[300], "profile"),
//                      _buildCard(context, "Fale Conosco", Icons.message,
//                          Colors.lightBlue[300], "feedback"),
//                      _buildCard(context, "Avaliação de Satisfação", Icons.list,
//                          Colors.green[800], "editalAvaliacao"),
//                      _buildCard(
//                          context,
//                          "Pesquisa de Entrada e de Saída",
//                          Icons.assignment,
//                          Colors.blue[800],
//                          "editalQuestionario"),
//                      _buildCard(context, "Rematrícula", Icons.school,
//                          Colors.deepPurple[400], "editalRematricula"),
//                    ],
//                  ),
//                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisSpacing: 10,
//                    mainAxisSpacing: 10,
//                    childAspectRatio: 1.2,
//                    crossAxisCount: 2,
//                  ),
//                )
//              ],
//            ),
//          )
//        ],
//      ),