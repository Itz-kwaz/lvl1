import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lvl1/users_bloc.dart';
import 'package:lvl1/github_user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    bloc.fetchAllUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: Text("Github Users"),
        ),
        body: StreamBuilder(
            stream: bloc.allMovies,
            builder: (context, AsyncSnapshot<List<GithubUser>> snapshot) {
              if (snapshot.hasData) {
                return buildList(snapshot);
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return Center(child: CircularProgressIndicator());
            }
        )

    );
  }



    @override
    void dispose() {
      bloc.dispose();
      super.dispose();
    }
  }

  Widget buildList(AsyncSnapshot<List<GithubUser>> snapshot) {
    return ListView.separated(
      itemCount: snapshot.data.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(width: 10.0),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: FadeInImage.memoryNetwork(
                            fit: BoxFit.cover,
                            width: 60.0,
                            height: 60.0,
                            placeholder: kTransparentImage,
                            image: snapshot.data[index].avatarUrl),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Flexible(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(snapshot.data[index].name,
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          snapshot.data[index].location,
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        )
                      ],
                    ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(40.0)),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              )),
                          height: 32.0,
                          child: GestureDetector(
                              onTap:() async {
                                  if (await canLaunch(snapshot.data[index].htmlUrl)) {
                                    await launch(snapshot.data[index].htmlUrl);
                                  } else {
                                    throw 'Could not launch Url';
                                  }

                              },
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 5.0),
                                    child: Text(
                                      "View Profile",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                        right: 10.0,
                                      ),
                                      child: Image(
                                        height: 15.0,
                                        image: AssetImage("assets/github.png"),
                                      ))
                                ],
                              )),
                        ),
                      ],
                    ),),
                  ],
                )
            )
          ],
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

