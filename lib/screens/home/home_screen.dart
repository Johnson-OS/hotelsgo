
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hotelsgo/common.dart';
import 'package:hotelsgo/models/hotel.dart';
import 'package:hotelsgo/models/network_result.dart';
import 'package:hotelsgo/res/assets.dart';
import 'package:hotelsgo/screens/home/home_filters.dart';
import 'package:hotelsgo/screens/home/sort_screen.dart';
import 'package:hotelsgo/widgets/app_bar.dart';
import 'package:hotelsgo/widgets/hotel_list_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ScrollController controller = ScrollController();
  late Size _size;
  bool isScrolling = false;
  int sortIndex = -1;
  Map<String, dynamic> filters = {};

  NetworkResult results = NetworkResult.loading('');

  @override
  void initState() {
    super.initState();

    _getData();

  }

  _getData() async {

    setState(() {
      results = results = NetworkResult.loading('');
    });

    results = await hotelsService.getHotels();

    setState(() {

    });

  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark
      ),
      child: Scaffold(
        body: SizedBox.expand(
          child: Stack(
            children: [
              _body(),
              if(results is SuccessState)AnimatedPositioned(
                bottom: isScrolling? 18.h:-70.h,
                left: 0,
                right: 0,
                duration: const Duration(seconds: 1),
                child: SizedBox(
                  height: 70.h,
                  child: Center(
                    child: Container(
                      width: 150.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12.r)
                      ),
                      padding: EdgeInsets.all(8.r),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            Assets.imgMap,
                            fit: BoxFit.cover,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                borderRadius: BorderRadius.circular(16.r)
                              ),
                              padding: EdgeInsets.symmetric(horizontal:16.w, vertical:8.h),
                              child: Text(
                                'Map',
                                style: theme.mediumTxt.copyWith(
                                  color: Colors.white
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: MAppBar(
                  scrollController: controller,
                  sortScreen: HomeSortScreen(sortIndex: sortIndex, sort: _sort),
                  filterScreen: HomeFilters(filters: filters, filter: _filter,),
                ),
              ),

            ],
          )
        ),
      ),
    );

  }

  Widget _body(){

    if(results is LoadingState){

      return ListView(
        controller: controller,
        physics: theme.bouncingPhysics,
        padding: theme.screenPadding,
        children: const [
          Gap(120),
          HotelListItemLoading(),
          HotelListItemLoading(),
          HotelListItemLoading(),
          HotelListItemLoading(),
        ],
      );
    }

    if(results is ErrorState){
      return _error();
    }

    List<Hotel> hotels = (results as SuccessState).value;
    _sortNFilter(hotels);

    if(hotels.isEmpty) return _noData();

    return RefreshIndicator(
      onRefresh: () => Future.sync(()=> _getData()),
      child: NotificationListener(
        onNotification: (notification){

          if(notification is ScrollStartNotification){

            if(!isScrolling){
              setState(() {
                isScrolling = true;
              });
            }

          }else if(notification is ScrollEndNotification){

            Future.delayed(const Duration(seconds: 5),(){
              if(isScrolling){
                setState(() {
                  isScrolling = false;
                });
              }
            });

          }

          return true;

        },
        child: ListView(
          controller: controller,
          physics: theme.bouncingPhysics,
          padding: theme.screenPadding,
          shrinkWrap: true,
          children:  [const Gap(120), ...hotels.map((e) => HotelListItem(hotel: e)),],
        ),
      ),
    );

  }

  _sort(int index){
    sortIndex = index;
    _getData();
  }

  _filter(Map<String, dynamic> val){
    filters = val;
    _getData();

  }

  _sortNFilter(List<Hotel> lst){

    if(filters['price'] != null){
      lst.removeWhere((e) => e.price<filters['price']);
    }

    if(filters['rating'] != null){

      double rating  = filters['rating'];

      if(rating==0){
        lst.removeWhere((e) => !(e.reviewScore<7));
      }else if(rating == 7.0){
        lst.removeWhere((e) => !(e.reviewScore>=7.0 && e.reviewScore<7.5));
      }
      else if(rating == 7.5){
        lst.removeWhere((e) => !(e.reviewScore>=7.5 && e.reviewScore<8));
      }
      else if(rating == 8){
        lst.removeWhere((e) => !(e.reviewScore>=8 && e.reviewScore<8.5));
      }else if(rating == 8.5){
        lst.removeWhere((e) => !(e.reviewScore>=8.5));
      }

    }

    if(filters['class'] != null){
      lst.removeWhere((e) => e.stars != filters['class']);
    }

    if(sortIndex == 4 || sortIndex ==0 || sortIndex==1){
      lst.sort((a,b) => b.reviewScore.compareTo(a.reviewScore));
    }else if(sortIndex == 5 || sortIndex == 2){
      lst.sort((a,b) => b.price.compareTo(a.price));
    }
  }

  Widget _noData(){

    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade500,
            borderRadius: BorderRadius.circular(16.r)
        ),
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
        child: Text(
          'No Results',
          style: theme.mediumTxt,
        ),
      ),
    );

  }

  Widget _error(){

    return Center(
      child: SizedBox(
        width: _size.width*.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning_rounded,
              color: Colors.red.shade700,
              size: 100.r,
            ),
            Gap(20.h),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(16.r)
              ),
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 8.h),
              child: Text(
                (results as ErrorState).msg,
                style: theme.mediumTxt,
              ),
            ),
            Gap(20.h),
            TextButton(
              onPressed: (){
                _getData();
              },
              style: theme.priBtnStyle,
              child: Text(
                'Try Again',
                style: theme.semiBoldTxt.copyWith(
                  color: Colors.white,
                  fontSize: 14.sp
                ),
              ),
            )
          ],
        ),
      ),
    );

  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

}
