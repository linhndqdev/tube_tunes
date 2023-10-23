import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tube_tunes/res/assets.dart';
import 'package:tube_tunes/res/styles.dart';
import 'package:tube_tunes/util/navigation/navigation_service.dart';
import 'package:tube_tunes/util/navigation/routes.dart';
import 'package:tube_tunes/util/youtube/src/model/youtube_video.dart';
import 'package:tube_tunes/util/youtube/youtube_api.dart';

class SearchScreen extends StatefulWidget {
  final bool isCurrent;
  const SearchScreen({Key? key, required this.isCurrent}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static String key = "AIzaSyDU-YwMjCkEt47IickWS5SBVc9WnxcJDI8";

  YoutubeAPI youtube = YoutubeAPI(key);
  List<YouTubeVideo> videoResult = [];

  List<YouTubeVideo> trendingAlbums = [];

  // List<AlbumModel> models = [
  //   AlbumModel(
  //     id: 1,
  //     image: "assets/png/home/home1.png",
  //     title: 'Satisfied',
  //     artist: 'Mercy Chinwo',
  //     year: '2021',
  //     download: 1,
  //     plays: 2,
  //     songs: 2,
  //     genre: "",
  //     like: 2,
  //   ),
  //   AlbumModel(
  //     id: 2,
  //     image: "assets/png/home/home2.png",
  //     title: 'The Cross: My Gaze',
  //     artist: 'Mercy Chinwo',
  //     year: '2021',
  //     download: 1,
  //     plays: 2,
  //     songs: 2,
  //     genre: "",
  //     like: 2,
  //   ),
  //   AlbumModel(
  //     id: 3,
  //     image: "assets/png/home/home3.png",
  //     title: 'Yahweh',
  //     artist: 'Mercy Chinwo',
  //     year: '2021',
  //     download: 1,
  //     plays: 2,
  //     songs: 2,
  //     genre: "",
  //     like: 2,
  //   ),
  //   AlbumModel(
  //     id: 4,
  //     image: "assets/png/home/home4.png",
  //     title: 'Onyedikagi',
  //     artist: 'Mercy Chinwo',
  //     year: '2021',
  //     download: 1,
  //     plays: 2,
  //     songs: 2,
  //     genre: "",
  //     like: 2,
  //   ),
  //   AlbumModel(
  //     id: 5,
  //     image: "assets/png/home/home5.png",
  //     title: 'Igwe',
  //     artist: 'Mercy Chinwo',
  //     year: '2021',
  //     download: 1,
  //     plays: 2,
  //     songs: 2,
  //     genre: "",
  //     like: 2,
  //   ),
  //   AlbumModel(
  //     id: 6,
  //     image: "assets/png/home/home6.png",
  //     title: 'Eze',
  //     artist: 'Mercy Chinwo',
  //     year: '2021',
  //     download: 1,
  //     plays: 2,
  //     songs: 2,
  //     genre: "",
  //     like: 2,
  //   )
  // ];

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: !widget.isCurrent,
      child: Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   // leading: GestureDetector(
        //   //   onTap: () {
        //   //     GetIt.I
        //   //         .get<NavigationService>()
        //   //         .clearAllTo(routeName: Routes.home);
        //   //   },
        //   //   child: SvgPicture.asset(
        //   //     Assets.BACK,
        //   //     height: 24,
        //   //     width: 24,
        //   //     color: const Color(0xffffffff),
        //   //     // fit: BoxFit.fill,
        //   //   ),
        //   // ),
        //   automaticallyImplyLeading: true,
        //   backgroundColor: Colors.black,
        //   elevation: 0,
        // ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 40.h,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: TextFormField(
                  readOnly: true, //false
                  autofocus: false,
                  // style: ,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 8.h),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: SvgPicture.asset(
                        Assets.SEARCH,
                        height: 24.w,
                        width: 24.w,
                        color: const Color(0xb341416E),
                        // fit: BoxFit.fill,
                      ),
                    ),
                    // prefixIconConstraints: BoxConstraints(
                    //     minHeight: 24.w, maxHeight: 24.w, maxWidth: 35.w),
                    suffixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: SvgPicture.asset(
                        Assets.CLOSE,
                        height: 24.w,
                        width: 24.w,
                        color: Colors.black,
                        // fit: BoxFit.fill,
                      ),
                    ),
                    hintText: "Search",
                    // hintStyle: textFieldPlaceholderTextStyle(context),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: AppStyles.focusedTransparentBorder,
                    disabledBorder: AppStyles.focusedTransparentBorder,
                    enabledBorder: AppStyles.focusedTransparentBorder,
                    errorBorder: AppStyles.focusedTransparentBorder,
                    focusedErrorBorder: AppStyles.focusedTransparentBorder,
                    errorStyle: errorTextStyle(context),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onSaved: (val) {},
                  onEditingComplete: () {},
                  onChanged: (val) {},
                  // validator: (val) {},
                  onTap: () {},
                ),
              ),
              SizedBox(height: 25.h),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(left: 22.w, right: 23.w),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemBuilder: (c, i) {
                    return InkWell(
                      onTap: () {
                        GetIt.I.get<NavigationService>().to(
                            routeName: Routes.playingNow,
                            arguments: trendingAlbums[i]);
                      },
                      child: SizedBox(
                        height: 48.h,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: SizedBox(
                                width: 85.r,
                                height: 85.r,
                                child: Image.network(
                                  trendingAlbums[i].thumbnail.high.url ?? '',
                                  fit: BoxFit.cover,
                                  width: 85.r,
                                  height: 85.r,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 12),
                              width: MediaQuery.of(context).size.width - 140.r,
                              child: Text(
                                trendingAlbums[i].title,
                                style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                maxLines: 3,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (c, i) {
                    return Container(
                      color: Colors.white.withOpacity(0.5),
                      height: 1,
                      margin: EdgeInsets.symmetric(vertical: 12.h),
                    );
                  },
                  itemCount: trendingAlbums.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
