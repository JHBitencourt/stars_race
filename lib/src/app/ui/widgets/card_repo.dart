import 'package:flutter/material.dart';
import 'package:stars_race/src/app/model/bean/repo_info.dart';
import 'package:stars_race/src/app/model/core/utils/colors.dart';
import 'package:stars_race/src/app/ui/widgets/custom_dialog.dart';
import 'package:stars_race/src/app/ui/widgets/utils/custom_icons.dart';
import 'package:stars_race/src/app/ui/widgets/utils/size_config.dart';
import 'package:stars_race/src/app/ui/widgets/utils/url_utils.dart';
import 'package:stars_race/src/app/ui/widgets/ink_well_platform_aware.dart';

class CardRepo extends StatelessWidget {
  final int position;
  final RepoInfo repoInfo;
  final BoxConstraints constraints;

  const CardRepo({this.position, this.repoInfo, this.constraints});

  @override
  Widget build(BuildContext context) {
    final sizeConfig = SizeConfig.of(context);

    Widget content = Stack(
      children: <Widget>[
        _buildContent(sizeConfig),
        _buildPosition(sizeConfig),
      ],
    );

    if (constraints != null) {
      content = ConstrainedBox(
        constraints: constraints,
        child: content,
      );
    }

    return InkWell(
      onTap: () {
        _showDialog(context, sizeConfig);
      },
      child: Card(
        child: content,
      ),
    );
  }

  Widget _buildPosition(SizeConfig sizeConfig) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '$position',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: sizeConfig.dynamicScaleSize(20),
          color: Colors.green,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  Widget _buildContent(SizeConfig sizeConfig) {
    return Center(
      child: Column(
        children: <Widget>[
          _buildImageRepo(),
          _buildStargazers(sizeConfig),
        ],
      ),
    );
  }

  Widget _buildImageRepo([int flex = 1]) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/imgs/${repoInfo.name}.png'),
      ),
    );
  }

  Widget _buildStargazers(SizeConfig sizeConfig) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.star,
          color: _colorByPosition(),
          size: sizeConfig.dynamicScaleSize(26),
        ),
        _buildTextDefault(sizeConfig, '${repoInfo.stargazers}',
            sizeConfig.dynamicScaleSize(26)),
      ],
    );
  }

  Color _colorByPosition() {
    switch (position) {
      case 1:
        return gold;
      case 2:
        return silver;
      case 3:
        return bronze;
      default:
        return Colors.black;
    }
  }

  void _showDialog(BuildContext context, SizeConfig sizeConfig) {
    final header = Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildImageRepo(2),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: _buildTextDefault(sizeConfig, '/${repoInfo.name}'),
              ),
              SizedBox(height: 8),
              Flexible(
                child: _buildTextDefault(sizeConfig, '${repoInfo.language}'),
              ),
              SizedBox(height: 8),
              Flexible(child: _buildStargazers(sizeConfig))
            ],
          ),
        )
      ],
    );

    final description = Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: _buildTextDefault(sizeConfig, '${repoInfo.description}'),
          ),
          SizedBox(height: 8)
        ],
      ),
    );

    final iconsLauncher = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (repoInfo.homepage.isNotEmpty)
          _buildIconLauncher(sizeConfig, CustomIcons.home, repoInfo.homepage),
        if (repoInfo.homepage.isNotEmpty) SizedBox(width: 20),
        _buildIconLauncher(sizeConfig, CustomIcons.github, repoInfo.url),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                header,
                description,
                iconsLauncher,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextDefault(SizeConfig sizeConfig, String text,
      [double fontSize = 16]) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: sizeConfig.dynamicScaleSize(fontSize)),
    );
  }

  Widget _buildIconLauncher(
      SizeConfig sizeConfig, IconData iconData, String url) {
    return InkWellPlatformAware(
      onTap: () {
        launchURL(url);
      },
      child: Icon(
        iconData,
        size: sizeConfig.dynamicScaleSize(26),
      ),
    );
  }
}
