import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hotelsgo/common.dart';
import 'package:hotelsgo/models/hotel.dart';
import 'package:hotelsgo/utils/utils.dart';

class HotelListItem extends StatelessWidget {
  const HotelListItem({super.key, required this.hotel});
  final Hotel hotel;

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      margin: EdgeInsets.only(bottom: 20.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///IMAGE
              SizedBox(
                height: 140.h,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: hotel.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 140.h,
                      fadeInDuration: const Duration(milliseconds: 1000),
                      placeholder: (_,__) => FadeShimmer(
                        width: double.infinity,
                        height: 140.h,
                        baseColor: theme.shimmerBaseColor,
                        highlightColor: theme.shimmerHighlight,
                      ),
                      errorWidget: (_,__,___) => Container(color: Colors.grey.shade300),
                    ),
                    Positioned(
                      top: 20.r,
                      right: 20.r,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54.withOpacity(.3),
                        radius: 20.r,
                        child: Icon(
                          CupertinoIcons.heart,
                          color: Colors.white,
                          size: 30.r,
                        ),
                      ),
                    )
                  ],
                ),
              ),

              ///DETAILS
              Container(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:6.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///STARS
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _stars(),
                              Gap(5.w),
                              Text(
                                'Hotel',
                                style: theme.regularTxt,
                              )
                            ],
                          ),
                          Gap(5.h),

                          ///NAME
                          Text(
                            hotel.name,
                            style: theme.boldTxt.copyWith(
                              fontSize: 16.sp
                            ),
                          ),
                          Gap(5.h),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _score(),
                              Gap(5.w),

                              Text(
                                hotel.review,
                                style: theme.regularTxt,
                              ),
                              Gap(10.w),

                              Icon(
                                Icons.location_pin,
                                color: Colors.grey.shade700,
                                size: 13.r,
                              ),
                              Gap(3.w),

                              Expanded(
                                child: AutoSizeText(
                                  hotel.address,
                                  style: theme.regularTxt,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          Gap(10.h),
                        ],
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey, width: 1.2)
                      ),
                      padding: EdgeInsets.all(8.r),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB8D7E1),
                                  borderRadius: BorderRadius.circular(4.r)
                                ),
                                padding: EdgeInsets.all(4.r),
                                child: Text(
                                  'Our lowest price',
                                  style: theme.semiBoldTxt.copyWith(
                                    fontSize: 14.sp,
                                    color: theme.darkGrey
                                  ),
                                ),
                              ),
                              Gap(10.h),

                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Text(
                                      Utils.getCurrencySymbol(currency: hotel.currency),
                                      style: theme.boldTxt.copyWith(
                                        color: const Color(0xFF058007),
                                        fontSize: 16.sp,
                                        height: 1
                                      ),
                                    ),
                                  ),
                                  Text(
                                    hotel.price.toString(),
                                    style: theme.boldTxt.copyWith(
                                      color: const Color(0xFF058007),
                                      fontSize: 27.sp,
                                      height: 1
                                    ),
                                  ),

                                ],
                              ),

                              Text(
                                _shortName(),
                                style: theme.semiBoldTxt.copyWith(
                                  color: Colors.grey.shade700,
                                  fontSize: 10.sp
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'View Deal',
                                style: theme.boldTxt.copyWith(
                                  fontSize: 18.sp
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                                size: 20.r,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 16.w, bottom: 16.h),
                  child: InkWell(
                    onTap: (){

                    },
                    child: Text(
                      'More prices',
                      style: theme.semiBoldTxt.copyWith(
                        fontSize: 15.sp,
                        color: Colors.grey.shade700,
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5,
                        decorationColor: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );

  }

  Widget _stars(){

    List<Widget> stars = [];

    for(int i=0; i<hotel.stars; i++){
      stars.add(
        Icon(
          Icons.star,
          color: Colors.grey.shade700,
          size: 14.r,
        )
      );
    }

    return Row(
      children: stars,
    );

  }

  Widget _score(){

    Color color;

    if(hotel.reviewScore>=9){
      color = Colors.green.shade900;
    }else if(hotel.reviewScore > 7.5){
      color = Colors.green.shade700;
    }else if(hotel.reviewScore > 6){
      color = Colors.green.shade500;
    }else if(hotel.reviewScore >= 5){
      color = Colors.amber;
    }else{
      color = Colors.red;
    }

    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
      child: Center(
        child: Text(
          hotel.reviewScore.toString(),
          style: theme.semiBoldTxt.copyWith(
            color: Colors.white,
            fontSize: 14.sp
          ),
        ),
      ),
    );

  }

  String _shortName(){

    var split = hotel.name.split(' ');

    var ignore = ['the', 'hotel', 'el'];
    for(String s in split){
      if(ignore.any((e) => e==s.toLowerCase())){

        int index = split.indexOf(s);

        return '${split[index]} ${split[index+1]}';

      }

      return s;
    }

    return split[0];

  }

}

class HotelListItemLoading extends StatelessWidget {
  const HotelListItemLoading({super.key});

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      margin: EdgeInsets.only(bottom: 20.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeShimmer(
                width: double.infinity,
                height: 140.h,
                baseColor: theme.shimmerBaseColor,
                highlightColor: theme.shimmerHighlight,
              ),

              ///DETAILS
              Container(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:6.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeShimmer(
                            width: 120.w,
                            height: 12.h,
                            baseColor: theme.shimmerBaseColor,
                            highlightColor: theme.shimmerHighlight,
                          ),
                          Gap(10.h),
                          FadeShimmer(
                            width: 200.w,
                            height: 12.h,
                            baseColor: theme.shimmerBaseColor,
                            highlightColor: theme.shimmerHighlight,
                          ),
                          Gap(10.h),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FadeShimmer(
                                width: 30.w,
                                height: 12.h,
                                radius: 16.r,
                                baseColor: theme.shimmerBaseColor,
                                highlightColor: theme.shimmerHighlight,
                              ),
                              Gap(10.w),

                              FadeShimmer(
                                width: 120.w,
                                height: 12.h,
                                baseColor: theme.shimmerBaseColor,
                                highlightColor: theme.shimmerHighlight,
                              ),
                            ],
                          ),
                          Gap(10.h),
                        ],
                      ),
                    ),

                    /*Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey, width: 1.2)
                      ),
                      padding: EdgeInsets.all(8.r),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFB8D7E1),
                                  borderRadius: BorderRadius.circular(4.r)
                                ),
                                padding: EdgeInsets.all(4.r),
                                child: Text(
                                  'Our lowest price',
                                  style: theme.semiBoldTxt.copyWith(
                                    fontSize: 14.sp,
                                    color: theme.darkGrey
                                  ),
                                ),
                              ),
                              Gap(10.h),

                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Text(
                                      Utils.getCurrencySymbol(currency: hotel.currency),
                                      style: theme.boldTxt.copyWith(
                                        color: const Color(0xFF058007),
                                        fontSize: 16.sp,
                                        height: 1
                                      ),
                                    ),
                                  ),
                                  Text(
                                    hotel.price.toString(),
                                    style: theme.boldTxt.copyWith(
                                      color: const Color(0xFF058007),
                                      fontSize: 27.sp,
                                      height: 1
                                    ),
                                  ),

                                ],
                              ),

                              Text(
                                _shortName(),
                                style: theme.semiBoldTxt.copyWith(
                                  color: Colors.grey.shade700,
                                  fontSize: 10.sp
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'View Deal',
                                style: theme.boldTxt.copyWith(
                                  fontSize: 18.sp
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black,
                                size: 20.r,
                              )
                            ],
                          )
                        ],
                      ),
                    )*/
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}

