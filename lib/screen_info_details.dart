import 'package:flutter/material.dart';
import 'package:nurture/styling.dart';

class InformationDetails extends StatelessWidget {
  final String image;
  final String info;
  final String author;

  InformationDetails({this.image, this.info, this.author});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("More")),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 0, right: 30, top: 15.0),
            height: MediaQuery.of(context).size.height * 0.3,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0)),
                child: Image.network(
                  "$image",
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
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes
                                  : null),
                        ),
                      ),
                    );
                  },
                )),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
            child: Row(
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
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Text(info,
                textScaleFactor: 1.2,
                maxLines: 4,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: 11.5,
                )),
          ),
        ],
      ),
    );
  }
}
