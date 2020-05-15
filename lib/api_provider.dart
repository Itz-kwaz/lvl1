import 'dart:async';
import 'package:http/http.dart';
import 'package:lvl1/github_user.dart';
import 'dart:convert';


class ApiProvider{
final String url = 'https://api.github.com/users?language=flutter';




Future<List<GithubUser>> getData() async {
        List<GithubUser> users = new List();
        List data;
        Response response = await get(url);
        data = jsonDecode(response.body);
        for(int i = 0; i < data.length ; i++){
                final response = await get(data[i]["url"]);
                if (response.statusCode == 200) {
                        final jsonResponse = jsonDecode(response.body);
                        if (jsonResponse['name'] == null) {
                                jsonResponse['name'] = "No name";
                        }
                        if (jsonResponse['location'] == null) {
                                jsonResponse['location'] = "Lagos";
                        }
                        GithubUser user = new GithubUser.fromJson(jsonResponse);
                        users.add(user);
                } else {
                        throw Exception("Failed to load post");
                }
        }
        return users;
}


}