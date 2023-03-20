import 'dart:convert';


import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:loco/screens/search.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../component/app_styles.dart';
import '../models/categoryID.dart';
import '../models/category_model.dart';
import '../models/getAllCategory_model.dart';
import '../models/profileDataModel.dart';
import '../translations/locale_keys.g.dart';
import 'notification_screen.dart';
import 'offer_screen.dart';

class PressedScreen extends StatefulWidget {
  String CatName;
    PressedScreen({Key? key,required this.CatName}) : super(key: key);

  @override
  State<PressedScreen> createState() => _PressedScreenState();
}

class _PressedScreenState extends State<PressedScreen> {

  int counter1=0;
  Future<CategoryIdModel?> catid({int? id, String? countId}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://eibtekone-001-site18.atempurl.com/api/GetByCatgId/${id}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"count_id": countId}));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        // print('dataId==${data}');
      } else {
        print("Faild");
      }
      return CategoryIdModel.fromJson(data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<ProfileDataModel?> accountDetail() async {
    try {
      var response = await http.post(
        Uri.parse(
            'http://eibtekone-001-site18.atempurl.com/api/auth/GetAccountData/${userData.read('token')}'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        // print('date=${data}');
        return ProfileDataModel.fromJson(data);
      } else {
        print('fail');
      }
    } catch (e) {
      print('e=${e}');
    }
  }

  void getDataId({required dynamic id}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://eibtekone-001-site18.atempurl.com/api/Get_Store_byId/${id}'),
          body: jsonEncode({"id": id}));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print('dataId==${data}');
      } else {
        print("Faild");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  final userData = GetStorage();
  int count = 0;
  int? id;


  Future<List<CategoryModel>> fetchCategory() async {
    final response = await http.get(Uri.parse(
        'http://eibtekone-001-site18.atempurl.com/api/GetAllCategories'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      List jsonData = (data['Records']);
      // print('dataaaaa${data}');

      return jsonData
          .map((categoryData) => CategoryModel.fromJson(categoryData))
          .toList();
    } else {
      throw Exception('Failed to load clinics');
    }
  }
  Future<CategoryIdallModel?> catallid({  String? query}) async {
    try {
      var response = await http.post(
          Uri.parse(
              'http://eibtekone-001-site18.atempurl.com/api/GetAllStores/${userData.read('country')}'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({"SearchValue":''}));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var log = json.decode(response.body);
        print('dataId==${data}');
      } else {
        print("Faild");
      }
      return CategoryIdallModel.fromJson(data);
    } catch (e) {
      print(e.toString());
    }
  }



  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 40.h, right: 20.h, left: 20.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            userData.read('isLogged') == false
                                ? CircleAvatar(
                              backgroundImage:
                              NetworkImage('${userData.read('img')}'),


                              radius: 25.r,
                            )
                                : FutureBuilder(
                              future: accountDetail(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'http://eibtekone-001-site18.atempurl.com${snapshot.data!.record!.imgUrl}'),
                                    radius: 25.r,
                                  );
                                } else {
                                  return Center(
                                    child: SizedBox(
                                        height: 15.h,
                                        width: 15.h,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                          AlwaysStoppedAnimation<Color>(
                                              Styles.defualtColor),
                                          strokeWidth: .6.r,
                                        )),
                                  );
                                }
                              },
                            ),
                            Gap(10.h),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      LocaleKeys.Welcome.tr(),
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Gap(5.h),
                                    Image(
                                      //fit: BoxFit.cover,
                                        height: 15.h,
                                        width: 15.h,
                                        image: AssetImage(
                                          'assets/hand.png',
                                        )),
                                  ],
                                ),
                                userData.read('isLogged')==false
                                    ?Text(userData.read('name'))
                                    : FutureBuilder(
                                  future: accountDetail(),
                                  builder: (context, snapshpt) {
                                    if (snapshpt.hasData) {
                                      return Text(
                                        '${snapshpt.data!.record!.name}',
                                      );
                                    } else {
                                      return Center(
                                        child: SizedBox(
                                            height: 15.h,
                                            width: 15.h,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                              AlwaysStoppedAnimation<
                                                  Color>(
                                                  Styles.defualtColor),
                                              strokeWidth: .6.r,
                                            )),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(NotificationScreen());
                          },
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Icon(
                                Icons.mail_outline_rounded,
                                size: 25.sp,
                              ),
                              // CircleAvatar(
                              //   backgroundColor: Colors.red,
                              //   radius: 4.r,
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: InkWell(
                      onTap: () {
                        showSearch(context: context, delegate: search());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF6F5F5),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        height: 45.h,
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: Row(
                          children: [
                            Icon(
                              FluentSystemIcons.ic_fluent_search_regular,
                              color: Colors.grey.shade400,
                              size: 17.sp,
                            ),
                            Gap(10.h),
                            Text(
                              LocaleKeys.Press_here_to_search.tr(),
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 12.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20.h),
                  //   child: TextFormField(
                  //     onTap: (){
                  //       showSearch(context: context, delegate: search());
                  //     },
                  //     cursorColor: Colors.grey.shade400,
                  //     keyboardType: TextInputType.emailAddress,
                  //     decoration: InputDecoration(
                  //         floatingLabelBehavior: FloatingLabelBehavior.never,
                  //         isDense: true,
                  //         contentPadding:
                  //             EdgeInsets.fromLTRB(20.h, 0.h, 20.h, 0.h),
                  //         filled: true,
                  //         fillColor: Color(0xffF6F5F5),
                  //         focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //               width: .1.r, color: Colors.transparent),
                  //           borderRadius: BorderRadius.circular(15),
                  //         ),
                  //         border: OutlineInputBorder(),
                  //         prefixIcon: Icon(
                  //           FluentSystemIcons.ic_fluent_search_regular,
                  //           color: Colors.grey.shade400,
                  //         ),
                  //         enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //               width: .1.r, color: Colors.transparent),
                  //           borderRadius: BorderRadius.circular(15.r),
                  //         ),
                  //         labelText: 'ابحث عن متجر معين',
                  //         hintText: 'ابحث عن متجر معين',
                  //         labelStyle: TextStyle(
                  //             fontSize: 15.sp, color: Colors.grey.shade400),
                  //         hintStyle: TextStyle(
                  //             fontSize: 15.sp, color: Colors.grey.shade400)),
                  //   ),
                  // ),
                  Gap(15.h),
                  Container(
                    height: 530.h,
                    width: double.infinity,
                    color: Color(0xffF7F7F7),
                    child: SingleChildScrollView(
                      child: Column(

                        children: [
                          Row(

                            children: [
                              Stack(


                                children: [
                                  InkWell(
                                    onTap: () {

                                    },
                                    child: Padding(
                                      padding:   EdgeInsets.symmetric(horizontal: 35.h,vertical: 15.h),
                                      child: Container(
                                        height: 30.h,
                                        width: 80.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20.r),
                                          gradient: LinearGradient(
                                            // begin: Alignment.topRight,
                                            // end: Alignment.bottomRight ,

                                            colors: [
                                              Color(0xffffa36c),
                                              Styles.defualtColor,
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            widget.CatName,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: -6.h,
                                      left: 13.h,


                                      child
                                      : IconButton( color: Color(0xff67564d), onPressed: () {Get.back();  }, icon: Icon(Icons.cancel),)),

                                ],

                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                          FutureBuilder (
                            future: catid(
                              countId:'${ userData.read('country')}',
                              id: userData.read('id'),),
                            builder: (context, snapshot){


                              if (snapshot.hasData) {
                                return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                                  return SizedBox(
                                    height: 400.h,
                                    child: ListView.separated(
                                      padding: EdgeInsets.all(10.h),
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () {

                                          getDataId(id: snapshot.data!.records![index].id);
                                          Get.to(OfferScreen(
                                            slider:  CarouselSlider(
                                                options: CarouselOptions(
                                                  height: 160.h,

                                                  autoPlay: false,
                                                  viewportFraction: .7.h,
                                                  onPageChanged: (index, reason) {
                                                    setState(() {
                                                      counter1=index;

                                                    });
                                                  },
                                                  enlargeCenterPage: false,

                                                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                                                  pauseAutoPlayOnTouch: true,
                                                  //enableInfiniteScroll: true,
                                                  autoPlayAnimationDuration: Duration(milliseconds: 900),
                                                  //  viewportFraction: .8,
                                                ),
                                                items:  snapshot.data!.records![index].storeSlider!.map((e) => Column(
                                                  children: [
                                                    Container(

                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(30.h),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image:  NetworkImage(
                                                            'http://eibtekone-001-site18.atempurl.com/Uploads/Stores/${e.imageUrl}',
                                                          ),
                                                        ),
                                                      ),
                                                      margin: EdgeInsets.symmetric(horizontal: 10.h),
                                                      height: 130.h,
                                                      width:  250.h,
                                                    ),
                                                    // Row(
                                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                                    //   children: [
                                                    //     for(int i=0;i<snapshot.data!.records!.length;i++)
                                                    //       Container(
                                                    //         height: 6.h,
                                                    //         width: 6.h,
                                                    //         margin: EdgeInsets.symmetric(horizontal: 3.h,vertical: 10.h),
                                                    //         decoration: BoxDecoration(
                                                    //           color: counter1==i?Styles.defualtColor:Styles.defaultColor7,
                                                    //           shape: BoxShape.circle,
                                                    //
                                                    //         ),
                                                    //       ),
                                                    //   ],
                                                    // ),


                                                  ],
                                                )).toList()

                                            ),
                                            stor_SaleCode: '${snapshot.data!.records![index].storSaleCode}',
                                            title: snapshot
                                                .data!.records![index].storTitle!,
                                            storeAddress: '${snapshot.data!.records![index].storAddress}',
                                            storedetails:
                                            '${snapshot.data!.records![index].storDeteils}',
                                            storeimg: 'http://eibtekone-001-site18.atempurl.com/Uploads/Stores/${snapshot.data!.records![index].storImgUrl}',
                                            storeLink: '${snapshot.data!.records![index].storLink}',
                                            storephone: '${snapshot.data!.records![index].storPhoneNumber}',
                                            storevip: snapshot.data!.records![index].acceptLocoCard!,
                                          ));
                                        },
                                        child: Container(
                                          height:75.h,
                                          width: double.infinity,

                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade200,
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: Offset(0, 3), // changes position of shadow
                                              ),
                                            ],
                                            color: Styles.defaultColor5,
                                            borderRadius: BorderRadius.circular(10.r),),
                                          child: Row(
                                            children: [
                                              Container(
                                                height:75.h,
                                                width: 80.h,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(10.r),bottomRight: Radius.circular(10.r)),

                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,

                                                      image: NetworkImage(
                                                        'http://eibtekone-001-site18.atempurl.com/Uploads/Stores/${snapshot.data!.records[index].storImgUrl}',
                                                      ),
                                                    )
                                                ),
                                              ),

                                              Container(
                                                height: 75.h,
                                                width: 200.h,
                                                padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.h),
                                                decoration: BoxDecoration(
                                                  color: Styles.defaultColor5,
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),bottomLeft: Radius.circular(10.r)),
                                                ),
                                                child:  Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          '${snapshot.data!.records[index].storTitle}',
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 14.sp),
                                                        ),

                                                        // Text(
                                                        //   'vvv',
                                                        //   style: TextStyle(
                                                        //       color: Colors.grey.shade400,
                                                        //       fontSize: 10.sp),
                                                        // ),
                                                        // Gap(5.h),
                                                        // RatingBar.builder(
                                                        //   initialRating: rating,
                                                        //   minRating: 1,
                                                        //   itemSize: 11,
                                                        //   itemPadding:
                                                        //   EdgeInsets.symmetric(horizontal: 1),
                                                        //   itemBuilder: (context, _) => Icon(
                                                        //     Icons.star,
                                                        //     color: Colors.yellow.shade300,
                                                        //     size: 15.sp,
                                                        //   ),
                                                        //   updateOnDrag: true,
                                                        //   onRatingUpdate: (rating)  {},
                                                        // ),
                                                      ],
                                                    ),
                                                    Gap(3.h),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          LocaleKeys.Store_link.tr(),
                                                          style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color:
                                                            Colors.grey.shade400,
                                                          ),
                                                        ),
                                                        Gap(5.h),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios_outlined,
                                                          size: 10.sp,
                                                          color: Colors.grey.shade400,
                                                        ),
                                                        Gap(5.h),
                                                        InkWell(
                                                          onTap: () {
                                                            _launchUrl(
                                                                '${snapshot.data!.records![index].storLink}');
                                                          },
                                                          child: Text(
                                                            '${snapshot.data!.records![index].storLink}',
                                                            style: TextStyle(
                                                              fontSize: 10.sp,
                                                              color: Colors
                                                                  .grey.shade400,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Gap(3.h),
                                                    Flexible(
                                                      child: SizedBox(
                                                        width: 180.h,
                                                        child: Text(

                                                          '${snapshot.data!.records![index].storDeteils}',
                                                          style: TextStyle(

                                                            fontSize: 8.sp,
                                                            color: Colors.grey.shade600,
                                                          ),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      separatorBuilder: (context, index) => Gap(10.h),
                                      itemCount: snapshot.data!.records!.length,
                                    ),
                                  );
                                });
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
                                  ),
                                );
                              }
                            },
                          )
                          // FutureBuilder(
                          //   future: categoryId(),
                          //
                          //     builder: (context,snapshot){
                          //     if(snapshot.hasData){
                          //       return Text('fff${snapshot.data['records'][0]['stor_Title']}');
                          //     }
                          //     else{
                          //       return CircularProgressIndicator();
                          //     }
                          //
                          //     })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
    // FutureBuilder(
    //                         future: catid(
    //                           countId:'${ userData.read('country')}',
    //                           id: userData.read('id'),
    //                         ),
    //                         builder: (context, snapshot) {
    //                           if (snapshot.hasData) {
    //                             return StatefulBuilder(builder: (BuildContext context, StateSetter setState){return Padding(
    //                               padding: EdgeInsets.symmetric(horizontal: 20.h),
    //                               child: SizedBox(
    //                                 height: 400.h,
    //                                 child: ListView.separated(
    //                                   itemBuilder: (context, index) => InkWell(
    //                                     onTap: () {
    //                                       // showDialog(
    //                                       //   context: context,
    //                                       //   builder:(context)=>
    //                                       //       Dialog(
    //                                       //         shape: RoundedRectangleBorder(
    //                                       //             borderRadius: BorderRadius.circular(30)),
    //                                       //
    //                                       //         child: Container(
    //                                       //           height: 210,
    //                                       //           width: 250,
    //                                       //
    //                                       //           child: Column(
    //                                       //             mainAxisAlignment: MainAxisAlignment.center,
    //                                       //             children: [
    //                                       //               Text('قم بإضافة رأيك',style: TextStyle(
    //                                       //                 fontWeight: FontWeight.w500,
    //                                       //                 fontSize: 17.sp,
    //                                       //               ),),
    //                                       //               Text('يرجي تقييم الخدمة وإضافة رأيك في العملية  ',style: TextStyle(
    //                                       //                 fontWeight: FontWeight.w500,
    //                                       //                 color: Styles.defualtColor2,
    //                                       //                 fontSize: 14.sp,
    //                                       //               ),),
    //                                       //               Gap(10.h),
    //                                       //               RatingBar.builder(
    //                                       //                 initialRating: rating,
    //                                       //                 minRating: 1,
    //                                       //                 itemSize: 30,
    //                                       //                 itemPadding: EdgeInsets.symmetric(horizontal: 2),
    //                                       //                 itemBuilder: (context,_)=>Icon(
    //                                       //                   Icons.star,
    //                                       //                   color: Colors.yellow.shade300,
    //                                       //                   size: 18.sp,
    //                                       //                 ),
    //                                       //                 updateOnDrag: true,
    //                                       //                 onRatingUpdate: (rating)=>setState(() {
    //                                       //                   this.rating=rating;
    //                                       //                 }),
    //                                       //               ),
    //                                       //               Gap(20.h),
    //                                       //               InkWell(
    //                                       //                 onTap: (){
    //                                       //                   Get.back();
    //                                       //                 },
    //                                       //                 child: Container(
    //                                       //                   height: 40.h,
    //                                       //                   width: 100.h,
    //                                       //                   decoration: BoxDecoration(
    //                                       //                     borderRadius: BorderRadius.circular(5.h),
    //                                       //                     color: Styles.defualtColor,
    //                                       //                   ),
    //                                       //                 child: Icon(Icons.send,color: Colors.white,),
    //                                       //                 ),
    //                                       //               )
    //                                       //
    //                                       //             ],
    //                                       //           ),
    //                                       //         ),
    //                                       //
    //                                       //       ),
    //                                       //
    //                                       // );
    //                                       getDataId(
    //                                           id: snapshot
    //                                               .data!.records![index].id);
    //                                       Get.to(OfferScreen(
    //                                         title: snapshot
    //                                             .data!.records![index].storTitle!,
    //                                         storeAddress: '${snapshot.data!.records![index].storAddress}',
    //                                         storedetails:
    //                                         '${snapshot.data!.records![index].storDeteils}',
    //                                         storeimg: 'http://eibtekone-001-site18.atempurl.com/Uploads/Stores/${snapshot.data!.records![index].storImgUrl}',
    //                                         storeLink: '${snapshot.data!.records![index].storLink}',
    //                                         storephone: '${snapshot.data!.records![index].storPhoneNumber}',
    //                                         storevip: snapshot.data!.records![index].acceptLocoCard!,
    //                                         stor_SaleCode: '${snapshot.data!.records![index].storSaleCode}',
    //                                         slider:  CarouselSlider(
    //                                             options: CarouselOptions(
    //                                               height: 160.h,
    //
    //                                               autoPlay: false,
    //                                               viewportFraction: .7.h,
    //                                               onPageChanged: (index, reason) {
    //                                                 setState(() {
    //                                                   counter1=index;
    //                                                   print('counter1  ${counter1}');
    //                                                 });
    //                                               },
    //                                               enlargeCenterPage: false,
    //
    //                                               autoPlayCurve: Curves.fastLinearToSlowEaseIn,
    //                                               pauseAutoPlayOnTouch: true,
    //                                               //enableInfiniteScroll: true,
    //                                               autoPlayAnimationDuration: Duration(milliseconds: 900),
    //                                               //  viewportFraction: .8,
    //                                             ),
    //                                             items:  snapshot.data!.records![index].storeSlider!.map((e) => Column(
    //                                               children: [
    //                                                 Container(
    //
    //                                                   decoration: BoxDecoration(
    //                                                     color: Colors.white,
    //                                                     borderRadius: BorderRadius.circular(30.h),
    //                                                     image: DecorationImage(
    //                                                       fit: BoxFit.cover,
    //                                                       image:  NetworkImage(
    //                                                         'http://eibtekone-001-site18.atempurl.com/Uploads/Stores/${e.imageUrl}',
    //                                                       ),
    //                                                     ),
    //                                                   ),
    //                                                   margin: EdgeInsets.symmetric(horizontal: 10.h),
    //                                                   height: 130.h,
    //                                                   width:  250.h,
    //                                                 ),
    //                                                 // Row(
    //                                                 //   mainAxisAlignment: MainAxisAlignment.center,
    //                                                 //   children: [
    //                                                 //     for(int i=0;i < snapshot.data!.records![index].storeSlider!.length;i++)
    //                                                 //
    //                                                 //       Container(
    //                                                 //         height: 6.h,
    //                                                 //         width: 6.h,
    //                                                 //         margin: EdgeInsets.symmetric(horizontal: 3.h,vertical: 10.h),
    //                                                 //         decoration: BoxDecoration(
    //                                                 //           color: counter1==i? Styles.defualtColor:Styles.defaultColor7,
    //                                                 //           shape: BoxShape.circle,
    //                                                 //
    //                                                 //         ),
    //                                                 //       ),
    //                                                 //   ],
    //                                                 // ),
    //
    //
    //                                               ],
    //                                             )).toList()
    //
    //                                         ),
    //                                       ));
    //                                     },
    //                                     child: Container(
    //                                       height:75.h,
    //                                       width: double.infinity,
    //                                       decoration: BoxDecoration(
    //                                         boxShadow: [
    //                                           BoxShadow(
    //                                             color: Colors.grey.shade200,
    //                                             spreadRadius: 1,
    //                                             blurRadius: 3,
    //                                             offset: Offset(0, 3), // changes position of shadow
    //                                           ),
    //                                         ],
    //                                         color: Styles.defaultColor5,
    //                                         borderRadius: BorderRadius.circular(10.r),
    //                                       ),
    //                                       child: Row(
    //                                         children: [
    //                                           Container(
    //                                             height:75.h,
    //                                             width: 80.h,
    //                                             decoration: BoxDecoration(
    //                                                 borderRadius: BorderRadius.only(topRight: Radius.circular(10.r),bottomRight: Radius.circular(10.r)),
    //
    //                                                 image: DecorationImage(
    //                                                   fit: BoxFit.cover,
    //
    //                                                   image: NetworkImage(
    //                                                     'http://eibtekone-001-site18.atempurl.com/Uploads/Stores/${snapshot.data!.records[index].storImgUrl}',
    //                                                   ),
    //                                                 )
    //                                             ),
    //                                           ),
    //
    //                                          Container(
    //                                            height: 75.h,
    //                                            width: 200.h,
    //                                            padding: EdgeInsets.symmetric(horizontal: 10.h,vertical: 10.h),
    //                                            decoration: BoxDecoration(
    //                                              color: Styles.defaultColor5,
    //                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),bottomLeft: Radius.circular(10.r)),
    //                                            ),
    //                                            child:  Column(
    //                                              mainAxisAlignment:
    //                                              MainAxisAlignment.center,
    //                                              crossAxisAlignment:
    //                                              CrossAxisAlignment.start,
    //                                              children: [
    //                                                Row(
    //                                                  children: [
    //                                                    Text(
    //                                                      '${snapshot.data!.records[index].storTitle}',
    //                                                      style: TextStyle(
    //                                                          color: Colors.black,
    //                                                          fontSize: 14.sp),
    //                                                    ),
    //
    //                                                    // Text(
    //                                                    //   'vvv',
    //                                                    //   style: TextStyle(
    //                                                    //       color: Colors.grey.shade400,
    //                                                    //       fontSize: 10.sp),
    //                                                    // ),
    //                                                    // Gap(5.h),
    //                                                    // RatingBar.builder(
    //                                                    //   initialRating: rating,
    //                                                    //   minRating: 1,
    //                                                    //   itemSize: 11,
    //                                                    //   itemPadding:
    //                                                    //   EdgeInsets.symmetric(horizontal: 1),
    //                                                    //   itemBuilder: (context, _) => Icon(
    //                                                    //     Icons.star,
    //                                                    //     color: Colors.yellow.shade300,
    //                                                    //     size: 15.sp,
    //                                                    //   ),
    //                                                    //   updateOnDrag: true,
    //                                                    //   onRatingUpdate: (rating)  {},
    //                                                    // ),
    //                                                  ],
    //                                                ),
    //                                                Gap(3.h),
    //                                                Row(
    //                                                  children: [
    //                                                    Text(
    //                                                      LocaleKeys.Store_link.tr(),
    //                                                      style: TextStyle(
    //                                                        fontSize: 10.sp,
    //                                                        color:
    //                                                        Colors.grey.shade400,
    //                                                      ),
    //                                                    ),
    //                                                    Gap(5.h),
    //                                                    Icon(
    //                                                      Icons
    //                                                          .arrow_forward_ios_outlined,
    //                                                      size: 10.sp,
    //                                                      color: Colors.grey.shade400,
    //                                                    ),
    //                                                    Gap(5.h),
    //                                                    InkWell(
    //                                                      onTap: () {
    //                                                        _launchUrl(
    //                                                            '${snapshot.data!.records![index].storLink}');
    //                                                      },
    //                                                      child: Text(
    //                                                        '${snapshot.data!.records![index].storLink}',
    //                                                        style: TextStyle(
    //                                                          fontSize: 10.sp,
    //                                                          color: Colors
    //                                                              .grey.shade400,
    //                                                        ),
    //                                                      ),
    //                                                    ),
    //                                                  ],
    //                                                ),
    //                                                Gap(3.h),
    //                                                Flexible(
    //                                                  child: SizedBox(
    //                                                    width: 180.h,
    //                                                    child: Text(
    //
    //                                                      '${snapshot.data!.records![index].storDeteils}',
    //                                                      style: TextStyle(
    //
    //                                                        fontSize: 8.sp,
    //                                                        color: Colors.grey.shade600,
    //                                                      ),
    //                                                      maxLines: 1,
    //                                                    ),
    //                                                  ),
    //                                                ),
    //                                              ],
    //                                            ),
    //                                          )
    //                                         ],
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   separatorBuilder: (context, index) =>
    //                                       Gap(5.h),
    //                                   itemCount: snapshot.data!.records!.length,
    //                                 ),
    //                               ),
    //                             );});
    //                           } else {
    //                             return Center(
    //                               child: Text(
    //                                 'choose Category Above',
    //                                 style: TextStyle(
    //                                     color: Styles.defualtColor,
    //                                     fontSize: 15.sp),
    //                               ),
    //                             );
    //                           }
    //                         },
    //                       )
  }

  Future<void> _launchUrl(String link) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}

// Container(
//                                           height: 30.h,
//                                           width: 85.h,
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(20.r),
//                                             gradient: LinearGradient(
//                                               // begin: Alignment.topRight,
//                                               // end: Alignment.bottomRight ,
//
//                                               colors: [
//                                                 Colors.grey.shade300,
//                                                 Colors.grey.shade400,
//                                               ],
//                                             ),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               'الأسر المنتجة',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12.sp,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
