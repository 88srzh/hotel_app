import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_app/domain/api_client/network_client.dart';
import 'package:hotel_app/domain/entity/reservation.dart';
import 'package:hotel_app/resources/app_colors.dart';
import 'package:hotel_app/resources/resources.dart';
import 'package:hotel_app/ui/components/custom_app_bar_widget.dart';
import 'package:hotel_app/ui/components/custom_bottom_navigation_bar.dart';
import 'package:hotel_app/ui/components/five_star_row.dart';
import 'package:hotel_app/ui/components/headline_text_widget.dart';
import 'package:hotel_app/ui/widgets/OrderPaid/order_paid_widget.dart';
import 'package:hotel_app/ui/widgets/Reservation/components/birthday_text_input_formatter.dart';
import 'package:hotel_app/ui/widgets/Reservation/components/keys.dart';
import 'package:hotel_app/ui/widgets/Reservation/components/phone_number_text_input_formatter.dart';
import 'package:hotel_app/ui/widgets/Reservation/components/reservation_black_data_text_widget.dart';
import 'package:hotel_app/ui/widgets/Reservation/components/reservation_grey_data_text_widget.dart';
import 'package:hotel_app/ui/widgets/Reservation/components/reservation_tour_prices_text_widget.dart';
import 'package:hotel_app/ui/widgets/Reservation/components/upper_case_text_formatter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ReservationWidget extends StatefulWidget {
  const ReservationWidget({super.key});


  @override
  State<ReservationWidget> createState() => _ReservationWidgetState();
}

class _ReservationWidgetState extends State<ReservationWidget> {
  var reservation = const Reservation(
    id: 0,
    hotelName: '',
    hotelAdress: '',
    horating: 0,
    ratingName: '',
    departure: '',
    arrivalCountry: '',
    tourDateStart: '',
    tourDateStop: '',
    numberOfNights: 0,
    room: '',
    nutrition: '',
    tourPrice: 0,
    fuelCharge: 0,
    serviceCharge: 0,
  );

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();


  void getReservationData() async {
    final reservationJson = await getNetworkDataFromReservation();
    final dynamic reservationMap = json.decode(reservationJson);

    setState(() {
      reservation = Reservation.fromJson(reservationMap);
    });
  }

