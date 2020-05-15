class GithubUser{

  String name;
  String avatarUrl;
  String location;
  String htmlUrl;

  GithubUser({this.name,this.location,this.avatarUrl,this.htmlUrl});



  factory
      GithubUser.fromJson(Map<String,dynamic> parsedJson){
    return GithubUser(
        name: parsedJson["name"],
        location: parsedJson["location"],
        avatarUrl: parsedJson["avatar_url"],
        htmlUrl: parsedJson[ "html_url"]
    );
  }


}