import 'package:flutter/material.dart';

import 'app/bloc/provider/bloc_provider.dart';
import 'app/bloc/stars_race_bloc.dart';
import 'app/ui/pages/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StarsRaceBloc>(
      bloc: StarsRaceBloc(),
      child: MaterialApp(
        title: 'Stars Race',
        theme:
            ThemeData(primarySwatch: Colors.blue, fontFamily: 'MaxwellRegular'),
        onGenerateRoute: _routes,
      ),
    );
  }

  Route _routes(RouteSettings settings) {
    if (settings.isInitialRoute) {
      return MaterialPageRoute(
        builder: (context) {
          final bloc = BlocProvider.of<StarsRaceBloc>(context);
          bloc.fetchRepos();

          return HomePage();
        },
      );
    }
  }
}
