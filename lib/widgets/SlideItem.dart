import 'package:flutter/material.dart';

class SlideItem extends StatefulWidget {
  final String img;
  final String title;
  final String creators;
  final String price;

  SlideItem({
    Key key,
    @required this.img,
    @required this.title,
    @required this.creators,
    @required this.price,
  }) : super(key: key);

  @override
  _SlideItemState createState() => _SlideItemState();
}

class _SlideItemState extends State<SlideItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        height: MediaQuery.of(context).size.height / 1.5,
        width: MediaQuery.of(context).size.width / 2.5,
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 3.0,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 3.7,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      child: Image.network(
                        "${widget.img}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    right: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.star,
                              color: Colors.yellow[600],
                              size: 10,
                            ),
                            Text(
                              " ${widget.price} ",
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6.0,
                    left: 6.0,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0)),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Text(
                          " OPEN ",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "${widget.title}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w800,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              SizedBox(height: 7.0),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "${widget.creators}",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}