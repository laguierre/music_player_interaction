import 'package:flutter/material.dart';
import 'package:music_player_interaction/constants.dart';
import 'package:music_player_interaction/data/data.dart';
import 'package:music_player_interaction/models/provider_models.dart';
import 'package:music_player_interaction/pages/home_page/home_page_widgets.dart';
import 'package:music_player_interaction/pages/play_page/play_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 5 * kDelayAnimation), () {
      Provider.of<GridChangeModel>(context, listen: false).triggerROT = true;
      Provider.of<GridChangeModel>(context, listen: false).state = 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int state = Provider.of<GridChangeModel>(context).state;
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        TopLabel(
          onPressed: () {
            if (state == 1) {
              Provider.of<GridChangeModel>(context, listen: false).triggerROT =
                  false;
              state = Provider.of<GridChangeModel>(context, listen: false)
                  .state = 0;
              Future.delayed(const Duration(milliseconds: 2 * kDelayAnimation),
                  () {
                state = Provider.of<GridChangeModel>(context, listen: false)
                    .state = 3;
              });
            }
            if (state == 3) {
              Provider.of<GridChangeModel>(context, listen: false).triggerROT =
                  true;
              state = Provider.of<GridChangeModel>(context, listen: false)
                  .state = 2;
              Future.delayed(const Duration(milliseconds: 2 * kDelayAnimation),
                  () {
                state = Provider.of<GridChangeModel>(context, listen: false)
                    .state = 1;
              });
            }
          },
        ),
        Expanded(
          child: GridView.count(
            mainAxisSpacing: 30,
            crossAxisSpacing: 20,
            padding: const EdgeInsets.fromLTRB(
                kPrimaryPadding, 30, kPrimaryPadding, 30),
            physics: const BouncingScrollPhysics(),
            crossAxisCount: state == 3 ? 1 : 2,
            childAspectRatio: state == 3 ? 1.5 : 0.92,
            children: songs
                .map((e) => DiscContainer(
                      sizeDisc:
                          state == 3 ? size.height * 0.31 : size.height * 0.16,
                      i: e.index,
                      onTap: () {
                        Provider.of<PlayPageModel>(context, listen: false)
                            .state = -1;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayPage(
                                    i: e.index,
                                  )),
                        );
                      },
                    ))
                .toList(),
          ),
        )
      ],
    ));
  }
}
