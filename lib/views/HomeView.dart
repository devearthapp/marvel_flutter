import 'package:flutter/material.dart';
import 'package:marvel_flutter/models/CharacterModel.dart';
import 'package:marvel_flutter/models/ComicModel.dart';
import 'package:marvel_flutter/viewModels/CharacterViewModel.dart';
import 'package:marvel_flutter/viewModels/ComicViewModel.dart';
import 'package:marvel_flutter/widgets/GradientContainer.dart';
import 'package:marvel_flutter/widgets/SlideItem.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    onStart();
  }

  Future<void> onStart() async {
    // any init in here ?
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            GradientContainer(color: Colors.red, child: buildHomeView(context)),
      ),
    );
  }

  Widget buildHomeView(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 1000,
          ),
          child: Consumer2<ComicViewModel, CharacterViewModel>(
            builder: (context, comicViewModel, characterViewModel, child) =>
                Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: Center(
                    child: Text(
                      '  MARVEL  ',
                      style: TextStyle(
                          fontFamily: 'Marvel',
                          fontSize: 60,
                          color: Colors.white),
                    ),
                  ),
                ),
                comicViewModel.comicList == null ||
                        comicViewModel.isRequestPending
                    ? buildBusyIndicator()
                    : comicViewModel.isRequestError
                        ? buildReqError()
                        : buildComicList(context),
                characterViewModel.characterList == null ||
                        characterViewModel.isRequestPending
                    ? buildBusyIndicator()
                    : characterViewModel.isRequestError
                        ? buildReqError()
                        : buildCharacterList(context),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget buildBusyIndicator() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
          SizedBox(
            height: 20,
          ),
          Text('Please Wait...',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ))
        ]));
  }

  Widget buildReqError() {
    return Center(
        child: Text('Ooops...something went wrong',
            style: TextStyle(fontSize: 21, color: Colors.white)));
  }

  buildComicList(BuildContext context) {
    return Consumer<ComicViewModel>(
        builder: (context, comicViewModel, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 28.0),
                    child: Text(
                      '  Comics  ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'Marvel',
                          fontSize: 25,
                          color: Colors.white),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.7,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: comicViewModel.comicList == null
                            ? 0
                            : comicViewModel.comicList.length,
                        itemBuilder: (BuildContext context, int index) {
                          ComicResults comic = comicViewModel.comicList[index];

                          return Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: SlideItem(
                              img: comic.thumbnail.path +
                                  "/portrait_fantastic." +
                                  comic.thumbnail.extension,
                              title: comic.title,
                              creators: comic.creators.items.length > 0
                                  ? comic.creators.items[0].name
                                  : "not available",
                              price: comic.prices[0].price,
                            ),
                          );
                        },
                      ),
                    ))
              ],
            ));
  }

  buildCharacterList(BuildContext context) {
    return Consumer<CharacterViewModel>(
        builder: (context, characterViewModel, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 28.0),
                    child: Text(
                      '  Characters  ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: 'Marvel',
                          fontSize: 25,
                          color: Colors.white),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 1.7,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: characterViewModel.characterList == null
                            ? 0
                            : characterViewModel.characterList.length,
                        itemBuilder: (BuildContext context, int index) {
                          MarvelCharacter marvelCharacter =
                              characterViewModel.characterList[index];

                          return Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: SlideItem(
                              img: marvelCharacter.thumbnail.path +
                                  "/portrait_fantastic." +
                                  marvelCharacter.thumbnail.extension,
                              title: marvelCharacter.name,
                              creators: marvelCharacter.description.isNotEmpty
                                  ? marvelCharacter.description
                                  : "",
                              price: marvelCharacter.resourceUri,
                            ),
                          );
                        },
                      ),
                    ))
              ],
            ));
  }

  Future<void> refreshComicList(
      ComicViewModel comicViewModel, BuildContext context) {
    return comicViewModel.getLatestComics();
  }

  Future<void> refreshCharacterList(
      CharacterViewModel comicViewModel, BuildContext context) {
    return comicViewModel.getLatestCharacters();
  }
}
