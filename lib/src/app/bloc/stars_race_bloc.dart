import 'package:rxdart/rxdart.dart';
import 'package:stars_race/src/app/model/bean/repo_info.dart';
import 'package:stars_race/src/app/model/data/api/repo_api.dart';

import 'provider/bloc_provider.dart';

const techs = const {
  'flutter': 'flutter',
  'facebook': 'react-native',
  'JetBrains': 'kotlin-native',
  'xamarin': 'Xamarin.Forms',
  'ionic-team': 'ionic',
  'GeekyAnts': 'vue-native-core',
  'appcelerator': 'titanium_mobile',
  'coronalabs': 'corona',
  'NativeScript': 'NativeScript',
};

class StarsRaceBloc extends BlocBase {
  final repoApi = RepoApi();

  final _reposController =
      BehaviorSubject<StarsRaceState>.seeded(StarsRaceState.loading());

  Stream<StarsRaceState> get reposStream => _reposController.stream;

  void fetchRepos() async {
    try {
      _reposController?.sink?.add(StarsRaceState.loading());

      final repoInfos = <RepoInfo>[];
      for (var entry in techs.entries) {
        final repoInfo = await repoApi.getRepoInfo(entry.key, entry.value);
        repoInfos.add(repoInfo);
      }

      repoInfos.sort((a, b) => b.stargazers.compareTo(a.stargazers));
      _reposController?.sink?.add(
        StarsRaceState.loaded(
          winners: repoInfos.take(3).toList(),
          others: repoInfos.skip(3).toList(),
        ),
      );
    } catch (e, s) {
      print(s);
      _reposController?.sink?.add(StarsRaceState.error());
    }
  }

  @override
  void dispose() {
    _reposController.close();
  }
}

class StarsRaceState {
  final bool isLoading;
  final bool hasError;
  final List<RepoInfo> winners;
  final List<RepoInfo> others;

  StarsRaceState({
    this.isLoading = false,
    this.hasError = false,
    this.winners,
    this.others,
  });

  factory StarsRaceState.loading() {
    return StarsRaceState(isLoading: true);
  }

  factory StarsRaceState.error() {
    return StarsRaceState(hasError: true);
  }

  factory StarsRaceState.loaded(
      {List<RepoInfo> winners, List<RepoInfo> others}) {
    return StarsRaceState(
      winners: winners,
      others: others,
    );
  }
}
