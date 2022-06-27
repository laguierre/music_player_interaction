import 'package:flutter/material.dart';
import 'package:music_player_interaction/constants.dart';
import 'package:music_player_interaction/data/data.dart';
import 'package:music_player_interaction/models/provider_models.dart';
import 'package:provider/provider.dart';


class DiscContainer extends StatelessWidget {
  const DiscContainer({
    Key? key,
    required this.sizeDisc,
    required this.i,
    required this.onTap,
  }) : super(key: key);

  final double sizeDisc;
  final int i;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    bool triggerRot = Provider.of<GridChangeModel>(context).triggerROT;
    int state = Provider.of<GridChangeModel>(context).state;
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: kDelayAnimation),
            alignment: state == 1 || state == 3
                ? const Alignment(1, -1)
                : const Alignment(-1, -1),
            child: AnimatedRotation(
              duration: const Duration(milliseconds: kDelayAnimation),
              turns: triggerRot ? 1.5 : 0.75,
              child: SizedBox(
                height: sizeDisc,
                child: Image.asset('lib/assets/images/cd.png'),
              ),
            ),
          ),
          Container(
              width: sizeDisc,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 25,
                    offset: const Offset(10, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset(songs[i].image)),
          AnimatedPositioned(
            duration: const Duration(milliseconds: kDelayAnimation),
            bottom: state != 3 ? 2 : 25,
            left: state != 3 ? 2 : 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(songs[i].name,
                    style: TextStyle(
                        color: state != 3 ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
                const SizedBox(height: 5),
                Text(songs[i].by,
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontStyle:
                        state != 3 ? FontStyle.normal : FontStyle.italic)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TopLabel extends StatelessWidget {
  const TopLabel({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(
            kPrimaryPadding, kPrimaryPadding, kPrimaryPadding, 0),
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
