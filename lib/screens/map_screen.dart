import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
 import 'package:http/http.dart' as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../component/app_styles.dart';
import '../component/component.dart';
import '../models/country_model.dart';
import '../translations/locale_keys.g.dart';
import 'bottom_nav.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

 String url ='http://eibtekone-001-site18.atempurl.com/api/GetAll_Countries';
 var _country=[];
 String? country;
 final userData =GetStorage();
 Future<CountryModel?> getData()async{
   var response=await http.get(Uri.parse(url));
   if(response.statusCode==200){
     var jsonResponse= jsonDecode(response.body.toString());

     setState(() {
       _country=jsonResponse['Records'];
     });

     print('date${_country}');
     print('datewwww${jsonResponse['Records'][0]}');
   }

 }
 // Future<CountryModel?> getData2()async{
 //   var request = http.Request('GET', Uri.parse('http://eibtekone-001-site18.atempurl.com/api/GetAll_Countries'));
 //
 //
 //   var streamedResponse  = await request.send();
 //   var response   = await http.Response.fromStream(streamedResponse);
 //   final result = jsonDecode(response .body) as Map<String, dynamic>;
 //
 //   if (response.statusCode == 200) {
 //     print(result['records']);
 //   }
 //   else {
 //     print(response.reasonPhrase);
 //   }
 //
 // }
  @override
  void initState() {
    super.initState();
    getData();
  }



  SearchScreen() {

    _selectvalueCity2 = _itemsCity2[0];

  }

  final _itemsCity2 = ['المنطقه',  'المحله الكبري',  'بسيون', 'كفر الزيات'];

  String? _selectvalueCity2 = 'المنطقه';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(

          children: [
            Image(image: AssetImage('assets/m.png'),fit: BoxFit.cover,),
           Padding(
             padding: EdgeInsets.only(top: 200.h),
              child: Center(child: Icon(Icons.location_on_outlined,color:Styles.defualtColor,size: 30.sp,)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 410.h),
              child: Column(
                children: [
                  Container(
                    height: 280.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Styles.defaultColor5,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.r),topLeft: Radius.circular(15.r)),
                    ),
                    child: Padding(
                      padding:   EdgeInsets.symmetric(vertical: 5.h ),
                      child: Column(
                        children: [

                          Container(

                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:   BorderRadius.circular(10.r),

                            ),
                            height: 3.5.h,
                            width: 40.h,
                          ),
                          Gap(15.h),
                          Text(LocaleKeys.Set_the_default_location.tr(),style: TextStyle(
                            fontSize: 17.sp,
                          ),),
                          Gap(20.h),


                          Padding(
                            padding:EdgeInsets.symmetric(horizontal: 20.h),
                            child: DropdownButtonFormField(
                              hint: Text('choose'),
                              value: country,
                              items:_country.map((e) {
                                return DropdownMenuItem<String>(
                                  onTap: (){
                                    print(e['Id']);
                                    userData.write('country', e['Id']);
                                    print(userData.read('country'));
                                    
                                  },
                                     value:e['Cont_Name'] ,
                                    child: Text(e['Cont_Name'])

                                );
                              }).toList(),
                              onChanged:(val){
                                setState(() {
                                  country=val!;
                                  print(country);


                                });
                              },


                              icon: Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.transparent,
                                ),
                              ),
                              decoration: InputDecoration(
                                fillColor: Color(0xffF5F5F5),
                                filled: true,
                                floatingLabelBehavior:
                                FloatingLabelBehavior.never,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                border: OutlineInputBorder(),
                                isDense: true,
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 15.h,vertical: 8.h),
                                //EdgeInsets.fromLTRB(24.h, 10.h, 20.h, 0.h),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),

                              ),
                            ),
                          ),
                          Gap(30.h),
                          Padding(
                            padding:   EdgeInsets.symmetric(horizontal: 20.h),
                            child: buildBottum(
                              height: 43,
                              decoration: BoxDecoration(
                                color: Styles.defualtColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: double.infinity,

                              text: Text(
                                LocaleKeys.Start_browsing_stores.tr(),
                                style: TextStyle(
                                  color: Styles.defaultColor5,
                                  fontSize: 16.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onTap: () {
                                userData.read('isLogged');
                                  Get.offAll(BottomNavScreen());
                                getData();
                                print(userData.read('country'));


                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),

    );
  }
}
