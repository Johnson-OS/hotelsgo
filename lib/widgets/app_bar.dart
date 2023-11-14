
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hotelsgo/common.dart';
import 'package:hotelsgo/res/assets.dart';

class MAppBar extends StatefulWidget {
  const MAppBar({super.key, required this.scrollController, required this.sortScreen, required this.filterScreen});
  final ScrollController scrollController;
  final Widget sortScreen;
  final Widget filterScreen;

  @override
  State<MAppBar> createState() => _MAppBarState();
}

class _MAppBarState extends State<MAppBar> {

  bool showFull = true;

  late Size _size;

  @override
  void initState() {
    widget.scrollController.addListener(() {

      if(widget.scrollController.offset >= 200 && showFull){
        setState(() {
          showFull = false;
        });
      }

      if(widget.scrollController.offset <= 200 && !showFull){
        setState(() {
          showFull = true;
        });
      }

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return AnimatedContainer(
      width: showFull?_size.width:_size.width*.95,
      height: 120.h,
      curve: Curves.easeInOut,
      duration: const Duration(seconds: 2),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: showFull?Theme.of(context).scaffoldBackgroundColor:Colors.white,
        borderRadius: showFull?null:BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: showFull?Colors.transparent:Colors.black.withOpacity(.5),
            blurRadius: 32.r,
            spreadRadius: 8.r
          )
        ]
      ),
      clipBehavior: Clip.antiAlias,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(45),

            Row(
              children: [
                AnimatedContainer(
                  width: showFull?0:_size.width*.95*.5 - 69.w,
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(seconds: 4),
                ),
                Image.asset(
                  Assets.logo,
                  width: 130.w,
                  height: 30.h,
                  fit: BoxFit.fill,
                ),
              ],
            ),

            Gap(10.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(20.w),
                InkWell(
                  onTap: (){
                    _showModal(context, widget.filterScreen);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.slider_horizontal_3,
                        color: theme.lightBlue,
                        size: 25.r,
                      ),
                      Gap(8.w),
                      Text(
                        'Filters',
                        style: theme.mediumTxt.copyWith(
                          color: theme.lightBlue,
                          fontSize: 16.sp
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),

                InkWell(
                  onTap: (){
                    _showModal(context, widget.sortScreen);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sort_rounded,
                        color: theme.lightBlue,
                        size: 25.r,
                      ),
                      Gap(8.w),
                      Text(
                        'Sort',
                        style: theme.mediumTxt.copyWith(
                          color: theme.lightBlue,
                          fontSize: 16.sp
                        ),
                      )
                    ],
                  ),
                ),
                Gap(20.w),

              ],
            ),
            Gap(10.h)
          ],
        ),
      ),
    );

  }

  _showModal(BuildContext context, Widget widget){

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r)
        ),
        child: widget
      ),
    );

  }

}