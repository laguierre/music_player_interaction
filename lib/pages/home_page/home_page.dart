import 'package:flutter/material.dart';
import 'package:music_player_interaction/constants.dart';
import 'package:music_player_interaction/data/data.dart';
import 'package:music_player_interaction/models/provider_models.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizeDisc = size.height * 0.16;
    bool trigger = Provider.of<GridChangeModel>(context).trigger;
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        TopLabel(onPressed: () {
          trigger = !trigger;
          Provider.of<GridChangeModel>(context, listen: false).trigger = trigger;
        },),
        Expanded(
          child: GridView.count(
            mainAxisSpacing: 30,
            crossAxisSpacing: 20,
            padding: const EdgeInsets.fromLTRB(kPrimaryPadding, 30, kPrimaryPadding, 30),
            physics: const BouncingScrollPhysics(),
            crossAxisCount: trigger? 1 : 2,
            childAspectRatio: trigger ? 2: 0.92,
            children: songs
                .map((e) => DiscContainer(
                      sizeDisc: sizeDisc,
                      i: e.index,
                    ))
                .toList(), //getSongs().map((e) => SongItem(e,count,delayAimation)).toList(),
          ),
        )
      ],
    )));
  }
}

class DiscContainer extends StatelessWidget {
  const DiscContainer({
    Key? key,
    required this.sizeDisc,
    required this.i,
  }) : super(key: key);

  final double sizeDisc;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeDisc,
      width: sizeDisc,
      color: Colors.red.withOpacity(0.5),
      child: Stack(
        children: [
          Align(
            alignment: const Alignment(1, -1),
            child: SizedBox(
              height: sizeDisc,
              child: Image.asset('lib/assets/images/cd.png'),
            ),
          ),
          Container(
              height: sizeDisc,
              width: sizeDisc,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset(songs[i].image)),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(songs[i].name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              Text(songs[i].by,
                  style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ],
          )
        ],
      ),
    );
  }
}

class TopLabel extends StatelessWidget {
  const TopLabel({
    Key? key, required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(kPrimaryPadding, kPrimaryPadding, kPrimaryPadding,0),
        child: Row(
          children: [
            const Text('Albums',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Spacer(),
            IconButton(
                onPressed: onPressed,
                icon: Image.asset('lib/assets/images/icon.png')),
          ],
        ));
  }
}
