import 'package:epic_free/fetchData.dart';
import 'package:epic_free/gameData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLive = true;
  List<GameData> live = [];
  List<GameData> gameData = [];
  List<ImageView> gameImages = [
    ImageView(imageUrl: "assets/images/privew.jpg")
  ];
  Future<void> getDataFromAPI(BuildContext context) async {
    var response = await fetchGameData();
    // response.forEach((i, j) {
    //   print(i);
    //   print(j);
    // });
    if(response['isSuccess'] == true){
      print(response["ApplicationList"]["freeGames"]);
    var responseList = response["ApplicationList"]["freeGames"]["upcoming"];
    for(var item in responseList){
        List<ImageView> tmp =[];
        for(var img in item["keyImages"]){
          tmp.add(ImageView(imageUrl: img['url']));
        }
        gameData.add(GameData(avtarImage: item["keyImages"][0]["url"] , disc: item["description"], images: tmp, title: item["title"]));
    }
    var responseList2 = response["ApplicationList"]["freeGames"]["upcoming"];
    for(var item in responseList2){
        List<ImageView> tmp =[];
        for(var img in item["keyImages"]){
          tmp.add(ImageView(imageUrl: img['url']));
        }
        live.add(GameData(avtarImage: item["keyImages"][0]["url"] , disc: item["description"], images: tmp, title: item["title"]));
    }
    }
  }

  @override
  void initState() {
    // TODO: implement initState

      getDataFromAPI(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child:  !isLive? GameCardView(
                        // avtarLink: "assets/images/1422000.jpg",
                        avtarLink: gameData[index].avtarImage,
                        discription: gameData[index].disc,
                        // discription:
                        //     "A mix between Portal, Zelda and Metroid. Explore, solve puzzles, beat up monsters, find secret upgrades and new abilities that help you reach new places. Playtime 12-25h.",
                        title: gameData[index].title,
                        isUpcoming: true,
                        relatedImages: gameData[index].images,
                      ):GameCardView(
                        // avtarLink: "assets/images/1422000.jpg",
                        avtarLink: live[index].avtarImage,
                        discription: live[index].disc,
                        // discription:
                        //     "A mix between Portal, Zelda and Metroid. Explore, solve puzzles, beat up monsters, find secret upgrades and new abilities that help you reach new places. Playtime 12-25h.",
                        title: live[index].title,
                        isUpcoming: false,
                        relatedImages: live[index].images,
                      )
                    );
                  },
                  itemCount: !isLive? gameData.length:live.length,
                ),
              ),
              Column(
                children: [
                  Spacer(),
                  Center(
                    child: ElevatedButton(onPressed: () {
                      setState(() {
                        isLive = !isLive;
                      });
                    }, child: SizedBox(height: 48,width: 250, child: Center(child: Text( !isLive?"Live":"Upcoming",style: TextStyle(fontSize: 24),)))),
                  ),
                  SizedBox(height: 24,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameCardView extends StatefulWidget {
  String discription;
  bool isUpcoming;
  String title;
  String avtarLink;
  List<ImageView> relatedImages;
  GameCardView(
      {required this.isUpcoming,
      required this.title,
      required this.discription,
      required this.avtarLink,
      required this.relatedImages,
      super.key});

  @override
  State<GameCardView> createState() => _GameCardViewState();
}

class _GameCardViewState extends State<GameCardView> {
  @override
  Widget build(BuildContext context) {
    var discription = widget.discription;
    var display = MediaQuery.of(context).size;
    return Container(
      // height: 250,
      width: 200,
      decoration: BoxDecoration(
        // color: Color.fromARGB(255, 194, 72, 63),
        color:
            widget.isUpcoming ? Colors.green : Color.fromARGB(255, 44, 44, 44),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 16,
          ),
          Text(
            widget.isUpcoming ? "UPCOMING" : "LIVE",
            style: GoogleFonts.ubuntu(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              wordSpacing: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.avtarLink),
                ),
                SizedBox(
                  width: 12,
                ),
                Flexible(
                  child: Text(widget.title,
                      style: GoogleFonts.openSans(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
            ),
            child: Text(
              discription.length < 60
                  ? discription
                  : discription.substring(0, 60) + '...',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: widget.relatedImages,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ImageView extends StatefulWidget {
  String imageUrl;
  ImageView({required this.imageUrl, super.key});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.fitWidth,
        height: MediaQuery.of(context).size.height * (1080 / 1920),
        width: MediaQuery.of(context).size.width * (1920 / 1080),
        scale: 10,
      ),
    );
  }
}
