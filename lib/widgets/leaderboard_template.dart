import 'package:flutter/material.dart';
import '../constants/fonts.dart';

class LeaderboardTemplate extends StatefulWidget {
  final String place;
  final Color medalColor;
  final double radius;
  final double bottomMargin;
  final String username;
  final int record;

  const LeaderboardTemplate(
      {required this.username,
      required this.record,
      required this.place,
      required this.bottomMargin,
      required this.radius,
      required this.medalColor,
      Key? key})
      : super(key: key);

  @override
  State<LeaderboardTemplate> createState() => LeaderboardTemplateState();
}

class LeaderboardTemplateState extends State<LeaderboardTemplate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.bottomMargin),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: widget.radius,
                backgroundColor: Colors.grey,
              ),
              Positioned.fill(
                bottom: -15,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        color: widget.medalColor, shape: BoxShape.circle),
                    child: Center(
                        child: Text(
                      widget.place,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: beaufort,
                          fontSize: 22),
                    )),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              widget.username,
              style: const TextStyle(
                  fontSize: 14, fontFamily: gillSans, color: Colors.white),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 1,
            width: 41,
            color: Colors.white,
            child: null,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              '${widget.record}',
              style: const TextStyle(
                  fontSize: 14, fontFamily: gillSans, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
