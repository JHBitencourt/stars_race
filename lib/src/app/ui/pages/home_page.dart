import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:stars_race/src/app/bloc/provider/bloc_provider.dart';
import 'package:stars_race/src/app/bloc/stars_race_bloc.dart';
import 'package:stars_race/src/app/model/bean/repo_info.dart';
import 'package:stars_race/src/app/model/core/utils/colors.dart';
import 'package:stars_race/src/app/ui/widgets/card_repo.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('called');
    return Scaffold(
      extendBody: true,
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildBackground(),
        _buildContentArea(context),
      ],
    );
  }

  Widget _buildContentArea(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _buildHeader(),
          _buildSubHeader(),
          Expanded(child: _buildContent(context))
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final bloc = BlocProvider.of<StarsRaceBloc>(context);

    return StreamBuilder<StarsRaceState>(
      stream: bloc.reposStream,
      initialData: StarsRaceState.loading(),
      builder: (BuildContext context, AsyncSnapshot<StarsRaceState> snapshot) {
        final state = snapshot.data;

        if (state.isLoading) {
          return _buildLoading();
        }

        if (state.hasError) {
          return Center(
            child: Text('Error :/'),
//            https://developer.github.com/v3/#rate-limiting
          );
        }

        return CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _buildLabel('Winners:'),
            ),
            _buildWinners(state.winners),
            SliverToBoxAdapter(
              child: _buildLabel('Others:'),
            ),
            _buildOthers(state.others)
          ],
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
        children: <Widget>[
          Expanded(
            child: _buildLabel(
              'Built with S2 and Flutter Web by Julio Bitencourt',
            ),
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
          colors: [darkBlue, lightBlue],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
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
      ),
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

  Widget _buildWinners(List<RepoInfo> winners) {
    return SliverToBoxAdapter(
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CardRepo(
                position: 3,
                constraints: BoxConstraints.loose(Size(160, 140)),
                repoInfo: winners[2],
              ),
              CardRepo(
                position: 1,
                constraints: BoxConstraints.loose(Size(160, 160)),
                repoInfo: winners[0],
              ),
              CardRepo(
                position: 2,
                constraints: BoxConstraints.loose(Size(160, 150)),
                repoInfo: winners[1],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOthers(List<RepoInfo> others) {
    final cards = <CardRepo>[];
    for (var i = 0; i < others.length; i++) {
      cards.add(
        CardRepo(
          position: i + 4,
          repoInfo: others[i],
        ),
      );
    }

    return SliverGrid(
      delegate: SliverChildListDelegate(cards),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 1,
        crossAxisCount: 3,
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
