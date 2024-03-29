import 'package:flutter/material.dart';
import 'package:aster_hf/widgets/food_pills.dart';
import 'package:aster_hf/widgets/form_field_widgets.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class formScreen extends StatefulWidget {
  const formScreen({super.key});

  @override
  State<formScreen> createState() => _formScreenState();
}

class _formScreenState extends State<formScreen> {
  set value(String? value) {}
  final itemAmount = ["1", "2", "3", "4", "5"];
  final itemRepeat = ["1", "2", "3", "4"];
  final itemFrequency = [
    "Daily",
    "Alternate days",
    "Once a week",
    "Twice a week"
  ];
  final itemHowLong = ["Days", "Times"];
  final itemReminders = [
    "5 minutes before",
    "10 minutes before",
    "30 minutes before",
    "1 hours before"
  ];
  String valueAmount = "1";
  String valueRepeat = "1";
  String valueFrequency = "Daily";
  String valueHowLong = "Days";
  var valueReminder = "5 minutes before";
  var valueTime = "12:00 PM";
  var duringMealList = ['', 'Before Meal', 'During Meal', 'After Meal'];
  int duringMeal = 2;
  TextEditingController valueHowLongInt = TextEditingController();
  TextEditingController medicineNameController = TextEditingController();

  callbackAmount(varTopic) {
    setState(() {
      valueAmount = varTopic;
    });
  }

  callbackRepeat(varTopic) {
    setState(() {
      valueRepeat = varTopic;
    });
  }

  callbackFrequency(varTopic) {
    setState(() {
      valueFrequency = varTopic;
    });
  }

  callbackHowLong(varTopic) {
    setState(() {
      valueHowLong = varTopic;
    });
  }

  callbackReminder(varTopic) {
    setState(() {
      valueReminder = varTopic;
    });
  }

  callbackMeal(varTopic) {
    print(varTopic);
    setState(() {
      duringMeal = varTopic;
    });
  }

  callbackTime(varTopic) {
    setState(() {
      valueTime = varTopic;
    });
  }

  _register() async {
    var data = {
      'medicineName': medicineNameController.text,
      'amount': valueAmount,
      'repeat': valueRepeat,
      'frequency': valueFrequency,
      'howLong': valueHowLong,
      'foodAndPills': duringMealList[duringMeal],
      'reminder': valueReminder,
      'timeReminder': valueTime,
      'currentTime': DateTime.now(),
    };
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc('mauryakk2004@gmail.com')
          .collection('Reminder')
          .doc(medicineNameController.text)
          .set(data);
    } catch (e) {
      print(e);
    }
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(238, 241, 244, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 22,
            // color: Colors.black,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.close,
                size: 24,
              ))
        ],
        title: Center(
          child: Text(
            'Set Medication Reminder',
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'You can add reminders according to how the doctor has prescribed. Prescription automatically gets added if your doctor adds it to your account directly from his side',
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Color(0xff8C8E97),
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Heading(
                  heading: 'Medicine Name',
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.08,
                  child: TextField(
                    controller: medicineNameController,
                    style: const TextStyle(
                        color: Color(0xff8C8E97),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      hintText: 'Amaterm Softgel',
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon: SvgPicture.asset(
                        'assets/form_images/qr.svg',
                        fit: BoxFit.scaleDown,
                        height: 10,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 18,horizontal: 16),
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(140, 142, 151, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(224, 224, 224, 224),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
               
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        // height: max(height*0.09,67),
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                      child: DropdownWithHeading(
                        items: itemAmount,
                        nameController: valueAmount,
                        callbackFunction: callbackAmount,
                        width: width * 0.5,
                        heading: 'Amount',
                      ),
                    )),
                    Expanded(
                        // height: max(height*0.09,67),
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                      child: DropdownWithHeading(
                        items: itemRepeat,
                        nameController: valueRepeat,
                        callbackFunction: callbackRepeat,
                        width: width * 0.5,
                        heading: 'Repeat',
                      ),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        // height: max(height*0.09,67),
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                      child: DropdownWithHeading(
                        items: itemFrequency,
                        nameController: valueFrequency,
                        callbackFunction: callbackFrequency,
                        width: width * 0.5,
                        heading: 'Frequency',
                      ),
                    )),
                    Expanded(
                        // height: max(height*0.09,67),
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(7, 0, 0, 0),
                            // child: DropdownWithHeading(items: itemHowLong, nameController: valueHowLong, callbackFunction: callbackHowLong, width: width*0.5, heading: 'How Long',),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Heading(heading: 'How Long'),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: width * 0.5,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xff8C8E97),
                                      ),
                                      borderRadius: BorderRadius.circular(9)),
                                  child: Row(
                                    children: [
                                      // SizedBox(width: 3,),
                                      Flexible(
                                        child: TextField(
                                          controller: valueHowLongInt,
                                          style: const TextStyle(
                                            color: Color(0xff8C8E97),
                                          ),
                                          textAlign: TextAlign.center,
                                          decoration: const InputDecoration(
                                            hintText: '00',
                                            hintStyle: TextStyle(
                                              // fontSize: 16,
                                              color: Color(0xff8C8E97),
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: ButtonTheme(
                                            alignedDropdown: true,
                                            child: DropdownButton<String>(
                                              value: valueHowLong,
                                              onChanged: (String? value) {
                                                callbackHowLong(value!);
                                              },
                                              icon: const SizedBox.shrink(),
                                              items: itemHowLong.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xff8C8E97)),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ))),
                  ],
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                    height: max(height * 0.13, 103),
                    child: FoodAndPills(
                      height: max(height * 0.1, 80),
                      width: width * 0.27,
                      callbackFunction: callbackMeal,
                      whichTime: duringMeal,
                    )),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: max(height * 0.09, 67),
                      child: TimeContainer(
                        height: height * 0.055,
                        callbackTime: callbackTime,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                    height: max(height * 0.09, 75),
                    child: DropdownWithHeading(
                      items: itemReminders,
                      nameController: valueReminder,
                      callbackFunction: callbackReminder,
                      width: width,
                      heading: 'Remind me',
                    )),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    _register();
                  },
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: InkWell(
                      splashColor: const Color.fromRGBO(105, 92, 212, 0.8),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      onTap: ()  {
                        
                      },
                      child: Button(
                        text: 'Save Medication Reminder',
                        width: double.infinity,
                        fontsize: 16.sp,
                        fontweight: FontWeight.w600,
                        height: 50.h,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
