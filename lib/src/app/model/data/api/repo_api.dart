
import 'package:stars_race/src/app/model/bean/repo_info.dart';

import 'base_api.dart';

class RepoApi extends BaseApi {
  Future<RepoInfo> getRepoInfo(String companyName, String repoName) async {
    final url = '$baseUrl$companyName/$repoName';
    final responseJson = await getPublic(url);
    return RepoInfo.fromJson(responseJson);
  }
}
