import 'package:flutter/material.dart';
import 'package:music_player_interaction/constants.dart';
import 'package:music_player_interaction/data/data.dart';
import 'package:music_player_interaction/models/provider_models.dart';
import 'package:music_player_interaction/pages/play_page/play_page_widgets.dart';
import 'package:provider/provider.dart';

class PlayPage extends StatefulWidget {
  const PlayPage({Key? key, required this.i}) : super(key: key);

  final int i;

  @override
  State<PlayPage> createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: kDelayAnimation), () {
      Provider.of<PlayPageModel>(context, listen: false).state = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BigContainer(),
          BackButtonPop(size: size),
          TvContainer(size: size),
          DiscPlayControls(i: widget.i),
        ],
      ),
    );
  }
}
class BigContainer extends StatelessWidget {
  const BigContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int state =  Provider.of<PlayPageModel>(context).state;
    var size = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      child: AnimatedContainer(
          onEnd: () {
            state = Provider.of<PlayPageModel>(context, listen: false)
                .state = 1;
          },
          height: state > -1 ? size.height : 0,
          width: size.width,
          duration: const Duration(milliseconds: 200),
          decoration: const BoxDecoration(
            color: Color(0xFF6a696b),
          )),
    );
  }
}

class DiscPlayControls extends StatelessWidget {
  const DiscPlayControls({Key? key, required this.i}) : super(key: key);

  final int i;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int state = Provider.of<PlayPageModel>(context).state;
    return Positioned(
        bottom: size.height * 0.15,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            AnimatedContainer(
              onEnd: () {
                state = Provider.of<PlayPageModel>(context, listen: false)
                    .state = 2;
              },
              height: state >= 1 ? size.height * 0.68 : 0.0,
              width: size.width * sizeContainer,
              duration: const Duration(milliseconds: kDelayAnimation),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.all(Radius.circular(kPaddingPlayPage)),
              ),
            ),
            AnimatedContainer(
              height: state >= 1 ? size.height * 0.7 : 0.0,
              width: size.width * 0.73,
              duration: const Duration(milliseconds: kDelayAnimation),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: const BorderRadius.all(
                    Radius.circular(kPaddingPlayPage)),
              ),
            ),
            AnimatedOpacity(
              opacity: state >= 2 ? 1 : 0,
              duration: const Duration(milliseconds: kDelayAnimation),
              onEnd: () {
                Provider.of<PlayPageModel>(context, listen: false).state = 3;
              },
              child: state >= 2
                  ? Column(
                children: [
                  Container(
                    width: size.width * sizeContainer,
                    height: size.height * 0.4,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.8),
                          spreadRadius: 1,
                          blurRadius: 25,
                          offset: const Offset(
                              0, 6), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          topRight:
                          Radius.circular(kPaddingPlayPage),
                          topLeft:
                          Radius.circular(kPaddingPlayPage)),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight:
                          Radius.circular(kPaddingPlayPage),
                          topLeft:
                          Radius.circular(kPaddingPlayPage)),
                      child: Image.asset(
                        songs[i].image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'The Weeknd - ${songs[i].name} (official) \n ${songs[i].by}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      width: size.width * sizeContainer,
                      child: Slider(
                          activeColor: Colors.grey,
                          value: 0.5,
                          onChanged: (i) {})),
                  SizedBox(
                    height: size.height * 0.1,
                    width: size.width * sizeContainer,
                    child: const MusicControl(),
                  )
                ],
              )
                  : Container(),
            )
          ],
        ));
  }
}
