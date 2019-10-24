import 'package:flutter/material.dart';
import 'package:stars_race/src/app/model/bean/repo_info.dart';
import 'package:stars_race/src/app/model/core/utils/colors.dart';

class CardRepo extends StatelessWidget {
  final int position;
  final RepoInfo repoInfo;
  final BoxConstraints constraints;

  const CardRepo({this.position, this.repoInfo, this.constraints});

  @override
  Widget build(BuildContext context) {
    Widget content = Stack(
      children: <Widget>[
        _buildContent(),
        _buildPosition(),
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
        _showDialog(context);
      },
      child: Card(
        child: content,
      ),
    );
  }

  Widget _buildPosition() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '$position',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.green,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/imgs/${repoInfo.name}.png'),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.star,
                color: _colorByPosition(),
                size: 26,
              ),
              Text(
                '${repoInfo.stargazers}',
                style: TextStyle(fontSize: 26),
              ),
            ],
          )
        ],
      ),
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

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Hello'),
        );
      },
    );
  }
}
