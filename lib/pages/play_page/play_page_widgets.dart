import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player_interaction/constants.dart';
import 'package:music_player_interaction/models/provider_models.dart';
import 'package:provider/provider.dart';


class TvContainer extends StatelessWidget {
  const TvContainer({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    int state = Provider.of<PlayPageModel>(context).state;
    return Positioned(
        bottom: 0,
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: const Duration(milliseconds: kDelayAnimation),
          height: state >= 3 ? size.height * 0.065 : size.height * 0.015,
          width: size.width * 0.2,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: kDelayAnimation),
            opacity: state >= 3 ? 1.0 : 0.0,
            child: const Icon(
              Icons.live_tv_sharp,
              size: 30,
            ),
          ),
        ));
  }
}

class BackButtonPop extends StatelessWidget {
  const BackButtonPop({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 20,
        top: size.height * 0.08,
        child: InkWell(
          onTap: () {
            Provider.of<GridChangeModel>(context, listen: false).DiscAppear();
            Provider.of<PlayPageModel>(context, listen: false).state = -1;
            Navigator.pop(context);
          },
          child: Row(
            children: const [
              Icon(
                CupertinoIcons.back,
                color: Colors.white,
                size: 26,
              ),
              SizedBox(width: 10),
              Text(
                'Back',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ));
  }
}

class MusicControl extends StatelessWidget {
  const MusicControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Icon(CupertinoIcons.shuffle, color: Colors.grey),
        CircularIconButton(icon: CupertinoIcons.backward_fill, radius: 45),
        CircularIconButton(icon: CupertinoIcons.play_arrow_solid, radius: 55),
        CircularIconButton(icon: CupertinoIcons.forward_fill, radius: 45),
        Icon(CupertinoIcons.volume_up, color: Colors.grey),
      ],
    );
  }
}

class CircularIconButton extends StatelessWidget {
  const CircularIconButton(
      {Key? key,
        required this.radius,
        required this.icon,
        this.colorIcon = Colors.brown})
      : super(key: key);
  final double radius;
  final IconData icon;
  final Color colorIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: Icon(icon, color: colorIcon),
    );
  }
}
