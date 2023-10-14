import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tube_tunes/res/assets.dart';
import 'package:youtube_api/youtube_api.dart';

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
    Future.delayed(Duration.zero,(){
      callAPI();

    });
  }

  Future<void> callAPI() async {
    // String query = "tokyo drift song";
    // videoResult = await youtube.search(
    //   query,
    //   order: 'relevance',
    //   videoDuration: 'any',
    // );
    List<YouTubeVideo> listVideo =
        await youtube.getTrends(regionCode: 'VN');
    trendingAlbums.addAll(listVideo);
    // videoResult = await youtube.nextPage();
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
            "DISCOVER",
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
              SizedBox(
                height: 38.h,
                width: double.infinity,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (c, i) {
                    return Container(
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: selectedCategoryIndex == i
                            ? const Color(0x66C4C4C4)
                            : Colors.black,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(70.r),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        categories[i],
                        style: GoogleFonts.workSans(
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                      padding: EdgeInsets.only(left: 21.w, right: 22.w),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 8.w,
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.h, bottom: 15.h),
                child: Text(
                  "Trending Albums",
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
                  height: 127.r,
                  width: double.infinity,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    scrollDirection: Axis.horizontal,
                    itemCount: trendingAlbums.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (c, i) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: SizedBox(
                          width: 127.r,
                          height: 127.r,
                          child: Image.network(
                            trendingAlbums[i].thumbnail.small.url ?? '',
                            fit: BoxFit.cover,
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
              Padding(
                padding: EdgeInsets.only(top: 41.h, bottom: 15.h),
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
              SizedBox(
                height: 127.r,
                width: double.infinity,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  scrollDirection: Axis.horizontal,
                  itemCount: trendingSongs.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (c, i) {
                    return Container(
                      width: 127.r,
                      height: 127.r,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        image: DecorationImage(
                          image: AssetImage(trendingSongs[i]),
                          fit: BoxFit.cover,
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
