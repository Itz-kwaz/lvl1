import 'package:lvl1/repository.dart';
import 'package:lvl1/github_user.dart';
import 'package:rxdart/rxdart.dart';

class UsersBloc {
  final _repository = Repository();
  final _usersfetcher = PublishSubject<List<GithubUser>>();

  Observable<List<GithubUser>> get allMovies => _usersfetcher.stream;

  fetchAllUsers() async {
    List<GithubUser> githubUser = await _repository.fetchUsers();
    _usersfetcher.sink.add(githubUser);
  }

  dispose() {
    _usersfetcher.close();
  }
}

final bloc = UsersBloc();