import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stars_race/src/app/bloc/provider/bloc_provider.dart';
import 'package:stars_race/src/app/bloc/stars_race_bloc.dart';
import 'package:stars_race/src/app/model/bean/repo_info.dart';
import 'package:stars_race/src/app/model/core/utils/colors.dart';
import 'package:stars_race/src/app/ui/widgets/card_repo.dart';
import 'package:stars_race/src/app/ui/widgets/ink_well_platform_aware.dart';
import 'package:stars_race/src/app/ui/widgets/utils/custom_icons.dart';
import 'package:stars_race/src/app/ui/widgets/utils/size_config.dart';
import 'package:stars_race/src/app/ui/widgets/utils/url_utils.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig.of(context);

    return Scaffold(
      extendBody: true,
      body: _buildBody(context, sizeConfig),
      bottomNavigationBar: _buildBottomBar(sizeConfig),
    );
  }

  Widget _buildBody(BuildContext context, SizeConfig sizeConfig) {
    return Stack(
      children: <Widget>[
        _buildBackground(),
        _buildContentArea(context, sizeConfig),
      ],
    );
  }

  Widget _buildContentArea(BuildContext context, SizeConfig sizeConfig) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _buildHeader(sizeConfig),
          _buildSubHeader(sizeConfig),
          _buildSourceCodeIcon(sizeConfig),
          Expanded(child: _buildContent(context, sizeConfig))
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, SizeConfig sizeConfig) {
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
          return _buildErrorInfo();
        }

        return CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _buildLabel(sizeConfig, 'Winners:'),
            ),
            _buildWinners(state.winners),
            SliverToBoxAdapter(
              child: _buildLabel(sizeConfig, 'Others:'),
            ),
            _buildOthers(sizeConfig, state.others),
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

  Widget _buildBottomBar(SizeConfig sizeConfig) {
    return Container(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildLabel(
            sizeConfig,
            'Built with',
          ),
          Icon(
            CustomIcons.heart,
            size: sizeConfig.dynamicScaleSize(14),
            color: Colors.red,
          ),
          Flexible(
            child: _buildLabel(
              sizeConfig,
              'and Flutter (mobile, web and desktop) by Julio Bitencourt',
            ),
          )
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

  Widget _buildHeader(SizeConfig sizeConfig) {
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
                fontSize: sizeConfig.dynamicScaleSize(40),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeader(SizeConfig sizeConfig) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            'of the main cross platform mobile techs',
            style: TextStyle(
              color: Colors.white,
              fontSize: sizeConfig.dynamicScaleSize(20),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildSourceCodeIcon(SizeConfig sizeConfig) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWellPlatformAware(
            onTap: () {
              launchURL('https://github.com/JHBitencourt/stars_race');
            },
            child: Icon(
              CustomIcons.github,
              size: sizeConfig.dynamicScaleSize(26),
              color: Colors.white,
            ),
          ),
        ],
      ),
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

  Widget _buildOthers(SizeConfig sizeConfig, List<RepoInfo> others) {
    final cards = <CardRepo>[];
    for (var i = 0; i < others.length; i++) {
      cards.add(
        CardRepo(
          position: i + 4,
          repoInfo: others[i],
        ),
      );
    }

    return SliverLayoutBuilder(
      builder: (BuildContext context, SliverConstraints constraints) {
        final boxConstraints = constraints.asBoxConstraints();
        final width = boxConstraints.maxWidth;

        final crossAxisCount = _crossAxisBasedOnWidth(width);

        double padding = 8;
        if (width > 816) {
          padding += (width - 816) / 2;
        }
        return SliverPadding(
          padding: EdgeInsets.only(left: padding, right: padding),
          sliver: SliverGrid(
            delegate: SliverChildListDelegate(cards),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: sizeConfig.dynamicScaleSize(4),
              mainAxisSpacing: sizeConfig.dynamicScaleSize(4),
              childAspectRatio: 1,
              crossAxisCount: crossAxisCount,
            ),
          ),
        );
      },
    );
  }

  int _crossAxisBasedOnWidth(double width) {
    if (width <= 360) return 2;
    if (width <= 560) return 3;
    if (width <= 760) return 4;
    return 5;
  }

  Widget _buildLabel(SizeConfig sizeConfig, String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.white,
          fontSize: sizeConfig.dynamicScaleSize(16),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildErrorInfo() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: 'Error sending the request..\n'),
            TextSpan(
                text: 'Seems like the Github API limit has been reached.\n'),
            TextSpan(
              text: 'See more.',
              style: TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchURL('https://developer.github.com/v3/#rate-limiting');
                },
            ),
          ],
        ),
      ),
    );
  }
}
