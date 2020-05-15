
import 'package:lvl1/github_user.dart';
import 'api_provider.dart';


class Repository{

  ApiProvider provider = ApiProvider();
  Future<List<GithubUser>> fetchUsers (){
    return provider.getData();
  }
}