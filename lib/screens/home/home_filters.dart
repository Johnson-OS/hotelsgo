
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hotelsgo/common.dart';
import 'package:hotelsgo/utils/utils.dart';

class HomeFilters extends StatefulWidget {
  const HomeFilters({super.key, required this.filters, required this.filter});
  final Map<String, dynamic> filters;
  final Function(Map<String, dynamic>) filter;

  @override
  State<HomeFilters> createState() => _HomeFiltersState();
}

class _HomeFiltersState extends State<HomeFilters> {

  late Size _size;
  late Map<String, dynamic> filters;
  final locations = ['City center', 'Current Location', 'Pick Location'];

  @override
  void initState() {
    super.initState();
    filters = widget.filters;
  }

  @override
  Widget build(BuildContext context) {

    _size = MediaQuery.of(context).size;

    return Container(
      height: _size.height*.95,
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
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: (){
                      widget.filter({});
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Text(
                        'Reset',
                        style: theme.semiBoldTxt.copyWith(
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.grey
                        ),
                      ),
                    ),
                  ),
                ),


                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      'Filters',
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(15.h),
                        ///PRICE
                        Row(
                          children: [
                            Text(
                              'PRICE PER NIGHT',
                              style: theme.semiBoldTxt.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                            const Spacer(),
                            if(filters['price'] != null) Container(
                              width: 80.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(color: Colors.grey.shade700)
                              ),
                              child: Center(
                                child: Text(
                                  '${Utils.getCurrencySymbol()}${(filters['price'] as double).toInt()}+',
                                  style: theme.regularTxt.copyWith(
                                    fontSize: 16.sp,
                                    color: Colors.grey.shade700
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Gap(5.h),

                        ///SLIDER
                        Slider.adaptive(
                          value: filters['price']??20.0,
                          min: 20.0,
                          max: 540.0,
                          thumbColor: Colors.white,
                          inactiveColor: Colors.grey.shade300,
                          onChanged: (val){
                            setState(() {
                              filters['price']=val.roundToDouble();
                            });
                          },
                        ),
                        Row(
                          children: [
                            Gap(20.w),
                            Text(
                              '${Utils.getCurrencySymbol()}20',
                              style: theme.regularTxt.copyWith(
                                fontSize: 16.sp,
                                color: Colors.grey.shade700
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${Utils.getCurrencySymbol()}540+',
                              style: theme.regularTxt.copyWith(
                                fontSize: 16.sp,
                                color: Colors.grey.shade700
                              ),
                            ),
                            Gap(20.w)
                          ],
                        ),
                        Gap(40.h),

                        ///RATING
                        Text(
                          'RATING',
                          style: theme.semiBoldTxt.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        Gap(15.h),
                        _rating(),
                        Gap(40.h),

                        ///HOTEL CLASS
                        Text(
                          'HOTEL CLASS',
                          style: theme.semiBoldTxt.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        Gap(15.h),
                        _classes(),
                        Gap(40.h),

                        ///DISTANCE
                        Text(
                          'DISTANCE FROM',
                          style: theme.semiBoldTxt.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        Gap(10.h),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.shade500, indent: 16.w, thickness: .5,),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SizedBox(
                      width: _size.width,
                      child: Row(
                        children: [
                          Text(
                            'Location',
                            style: theme.regularTxt.copyWith(
                              fontSize: 16.sp,
                              color: Colors.grey.shade700
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 150.w,
                            child: DropdownButtonFormField(
                              isExpanded: false,
                              value: filters['location']??locations[0],
                              decoration: const InputDecoration(
                                border: InputBorder.none
                              ),
                              alignment: AlignmentDirectional.centerEnd,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 20.r,
                              ),
                              items: locations.map((e) => DropdownMenuItem(
                                value: e,
                                  child: AutoSizeText(
                                    e,
                                    style: theme.regularTxt.copyWith(fontSize: 16.sp, color: Colors.grey.shade700),
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                  ))
                              ).toList(),
                              onChanged: (v){
                                setState(() {
                                  filters['location']=v;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey.shade500, indent: 16.w, thickness: .5,),

                ],
              ),
            )
          ),
          Container(
            width: double.infinity,
            height: 80.h,
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
            child: Center(
              child: TextButton(
                onPressed: (){
                  widget.filter(filters);
                  Navigator.of(context).pop();
                },
                style: theme.priBtnStyle,
                child: SizedBox(
                  height: theme.kBtnHeight,
                  width: _size.width*.8,
                  child: Center(
                    child: Text(
                      'Show results',
                      style: theme.semiBoldTxt.copyWith(
                        color: Colors.white,
                        fontSize: 16.sp
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );

  }

  Widget _rating(){

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: (){
            setState(() {
              filters['rating'] = filters['rating']==0?null:0;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4.r),
                  border: filters['rating']==0?Border.all(
                    color: theme.lightBlue,
                    width: 3
                  ):null
                ),
                child: Center(
                  child: Text(
                    '0+',
                    style: theme.mediumTxt.copyWith(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              Gap(3.h),
              if(filters['rating'] == 0)Icon(
                Icons.circle,
                size: 10.r,
                color: theme.primaryColor,
              )
            ],
          ),
        ),

        InkWell(
          onTap: (){
            setState(() {
              filters['rating'] = filters['rating']==7?null:7.0;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(4.r),
                  border: filters['rating']==7?Border.all(
                    color: theme.lightBlue,
                    width: 3
                  ):null
                ),
                child: Center(
                  child: Text(
                    '7+',
                    style: theme.mediumTxt.copyWith(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              Gap(3.h),
              if(filters['rating'] == 7)Icon(
                Icons.circle,
                size: 10.r,
                color: theme.primaryColor,
              )
            ],
          ),
        ),

        InkWell(
          onTap: (){
            setState(() {
              filters['rating'] = filters['rating']==7.5?null: 7.5;
            });
          },
          child: Column(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: Colors.green.shade500,
                  borderRadius: BorderRadius.circular(4.r),
                  border: filters['rating']==7.5?Border.all(
                    color: theme.primaryColor,
                    width: 2
                  ):null
                ),
                child: Center(
                  child: Text(
                    '7.5+',
                    style: theme.mediumTxt.copyWith(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              Gap(3.h),
              if(filters['rating'] == 7.5)Icon(
                Icons.circle,
                size: 10.r,
                color: theme.primaryColor,
              )
            ],
          ),
        ),

        InkWell(
          onTap: (){
            setState(() {
              filters['rating'] = filters['rating']==8?null:8;
            });
          },
          child: Column(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(4.r),
                  border: filters['rating']==8?Border.all(
                    color: theme.primaryColor,
                    width: 3
                  ):null
                ),
                child: Center(
                  child: Text(
                    '8+',
                    style: theme.mediumTxt.copyWith(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              Gap(3.h),
              if(filters['rating'] == 8)Icon(
                Icons.circle,
                size: 10.r,
                color: theme.primaryColor,
              )
            ],
          ),
        ),

        InkWell(
          onTap: (){
            setState(() {
              filters['rating'] = filters['rating']==8.5?null:8.5;
            });
          },
          child: Column(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: Colors.green.shade900,
                  borderRadius: BorderRadius.circular(4.r),
                  border: filters['rating']==8.5?Border.all(
                    color: theme.primaryColor,
                    width: 2
                  ):null
                ),
                child: Center(
                  child: Text(
                    '8.5+',
                    style: theme.mediumTxt.copyWith(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
              Gap(3.h),
              if(filters['rating'] == 8.5)Icon(
                Icons.circle,
                size: 10.r,
                color: theme.primaryColor,
              )
            ],
          ),
        ),


      ],
    );

  }

  Widget _classes(){

    int selected = filters['class']??0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

        InkWell(
          onTap: (){
            setState(() {
              filters['class'] = filters['class']==1?null:1;
            });
          },
          child: Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: selected==1?theme.primaryColor:Colors.yellow.shade800,
                width: 1.5
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.star_slash_fill,
                    color: (selected==1?theme.primaryColor:Colors.yellow.shade800).withOpacity(.5),
                    size: 15.r,
                  ),
                  Icon(
                    CupertinoIcons.star_fill,
                    color: selected==1?theme.primaryColor:Colors.yellow.shade800,
                    size: 15.r,
                  ),

                ],
              ),
            ),
          ),
        ),

        InkWell(
          onTap: (){
            setState(() {
              filters['class'] = filters['class']==2?null:2;
            });
          },
          child: Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: selected==2?theme.primaryColor:Colors.yellow.shade800,
                width: 1.5
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.star_fill,
                    color: selected==2?theme.primaryColor:Colors.yellow.shade800,
                    size: 15.r,
                  ),
                  Icon(
                    CupertinoIcons.star_fill,
                    color: selected==2?theme.primaryColor:Colors.yellow.shade800,
                    size: 15.r,
                  ),

                ],
              ),
            ),
          ),
        ),

        InkWell(
          onTap: (){
            setState(() {
              filters['class'] = filters['class']==3?null:3;
            });
          },
          child: Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: selected==3?theme.primaryColor:Colors.yellow.shade800,
                width: 1.5
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.star_fill,
                    color: selected==3?theme.primaryColor:Colors.yellow.shade800,
                    size: 15.r,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        color: selected==3?theme.primaryColor:Colors.yellow.shade800,
                        size: 15.r,
                      ),
                      Icon(
                        CupertinoIcons.star_fill,
                        color: selected==3?theme.primaryColor:Colors.yellow.shade800,
                        size: 15.r,
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        InkWell(
          onTap: (){
            setState(() {
              filters['class'] = filters['class']==4?null:4;
            });
          },
          child: Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: selected==4?theme.primaryColor:Colors.yellow.shade800,
                width: 1.5
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        color: selected==4?theme.primaryColor:Colors.yellow.shade800,
                        size: 15.r,
                      ),
                      Icon(
                        CupertinoIcons.star_fill,
                        color: selected==4?theme.primaryColor:Colors.yellow.shade800,
                        size: 15.r,
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        color: selected==4?theme.primaryColor:Colors.yellow.shade800,
                        size: 15.r,
                      ),
                      Icon(
                        CupertinoIcons.star_fill,
                        color: selected==4?theme.primaryColor:Colors.yellow.shade800,
                        size: 15.r,
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        InkWell(
          onTap: (){
            setState(() {
              filters['class'] = filters['class']==5?null:5;
            });
          },
          child: Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(
                color: selected==5?theme.primaryColor:Colors.yellow.shade800,
                width: 1.5
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        color: selected==5?theme.primaryColor:Colors.yellow.shade800,
                        size: 12.5.r,
                      ),
                      Gap(5.w),
                      Icon(
                        CupertinoIcons.star_fill,
                        color: selected==5?theme.primaryColor:Colors.yellow.shade800,
                        size: 12.5.r,
                      ),
                    ],
                  ),
                  Icon(
                    CupertinoIcons.star_fill,
                    color: selected==5?theme.primaryColor:Colors.yellow.shade800,
                    size: 11.r,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        CupertinoIcons.star_fill,
                        color: selected==5?theme.primaryColor:Colors.yellow.shade800,
                        size: 12.5.r,
                      ),
                      Gap(5.w),
                      Icon(
                        CupertinoIcons.star_fill,
                        color: selected==5?theme.primaryColor:Colors.yellow.shade800,
                        size: 12.5.r,
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),



      ],
    );

  }
}
