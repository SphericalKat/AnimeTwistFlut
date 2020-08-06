import 'package:flutter/material.dart';

import '../../models/EpisodeModel.dart';

import '../watch_page/WatchPage.dart';
import '../../utils/CryptoUtils.dart';

import '../../secrets.dart';

import '../watch_page/WatchPage.dart';
import '../../models/TwistModel.dart';

class EpisodesCard extends StatelessWidget {
  final List<EpisodeModel> episodes;
  final TwistModel twistModel;

  EpisodesCard({@required this.episodes, @required this.twistModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Builder(
          builder: (context) {
            List<Widget> tiles = [];

            for (int i = 0; i < episodes.length; i++) {
              tiles.add(
                Container(
                  width: MediaQuery.of(context).size.height * 0.16,
                  child: OutlineButton(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                    highlightedBorderColor: Theme.of(context).accentColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 400),
                          pageBuilder: (context, anim, secondAnim) => WatchPage(
                            episodeModel: episodes.elementAt(i),
                            episodes: episodes,
                            twistModel: twistModel,
                          ),
                          transitionsBuilder:
                              (context, anim, secondAnim, child) {
                            var tween = Tween(
                              begin: Offset(1.0, 0.0),
                              end: Offset.zero,
                            );
                            var curvedAnimation = CurvedAnimation(
                              parent: anim,
                              curve: Curves.ease,
                            );
                            return SlideTransition(
                              position: tween.animate(curvedAnimation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Text(
                      episodes.elementAt(i).number.toString(),
                      style: TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                ),
              );
            }
            return Padding(
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 15.0,
                left: 15.0,
                right: 15.0,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                  // minHeight: MediaQuery.of(context).size.height * 0.15,
                ),
                child: CustomScrollView(
                  controller: ScrollController(
                    initialScrollOffset: 0.0,
                  ),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: 20.0,
                        ),
                        child: Text(
                          "Episodes!",
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width * 0.01 ~/ 1.25,
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                        childAspectRatio: 2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return tiles[index];
                        },
                        childCount: tiles.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}