import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tube_tunes/util/navigation/navigation_service.dart';
import 'package:tube_tunes/util/navigation/routes.dart';
import 'package:tube_tunes/util/youtube/src/model/youtube_video.dart';
import 'package:tube_tunes/util/youtube/youtube_api.dart';

class HomeScreen extends StatefulWidget {
  final bool isCurrent;

  const HomeScreen({Key? key, required this.isCurrent}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static String key = "AIzaSyDU-YwMjCkEt47IickWS5SBVc9WnxcJDI8";

  YoutubeAPI youtube = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      callAPI();
    });
  }

  Future<void> callAPI() async {
    List<YouTubeVideo> listVideo = await youtube.getTrends(regionCode: 'VN');
    trendingAlbums.addAll(listVideo);
    setState(() {});
  }

  List<String> categories = ["All", "Gospel", "Hip - Hop", "Latin"];
  List<YouTubeVideo> trendingAlbums = [];

  List<String> trendingSongs = [
    "assets/png/home/home4.png",
    "assets/png/home/home5.png",
    "assets/png/home/home6.png"
  ];

  int selectedCategoryIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !widget.isCurrent,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "TRENDING",
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 26.sp,
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: EdgeInsets.only(
              top: 8.h,
              left: 20.w,
            ),
            children: [
              Padding(
                padding: EdgeInsets.only(top: 18.h, bottom: 15.h),
                child: Text(
                  "Trending Songs",
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              if (trendingAlbums.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  height: 110.r,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    itemCount: trendingAlbums.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (c, i) {
                      return GestureDetector(
                        onTap: () {
                          GetIt.I.get<NavigationService>().to(
                              routeName: Routes.playingNow,
                              arguments: trendingAlbums[i]);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: SizedBox(
                            width: 200.r,
                            height: 110.r,
                            child: Image.network(
                              trendingAlbums[i].thumbnail.high.url ?? '',
                              fit: BoxFit.cover,
                              width: 200.r,
                              height: 110.r,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 17.w,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
