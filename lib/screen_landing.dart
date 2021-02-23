import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nurture/global_content.dart';
import 'package:nurture/screen_info_details.dart';
import 'package:nurture/styling.dart';
import 'package:telephony/telephony.dart';
import 'package:http/http.dart' as http;

Future fetchPosts() async {
  final response =
      await http.get("https://damgroup.000webhostapp.com/getNurturePosts.php");
  List posts = json.decode(response.body);
  posts.removeAt(0);
  return posts;
}

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenH = MediaQuery.of(context).size.height;
    double screenW = MediaQuery.of(context).size.width;

    GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light));
    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
        color: Colors.white,
        width: 120,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            children: [
              CircleAvatar(
                child: Icon(Icons.verified_user),
              ),
              Text(
                (globalUser.name != null &&
                        globalUser.name != "" &&
                        globalUser.name != " ")
                    ? globalUser.name.split(" ")[0] + "!"
                    : "",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: mainColor,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => _scaffoldKey.currentState.openDrawer(),
          child: Icon(
            Icons.menu,
            size: 24,
          ),
        ),
        title: Text(
          "About HIV",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.search, color: Colors.white, size: 24),
          ),
        ],
      ),
      body: FutureBuilder(
        future: fetchPosts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Widget> posts = List<Widget>();

              for (int i = 0; i < snapshot.data.length; i++) {
                posts.add(FeedCard(
                  imageUrl: snapshot.data[i]["image"],
                  information: snapshot.data[i]["info"],
                  author: snapshot.data[i]["author"],
                  views: snapshot.data[i]["views"],
                  postId: snapshot.data[i]["id"],
                ));
              }
              return ListView(
                  padding: EdgeInsets.only(top: screenH * 0.02),
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    /*Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 15),
                      child: Text("Popular",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                    ),*/
                    Container(
                      height: screenH * 0.415,
                      margin: EdgeInsets.only(bottom: 15.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          InfoBanner(
                              screenW: screenW,
                              screenH: screenH,
                              image: "intro.jpg"),
                          InfoBanner(
                              screenW: screenW,
                              screenH: screenH,
                              image: "symptoms.jpg"),
                          InfoBanner(
                              screenW: screenW,
                              screenH: screenH,
                              image: "transimission.jpg"),
                          InfoBanner(
                              screenW: screenW,
                              screenH: screenH,
                              image: "summary.jpg"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("More about HIV",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                    Column(
                      children: posts.map((post) => post).toList(),
                    ),
                  ]);
            } else {
              return Center(
                  child: Text(
                      "Failed To Fetch Posts! Check Your Internet Connection"));
            }
          } else {
            return Center(
              child: Theme(
                  data: ThemeData(accentColor: mainColor),
                  child: CircularProgressIndicator()),
            );
          }
        },
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          elevation: 3,
          child: Container(
            width: 45,
            height: 45,

            /*height: 90,*/
            decoration: BoxDecoration(
                color: mainColor, borderRadius: BorderRadius.circular(8.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Icon(Icons.comment, size: 24, color: Colors.white),
                ),*/
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: GestureDetector(
                      onTap: () => makePhoneCall(),
                      child: Icon(Icons.phone, size: 24, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoBanner extends StatelessWidget {
  const InfoBanner(
      {Key key, @required this.screenW, @required this.screenH, this.image})
      : super(key: key);

  final double screenW;
  final double screenH;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Card(
        elevation: 5.0,
        child: Container(
          width: screenW * 0.65,
          height: screenH * 0.39,
          child: Image.asset(
            "assets/$image",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

makePhoneCall() async {
  Telephony telephony = Telephony.instance;

  await telephony.dialPhoneNumber("0700376261");
}

class FeedCard extends StatelessWidget {
  const FeedCard(
      {Key key,
      this.imageUrl,
      this.information,
      this.author,
      this.views,
      this.postId})
      : super(key: key);

  final String imageUrl;
  final String information;
  final String author;
  final int views;
  final String postId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => InformationDetails(
                  image: imageUrl,
                  info: information,
                  author: author,
                )));

        final response = await http.post("$apiMainUrl/nurtureUpdateViews.php",
            body: {"views": (views + 1).toString(), "id": postId});

        print(response.body);
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.only(bottom: 0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: double.infinity,
                    child: Image.network(
                      "$imageUrl",
                      height: (MediaQuery.of(context).size.height * 0.3),
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: Theme(
                            data: ThemeData(
                              accentColor: mainColor,
                            ),
                            child: Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 1.9,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null),
                            ),
                          ),
                        );
                      },
                    )),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                        radius: 15.0,
                        child: Container(
                          width: 30,
                          height: 30,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.asset("assets/doctorfour.jpg",
                                fit: BoxFit.cover),
                          ),
                        )),
                    SizedBox(
                      width: 8.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(author,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12)),
                        Text("27m ago",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.black.withOpacity(0.6))),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(information,
                    textScaleFactor: 1.2,
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: 11.5,
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  color: Color.fromRGBO(232, 233, 234, 1),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(views.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: mainColor,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 2.0),
                              Text("Views",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.5)),
                            ],
                          ),
                        ),
                      ]),
                )
              ]),
        ),
      ),
    );
  }
}
