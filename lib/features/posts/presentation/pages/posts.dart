import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:probitas_app/features/posts/presentation/pages/add_post.dart';
import 'package:probitas_app/features/posts/presentation/pages/post_overview.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/utils/config.dart';
import '../../../../core/utils/customs/custom_appbar.dart';
import '../../../../core/utils/customs/custom_drawers.dart';
import '../../../../core/utils/navigation_service.dart';

class PostFeeds extends StatefulWidget {
  const PostFeeds({Key? key}) : super(key: key);

  @override
  State<PostFeeds> createState() => _PostFeedsState();
}

class _PostFeedsState extends State<PostFeeds> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();

  int currentIndex = 0;
  late PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 1));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      key: _key,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: CustomAppbar(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
      ),
      drawer: ProbitasDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            YMargin(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Posts",
                  style: Config.h3(context).copyWith(
                    color: isDarkMode
                        ? ProbitasColor.ProbitasTextPrimary
                        : ProbitasColor.ProbitasPrimary,
                    fontSize: 18,
                  ),
                ),
                ProbitasSmallButton(
                    title: "Add Posts",
                    onTap: () =>
                        NavigationService().navigateToScreen(AddPost()))
              ],
            ),
            YMargin(10),
            Expanded(
              child: Container(
                width: context.screenWidth(),
                child: LiquidPullToRefresh(
                  key: _refreshIndicatorKey,
                  onRefresh: _handleRefresh,
                  color: ProbitasColor.ProbitasSecondary,
                  backgroundColor: ProbitasColor.ProbitasTextPrimary,
                  animSpeedFactor: 5,
                  showChildOpacityTransition: true,
                  child: ListView.builder(
                    itemCount: 200,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          NavigationService().navigateToScreen(PostOverView());
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          width: context.screenWidth(),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            border: Border.all(
                              color:
                                  ProbitasColor.ProbitasTextPrimary.withOpacity(
                                      0.7),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15.0),
                                        ),
                                      ),
                                      child: Image(
                                        image: AssetImage(
                                            ImagesAsset.default_image),
                                      ),
                                    ),
                                    XMargin(10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Text(
                                            "Femi Ademola",
                                            style: Config.b2(context).copyWith(
                                                color: isDarkMode
                                                    ? ProbitasColor
                                                        .ProbitasTextPrimary
                                                    : ProbitasColor
                                                        .ProbitasPrimary),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            softWrap: false,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        YMargin(2.0),
                                        Text(
                                          "Microbiology",
                                          style: Config.b2(context).copyWith(
                                            color: isDarkMode
                                                ? ProbitasColor
                                                        .ProbitasTextPrimary
                                                    .withOpacity(0.5)
                                                : ProbitasColor
                                                    .ProbitasTextSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        PopupMenuButton(
                                          child: Icon(
                                            Icons.more_vert,
                                            color: isDarkMode
                                                ? ProbitasColor
                                                    .ProbitasTextPrimary
                                                : ProbitasColor.ProbitasPrimary,
                                          ),
                                          onSelected: (selectedValue) {
                                            print(selectedValue);
                                          },
                                          itemBuilder: (BuildContext ctx) => [
                                            PopupMenuItem(
                                                child: Text('Delete'),
                                                value: '1'),
                                          ],
                                        ),
                                        YMargin(2.0),
                                        Text(
                                          "Level 200",
                                          style: Config.b2(context).copyWith(
                                            color: isDarkMode
                                                ? ProbitasColor
                                                        .ProbitasTextPrimary
                                                    .withOpacity(0.5)
                                                : ProbitasColor
                                                    .ProbitasTextSecondary,
                                            fontSize: 14.0,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: isDarkMode
                                    ? ProbitasColor.ProbitasTextPrimary
                                        .withOpacity(0.5)
                                    : ProbitasColor.ProbitasTextSecondary,
                              ),
                              index % 3 == 0
                                  ? Stack(
                                      children: [
                                        Container(
                                          height: 160,
                                          width: context.screenWidth(),
                                          child: PageView.builder(
                                            controller: controller,
                                            physics: BouncingScrollPhysics(),
                                            onPageChanged: (int index) {
                                              setState(() {
                                                currentIndex = index;
                                                print(currentIndex);
                                              });
                                            },
                                            itemCount: 3,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                decoration: BoxDecoration(),
                                                child: Image(
                                                  image: AssetImage(
                                                    ImagesAsset.post_default,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        Positioned.fill(
                                          bottom: 8.0,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: SmoothPageIndicator(
                                              controller: controller,
                                              count: currentIndex + 1,
                                              effect: ScrollingDotsEffect(
                                                activeStrokeWidth: 2.6,
                                                activeDotScale: 1.3,
                                                maxVisibleDots: 5,
                                                radius: 8,
                                                spacing: 10,
                                                activeDotColor: ProbitasColor
                                                    .ProbitasSecondary,
                                                dotColor: ProbitasColor
                                                    .ProbitasTextPrimary,
                                                dotHeight: 12,
                                                dotWidth: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10.0),
                                child: ReadMoreText(
                                  "In Flutter, the overflow property of the Text, RichText, and DefaultTextStyle widgets specifies how overflowed content that is not displayed should be signaled to the user. It can be clipped, display an ellipsis (three dots), fade, or overflowing outside its parent widget.",
                                  style: Config.b3(context)
                                      .copyWith(fontSize: 14.0),
                                  trimLines: 3,
                                  delimiter: "...",
                                  colorClickableText: isDarkMode
                                      ? ProbitasColor.ProbitasTextPrimary
                                      : ProbitasColor.ProbitasPrimary,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: 'Read More',
                                  trimExpandedText: 'Close',
                                  lessStyle: Config.b2(context).copyWith(
                                      color: isDarkMode
                                          ? ProbitasColor.ProbitasTextPrimary
                                          : ProbitasColor.ProbitasSecondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0),
                                  moreStyle: Config.b2(context).copyWith(
                                    color: isDarkMode
                                        ? ProbitasColor.ProbitasTextPrimary
                                        : ProbitasColor.ProbitasSecondary,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              YMargin(2.0),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () {},
                                            child: index % 3 == 0
                                                ? SvgPicture.asset(
                                                    ImagesAsset.liked,
                                                    height: 18,
                                                    width: 18)
                                                : SvgPicture.asset(
                                                    ImagesAsset.notliked,
                                                    height: 18,
                                                    width: 18,
                                                    color: isDarkMode
                                                        ? ProbitasColor
                                                            .ProbitasTextPrimary
                                                        : ProbitasColor
                                                            .ProbitasTextSecondary,
                                                  )),
                                        XMargin(4),
                                        Text(
                                          "2",
                                          style: Config.b3(context).copyWith(
                                            color: isDarkMode
                                                ? ProbitasColor
                                                    .ProbitasTextPrimary
                                                : ProbitasColor
                                                    .ProbitasTextSecondary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    XMargin(20),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () {},
                                            child: SvgPicture.asset(
                                              ImagesAsset.chat,
                                              height: 18,
                                              width: 18,
                                              color: isDarkMode
                                                  ? ProbitasColor
                                                      .ProbitasTextPrimary
                                                  : ProbitasColor
                                                      .ProbitasPrimary,
                                            )),
                                        XMargin(4),
                                        Text(
                                          "20",
                                          style: Config.b3(context).copyWith(
                                              color: isDarkMode
                                                  ? ProbitasColor
                                                      .ProbitasTextPrimary
                                                  : ProbitasColor
                                                      .ProbitasTextSecondary),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        Share.share('Great Post');
                                      },
                                      tooltip: "Share",
                                      icon: SvgPicture.asset(ImagesAsset.share,
                                          color: isDarkMode
                                              ? ProbitasColor
                                                  .ProbitasTextPrimary
                                              : ProbitasColor.ProbitasPrimary,
                                          height: 18,
                                          width: 18),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProbitasSmallButton extends StatelessWidget {
  ProbitasSmallButton({
    Key? key,
    this.onTap,
    this.icon,
    required this.title,
  }) : super(key: key);
  final void Function()? onTap;
  final String? icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 35,
          width: 90,
          decoration: BoxDecoration(
              color: ProbitasColor.ProbitasSecondary,
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? SvgPicture.asset(icon!) : Container(),
              icon != null ? XMargin(2) : XMargin(0),
              Text(title,
                  style: Config.b3(context).copyWith(
                    color: ProbitasColor.ProbitasTextPrimary,
                  )),
            ],
          )),
        ),
      ),
    );
  }
}
