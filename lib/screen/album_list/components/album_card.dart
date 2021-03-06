import 'package:favorite/model/picture.dart';
import 'package:favorite/util/date_util.dart';
import 'package:favorite/viewmodel/album_list/album_list_model.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({
    required this.itemIndex,
    required this.picture,
    required this.press,
  });

  final int itemIndex;
  final Picture picture;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    AlbumListModel model = Provider.of<AlbumListModel>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      height: 160,
      child: InkWell(
        onTap: press,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // カード背景
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven
                    ? Colors.orangeAccent[200]
                    : kSecondaryColor,
                boxShadow: [kDefaultShadow],
              ),
              child: Container(
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // 写真
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                height: 160,
                width: 190,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    picture.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(kPrimaryColor),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // 写真コメント
            model.isSideMenuOpen
                ? SizedBox()
                : Positioned(
                    bottom: 0,
                    right: 0,
                    child: SizedBox(
                      height: 136,
                      width: size.width - 190,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 40,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/calendar.svg",
                                      height: 18,
                                      width: 18,
                                    ),
                                    Text(
                                      DateUtil.dateFormat(
                                          picture.shotDate.toDate()),
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/camera.svg",
                                      height: 18,
                                      width: 18,
                                    ),
                                    Text(
                                      picture.title,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