  @override
  void initState() {
    super.initState();
    getReservationData();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  bool customTileExpanded = false;

  final List<Widget> expansionTileWidget = <Widget>[];
  final List<void> expansionTile = <void>[];
  final List<String> names = <String>['Первый турист'];

  List<dynamic> listOfTourists = <dynamic>[
    'Первый турист',
    'Второй турист',
    'Третий турист',
    'Четвертый турист',
    'Пятый турист',
    'Шестой турист',
    'Седьмой турист',
    'Восьмой турист',
    'Девятый турист',
    'Десятый турист'
  ];

  void addTourist() {
    setState(() {
      names.insert(2, listOfTourists[1]);
    });
  }

  String? get _errorNameText {
    final text = nameController.value.text;

    if (text.isEmpty) {
      return 'Заполните имя';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    bool isError = false;
    bool isButtonPressed = false;
    final mobileFormatter = PhoneNumberTextInputFormatter();
    final emailFormKey = GlobalKey<FormState>();
    final phoneFormKey = GlobalKey<FormState>();

    // TODO need to fix to normal formula with formatter may be?
    final String tourPrice = "${reservation.tourPrice.toStringAsFixed(4).substring(0, 3)} ${reservation.tourPrice.toStringAsFixed(4).substring(3, 6)}";
    final String fuelCharge = reservation.fuelCharge.toString();
    final String serviceCharge = reservation.serviceCharge.toString();
    final String payable = (reservation.tourPrice + reservation.fuelCharge + reservation.serviceCharge).toString();

    String email;

    var passportFormatter = MaskTextInputFormatter(
      mask: '####-######',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    String? validateEmail(String? value) {
      const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
          r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
          r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
          r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
          r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
          r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
          r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
      final regex = RegExp(pattern);

      return value!.isNotEmpty && !regex.hasMatch(value) ? 'Enter a valid email address' : null;
    }

    String errorText = '';

    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Бронирование'),
      body: ListView(
        children: [
          Container(
            height: 120.0,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10.0),
                  FiveStarRowWidget(rating: reservation.horating.toString(), ratingName: reservation.ratingName),
                  const SizedBox(height: 10.0),
                  const HeadlineTextWidget(text: 'Steigenberger Makadi'),
                  Text(
                    reservation.hotelAdress,
                    style: const TextStyle(fontSize: 14, color: AppColors.blueText),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          ReservationDataWidget(reservation: reservation),
          // information about customer
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeadlineTextWidget(text: 'Информация о покупателе'),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    controller: phoneController,
                    key: phoneFormKey,
                    validator: (value) {
                      if (!isButtonPressed) {
                        return null;
                      }
                      isError = true;
                      if (value!.isEmpty) {
                        return 'Поле обязательно для заполнения';
                      } else {
                        return 'Неверный номер';
                      }
                      isError = false;
                    },
                    onChanged: (value) {
                      isButtonPressed = false;
                      if (isError) {
                        phoneFormKey.currentState?.validate();
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      // maskFormatter,
                      mobileFormatter,
                      // _newMobileFormatter,
                    ],
                    maxLength: 17,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Номер телефона',
                      labelStyle: TextStyle(color: AppColors.formLabelTextColor, fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    key: emailFormKey,
                    validator: validateEmail,
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: 'Почта',
                      labelStyle: TextStyle(color: AppColors.formLabelTextColor, fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const Text(
                    'Эти данные никому не передаются. После оплаты мы вышли чек на указанный вами номер и почту',
                    style: TextStyle(color: AppColors.greyText, fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          // first customer
          const SizedBox(height: 10.0),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: names.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    backgroundColor: Colors.transparent,
                    shape: const Border(),
                    onExpansionChanged: (bool expanded) {
                      setState(() {
                        customTileExpanded = expanded;
                      });
                    },
                    trailing: customTileExpanded ? Image.asset(AppImages.upArrow) : Image.asset(AppImages.downArrow),
                    tilePadding: const EdgeInsets.all(0),
                    title: Text(
                      listOfTourists[index],
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    children: [
                      Column(
                        children: [
                          customTouristNameAndSurnameTextFormField(Keys.nameKey, 'Имя', _errorNameText!),
                          const SizedBox(height: 10.0),
                          customTouristNameAndSurnameTextFormField(Keys.surnameKey, 'Фамилия', 'Поле не заполнено'),
                          const SizedBox(height: 10.0),
                          // Дата рождения
                          customTouristBirthdayAndPassportValidatePeriodTextFormField(Keys.birthdayKey, 'Дата рождения'),
                          const SizedBox(height: 10.0),
                          // Citizenship
                          TextFormField(
                            key: Keys.citizenshipKey,
                            // validator: (value) {
                            //   return null;
                            // },
                            onChanged: (value) {
                              setState(() {
                                if (value.contains(' ')) {
                                  errorText = 'Не используйте пробелы';
                                } else {
                                  errorText = '';
                                }
                              });
                            },
                            inputFormatters: [LengthLimitingTextInputFormatter(2), FilteringTextInputFormatter.singleLineFormatter, UpperCaseTextFormatter()],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            decoration: textFormFieldDecorationWidget('Гражданство', 'Поле не заполнено'),
                          ),
                          const SizedBox(height: 10.0),
                          // Passport number
                          TextFormField(
                            // focusNode: node,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            key: Keys.passportNumber,
                            validator: (value) {
                              return null;
                            },
                            onChanged: (value) {},
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11),
                              FilteringTextInputFormatter.singleLineFormatter,
                              passportFormatter,
                            ],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                            decoration: textFormFieldDecorationWidget('Номер паспорта', 'Поле не заполнено'),
                          ),
                          const SizedBox(height: 10.0),
                          customTouristBirthdayAndPassportValidatePeriodTextFormField(Keys.passportValidityPeriod, 'Срок действия загранпаспорта'),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          InkWell(
            onTap: () {
              addTourist();
            },
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeadlineTextWidget(text: 'Добавить туриста'),
                    Image.asset(AppImages.addArrow),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Column(
                children: [
                  ReservationTourPricesTextWidget(header: 'Тур', amount: '$tourPrice ₽', color: Colors.black),
                  const SizedBox(height: 10.0),
                  ReservationTourPricesTextWidget(header: 'Топливный сбор', amount: '$fuelCharge ₽', color: Colors.black),
                  const SizedBox(height: 10.0),
                  ReservationTourPricesTextWidget(header: 'Сервисный сбор', amount: '$serviceCharge ₽', color: Colors.black),
                  const SizedBox(height: 10.0),
                  ReservationTourPricesTextWidget(header: 'К оплате', amount: '$payable ₽', color: AppColors.roomDetailsTextColor),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        text: 'Оплатить $payable ₽',
        onPressed: () {
          // if (Keys.nameKey.currentState == null &&
          //     Keys.surnameKey.currentState == null &&
          //     Keys.birthdayKey.currentState == null &&
          //     Keys.citizenshipKey.currentState == null &&
          //     Keys.passportNumber.currentState == null &&
          //     Keys.passportValidityPeriod.currentState == null) {
          //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Не все поля заполнены')));
          // } else {
          nameController.value.text.isNotEmpty ? Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPaidWidget())) : null;
          // } else {
          //         Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPaidWidget()));
          // }
        },
      ),
    );
  }

  TextFormField customTouristBirthdayAndPassportValidatePeriodTextFormField(Key key, String text) {
    return TextFormField(
      key: key,
      validator: (value) {
        // TODO validator don't work
        return birthDateValidator(value!);
      },
      onChanged: (value) {},
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.singleLineFormatter,
        BirthTextInputFormatter(),
      ],
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: textFormFieldDecorationWidget(text, 'Поле не заполнено'),
    );
  }

  TextFormField customTouristNameAndSurnameTextFormField(Key key, String text, String errorText) {
    return TextFormField(
      controller: nameController,
      key: key,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return 'Пожалуйста заполните поле';
      //   }
      //   return null;
      // },
      onChanged: (value) {
        setState(() {
          if (value.contains(' ')) {
            errorText = 'Не используйте пробелы';
          } else {
            errorText = '';
          }
        });
      },
      inputFormatters: [
        FilteringTextInputFormatter.singleLineFormatter,
      ],
      keyboardType: TextInputType.name,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: textFormFieldDecorationWidget(text, errorText),
    );
  }

  TextFormField customTouristTextFormField(String validate, String textFormField, GlobalKey key, TextInputType type, String errorText) {
    return TextFormField(
      // controller: nameController,
      key: key,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Поле не заполнено';
        }
        return null;
      },
      onChanged: (value) {
        validate = value;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.singleLineFormatter,
        BirthTextInputFormatter(),
      ],
      keyboardType: type,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: textFormFieldDecorationWidget(textFormField, errorText),
    );
  }
}

class ReservationDataWidget extends StatelessWidget {
  const ReservationDataWidget({
    super.key,
    required this.reservation,
  });

  final Reservation reservation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                const ReservationGreyDataText(text: 'Вылет из'),
                ReservationBlackDataText(reservation: reservation.departure),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const ReservationGreyDataText(text: 'Страна, город'),
                ReservationBlackDataText(reservation: reservation.arrivalCountry),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const ReservationGreyDataText(text: 'Даты'),
                ReservationBlackDataText(reservation: '${reservation.tourDateStart} - ${reservation.tourDateStop}')
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const ReservationGreyDataText(text: 'Кол-во ночей'),
                ReservationBlackDataText(reservation: reservation.numberOfNights.toString()),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                const ReservationGreyDataText(text: 'Отель'),
                Expanded(child: ReservationBlackDataText(reservation: reservation.hotelName)),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const ReservationGreyDataText(text: 'Номер'),
                Expanded(child: ReservationBlackDataText(reservation: reservation.room)),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                const ReservationGreyDataText(text: 'Питание'),
                ReservationBlackDataText(reservation: reservation.nutrition),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

String? birthDateValidator(String value) {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy');
  final String formatted = formatter.format(now);
  String str1 = value;
  List<String> str2 = str1.split('/');
  String month = str2.isNotEmpty ? str2[0] : '';
  String day = str2.length > 1 ? str2[1] : '';
  String year = str2.length > 2 ? str2[2] : '';
  if (value.isEmpty) {
    return 'Дата рождения не заполнена';
  } else if (int.parse(month) > 13) {
    return 'Неверно указан месяц';
  } else if (int.parse(day) > 32) {
    return 'Неверно указан день';
  } else if ((int.parse(year) > int.parse(formatted))) {
    return 'Неверно указан год';
  } else if ((int.parse(year) < 1920)) {
    return 'Неверно указан год';
  }
  return null;
}

InputDecoration textFormFieldDecorationWidget(String text, String errorText) {
  return InputDecoration(
    errorText: errorText.isEmpty ? null : errorText,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    labelText: text,
    labelStyle: const TextStyle(color: AppColors.formLabelTextColor, fontSize: 12, fontWeight: FontWeight.w400),
  );
}
