import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:stars_race/src/app/bloc/provider/bloc_provider.dart';
import 'package:stars_race/src/app/bloc/stars_race_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('called');
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildBackground(),
        _buildContentArea(),
      ],
    );
  }

  Widget _buildContentArea() {
    return SafeArea(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _buildHeader(),
              _buildSubHeader(),
              _buildWinners(),
            ],
          ),
        )
      ],
    ));
  }

  Widget _buildContent(BuildContext context) {
    final bloc = BlocProvider.of<StarsRaceBloc>(context);

    return StreamBuilder<StarsRaceState>(
      stream: bloc.reposStream,
      builder: (BuildContext context, AsyncSnapshot<StarsRaceState> snapshot) {
        final state = snapshot.data;

        if (state.isLoading) {
          return _buildLoading();
        }

        if (state.hasError) {
          return Center(
            child: Text('Error :/'),
          );
        }

        return Center(
          child: Text(snapshot.data.winners.toString()),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: SizedBox(
        height: 50,
        child: FlareActor(
          'assets/flare/starsRace.flr',
          animation: "Animate",
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
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
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [const Color(0XFF107dac), const Color(0XFF71c7ec)],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'The live stars race',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 40,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildSubHeader() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'of the main cross platform mobile techs',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildWinners() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(child: Container()),
        Card(
          child: Container(
            constraints: BoxConstraints.loose(Size(160, 100)),
          ),
        ),
        Card(
          child: Container(
            constraints: BoxConstraints.loose(Size(160, 140)),
          ),
        ),
        Card(
          child: Container(
            constraints: BoxConstraints.loose(Size(160, 120)),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }

}
