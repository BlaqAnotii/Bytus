import 'package:bytuswallet/base/base_ui.dart';
import 'package:bytuswallet/constants/colors.dart';
import 'package:bytuswallet/services/auth_view_services.dart';
import 'package:bytuswallet/util/app_button.dart';
import 'package:bytuswallet/util/size_config.dart';
import 'package:country_state_picker/components/index.dart';
import 'package:country_state_picker/country_state_picker.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  //final _formKey = GlobalKey<FormState>();
  final TextEditingController phone = TextEditingController();
  final TextEditingController dob = TextEditingController();
  final TextEditingController city = TextEditingController();

  String? state;
  String? country;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    double height = SizeConfig.screenH!;
    return BaseView<AuthViewModel>(
        onModelReady: (model) {},
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: black,
            body: SingleChildScrollView(
              child: Form(
                key: model.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      height: height * .25,
                      color: black,
                      child: Image.asset(
                        "assets/images/bytus3.jpg",
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      width: width,
                      clipBehavior: Clip.none,
                      decoration: const BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 2.h,
                          ),
                          Text(
                            'Personal Information',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Enter your Personal Information.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: grey,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 7),
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                controller: model.phone,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.call),
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Mulish",
                                  ),

                                  contentPadding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 5,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 0.3,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  hintText: "+44 3844855900",

                                  //enabledBorder: InputBorder.none),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Phone Number is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 7),
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                controller: model.dob,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.date_range),
                                  hintStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Mulish",
                                  ),

                                  contentPadding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    left: 5,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      width: 0.3,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  hintText: "1989-02-10 (Date of Birth)",

                                  //enabledBorder: InputBorder.none),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Date is Required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 6.w,
                              right: 6.w,
                            ),
                            child: CountryStatePicker(
                              countryLabel: const Label(title: "Country"),
                              stateLabel: const Label(title: "State"),
                              onCountryChanged: (ct) => setState(() {
                                model.country = ct;
                                model.state = null;
                              }),
                              onStateChanged: (st) => setState(() {
                                model.state = st;
                              }),
                              // A little Spanish hint
                              countryHintText: "United States",
                              stateHintText: "Georgia",
                              noStateFoundText: "No State Found!",
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 5.w,
                              right: 5.w,
                            ),
                            child: AppButton(
                              color: black,
                              text: 'Next Step',
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (model.formKey.currentState!.validate()) {
                                  model.processUpdateInfo();
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
