import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hotelsgo/common.dart';

class HomeSortScreen extends StatelessWidget {
  const HomeSortScreen({super.key, required this.sortIndex, required this.sort});
  final int sortIndex;
  final Function(int) sort;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    var divider = Divider(
      color: Colors.grey.shade500,
      indent: 16.w,
      thickness: .5,
    );

    return Container(
      height: size.height*.95,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8.r,
                  spreadRadius: 8.r
                )
              ]
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex:1, child: Container()),

                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Sort by',
                      style: theme.semiBoldTxt,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: IconButton(
                      onPressed: (){
                        sort(-1);
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(10.h),
                  _item(context, 0, 'Our recommendations'),
                  divider,
                  _item(context, 1, 'Rating & Recommended'),
                  divider,
                  _item(context, 2, 'Price & Recommended'),
                  divider,
                  _item(context, 3, 'Distance & Recommended'),
                  divider,
                  _item(context, 4, 'Rating only'),
                  divider,
                  _item(context, 5, 'Price only'),
                  divider,
                  _item(context, 6, 'Distance only'),
                  divider,

                ],
              ),
            )
          )

        ],
      ),
    );

  }

  Widget _item(BuildContext context, int index, String label){

    return InkWell(
      onTap: (){
        sort(index);
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                label,
                style: theme.regularTxt.copyWith(
                  fontSize: 18.sp
                ),
              ),
            ),
            Gap(10.w),
            Visibility(
              visible: sortIndex == index,
              child: Icon(
                Icons.check,
                color: theme.primaryColor,
              ),
            )
          ],
        ),
      ),
    );

  }
}
