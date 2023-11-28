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
import 'package:hotel_app/ui/widgets/Reservation/components/reservation_black_data_text_widget.dart';
import 'package:hotel_app/ui/widgets/Reservation/components/reservation_grey_data_text_widget.dart';
import 'package:hotel_app/ui/widgets/Reservation/components/reservation_tour_prices_text_widget.dart';
import 'package:hotel_app/ui/widgets/Reservation/components/upper_case_text_formatter.dart';
import 'package:intl/intl.dart';

class ReservationWidget extends StatefulWidget {
  const ReservationWidget({super.key, required this.onSubmit});

  final ValueChanged<List<String>> onSubmit;

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

  bool customTileExpanded = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _citizenshipController = TextEditingController();
  final _passwordNumberController = TextEditingController();
  final _validityPassportPeriodController = TextEditingController();

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

  List<dynamic> listOfNameKeys = <dynamic>[
    Keys.nameKey1,
    Keys.nameKey2,
    Keys.nameKey3,
    Keys.nameKey4,
    Keys.nameKey5,
    Keys.nameKey6,
    Keys.nameKey7,
  ];

  List<dynamic> listOfSurnameKeys = <dynamic>[
    Keys.surnameKey1,
    Keys.surnameKey2,
    Keys.surnameKey3,
    Keys.surnameKey4,
    Keys.surnameKey5,
    Keys.surnameKey6,
    Keys.surnameKey7
  ];

  List<dynamic> listOfBirthdayKeys = <dynamic>[
    Keys.birthdayKey1,
    Keys.birthdayKey2,
    Keys.birthdayKey3,
    Keys.birthdayKey4,
    Keys.birthdayKey5,
    Keys.birthdayKey6,
    Keys.birthdayKey7
  ];

  List<dynamic> listOfCitizenshipKeys = <dynamic>[
    Keys.citizenshipKey1,
    Keys.citizenshipKey2,
    Keys.citizenshipKey3,
    Keys.citizenshipKey4,
    Keys.citizenshipKey5,
    Keys.citizenshipKey6,
    Keys.citizenshipKey7,
  ];

  List<dynamic> listOfPassportNumberKeys = <dynamic>[
    Keys.passportNumber1,
    Keys.passportNumber2,
    Keys.passportNumber3,
    Keys.passportNumber4,
    Keys.passportNumber5,
    Keys.passportNumber6,
    Keys.passportNumber7,
  ];

  List<dynamic> listOfPassportValidityPeriodKeys = <dynamic>[
    Keys.passportValidityPeriod1,
    Keys.passportValidityPeriod2,
    Keys.passportValidityPeriod3,
    Keys.passportValidityPeriod4,
    Keys.passportValidityPeriod5,
    Keys.passportValidityPeriod6,
    Keys.passportValidityPeriod7,
  ];

  void addTourist() {
    setState(() {
      names.insert(1, listOfTourists[1]);
    });
  }

  bool _submitted = false;
  String _name = '';
  String _surname = '';
  String _birthday = '';
  String _citizenship = '';
  String _passportNumber = '';
  String _validityPassportPeriod = '';
  String phone = '';

  void _submit() {
    setState(() => _submitted = true);
    // if (Keys.nameKey1.currentState != null && Keys.surnameKey1.currentState != null) {
    //   widget.onSubmit([_name, _surname]);
    // }
    if (Keys.passportNumber1.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPaidWidget()));
    }
    // if (Keys.nameKey.currentState!.validate()) {
    //   widget.onSubmit(_name);
    // }
  }

  @override
  Widget build(BuildContext context) {
    // bool isError = false;
    // bool isButtonPressed = false;
    // final mobileFormatter = PhoneNumberTextInputFormatter();
    final emailFormKey = GlobalKey<FormState>();
    final phoneFormKey = GlobalKey<FormState>();

    // TODO need to fix to normal formula with formatter may be?
    final String tourPrice = '${reservation.tourPrice.toStringAsFixed(4).substring(0, 3)} ${reservation.tourPrice.toStringAsFixed(4).substring(3, 6)}';
    final String fuelCharge = '${reservation.fuelCharge.toStringAsFixed(4).substring(0, 1)} ${reservation.fuelCharge.toStringAsFixed(4).substring(1, 4)}';
    final String serviceCharge =
        '${reservation.serviceCharge.toStringAsFixed(4).substring(0, 1)} ${reservation.serviceCharge.toStringAsFixed(4).substring(1, 4)}';
    final payable = (reservation.tourPrice + reservation.fuelCharge + reservation.serviceCharge);
    final String payableWithFormatter = '${payable.toStringAsFixed(4).substring(0, 3)} ${payable.toStringAsFixed(4).substring(3, 6)}';

    String email;

    // var passportFormatter = MaskTextInputFormatter(
    //   mask: '####-######',
    //   filter: {"#": RegExp(r'[0-9]')},
    //   type: MaskAutoCompletionType.lazy,
    // );

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

    String? validatePhoneNumber(String? value) {
      const phoneNumberPattern = '^(?:[+0]9)?[0-9]{10}';
      final regex = RegExp(phoneNumberPattern);
      return null;
    }

    String? validateNameAndSurname(String? value) {
      if (value!.contains(RegExp(r'[0-9]'))) {
        return 'Поле не может содержать цифры';
      }
      return null;
    }

    String? validateCitizenship(String? value) {
      if (value!.contains(RegExp(r'[0-9]'))) {
        return 'Поле не может содержать цифры';
      } else if (value.length > 2) {
        return 'Не может быть более двух символов';
      }
      return null;
    }

    String? validatePassportNumber(String? value) {
      if (value!.length < 10) {
        return 'Должно быть 10 цифр';
      } else if (value.contains(RegExp('[a-zA-Z]'))) {
        return 'Поле не может содержать буквы';
      }
      return null;
    }

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
          Container(
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
          ),
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
                    // validator: (value) {
                    //   phone = value!;
                    //   return null;
                    // },
                    validator: validatePhoneNumber,
                    onChanged: (value) {
                      phone = value;
                    },
                    // onChanged: (value) {
                    //   isButtonPressed = false;
                    //   if (isError) {
                    //     phoneFormKey.currentState?.validate();
                    // }
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                      // mobileFormatter,
                    ],
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
                    controller: emailController,
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
                          customTouristsTextFormField(
                            _nameController,
                            listOfNameKeys,
                            index,
                            validateNameAndSurname,
                            'Имя',
                            (value) => setState(() => _name = _nameController.text),
                            [FilteringTextInputFormatter.singleLineFormatter],
                            TextInputType.name,
                          ),
                          const SizedBox(height: 10.0),
                          customTouristsTextFormField(
                            _surnameController,
                            listOfSurnameKeys,
                            index,
                            validateNameAndSurname,
                            'Фамилия',
                            (value) => setState(() => _surname = _surnameController.text),
                            [FilteringTextInputFormatter.singleLineFormatter],
                            TextInputType.name,
                          ),
                          const SizedBox(height: 10.0),
                          // Дата рождения
                          customTouristsTextFormField(
                            _birthdayController,
                            listOfBirthdayKeys,
                            index,
                            birthdayValidator,
                            'Дата рождения',
                            (value) => setState(() => _birthday = _birthdayController.text),
                            [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.singleLineFormatter, BirthTextInputFormatter()],
                            TextInputType.number,
                          ),
                          // customTouristBirthdayAndPassportValidatePeriodTextFormField(listOfBirthdayKeys, index, birthdayValidator, 'Дата рождения',
                          //         (value) => setState(() => _birthday = value!), TextInputType.number),
                          const SizedBox(height: 10.0),
                          customTouristsTextFormField(
                            _citizenshipController,
                            listOfCitizenshipKeys,
                            index,
                            validateCitizenship,
                            'Гражданство',
                            (value) => setState(() => _citizenship = _citizenshipController.text),
                            [LengthLimitingTextInputFormatter(2), FilteringTextInputFormatter.singleLineFormatter, UpperCaseTextFormatter()],
                            TextInputType.text,
                          ),
                          const SizedBox(height: 10.0),
                          // Passport number
                          customTouristsTextFormField(
                            _passwordNumberController,
                            listOfPassportNumberKeys,
                            index,
                            validatePassportNumber,
                            'Номер загранпаспорта',
                            // if enabled, it gives an error Invalid radix-10 number (at character 1)
                            (value) => setState(() => _passportNumber = _passwordNumberController.text),
                            [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.singleLineFormatter],
                            TextInputType.name,
                          ),
                          const SizedBox(height: 10.0),
                          customTouristsTextFormField(
                            _validityPassportPeriodController,
                            listOfPassportValidityPeriodKeys,
                            index,
                            birthdayValidator,
                            'Срок действия загранспаспорта',
                            (value) => setState(() => _validityPassportPeriod = _validityPassportPeriodController.text),
                            [LengthLimitingTextInputFormatter(10), FilteringTextInputFormatter.singleLineFormatter, BirthTextInputFormatter()],
                            TextInputType.number,
                          ),
                          // customTouristBirthdayAndPassportValidatePeriodTextFormField(Keys.passportValidityPeriod, 'Срок действия загранпаспорта'),
                          // const SizedBox(height: 10.0),
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
                  ReservationTourPricesTextWidget(header: 'К оплате', amount: '$payableWithFormatter ₽', color: AppColors.roomDetailsTextColor),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        text: 'Оплатить $payableWithFormatter ₽',
        // onPressed: () {

        // if (Keys.nameKey.currentState == null &&
        //     Keys.surnameKey.currentState == null &&
        //     Keys.birthdayKey.currentState == null &&
        //     Keys.citizenshipKey.currentState == null &&
        //     Keys.passportNumber.currentState == null &&
        //     Keys.passportValidityPeriod.currentState == null) {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Не все поля заполнены')));
        // } else {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPaidWidget()));
        // }
        onPressed: _name.isNotEmpty &&
                _surname.isNotEmpty &&
                _birthday.isNotEmpty &&
                _citizenship.isNotEmpty &&
                _passportNumber.isNotEmpty &&
                _validityPassportPeriod.isNotEmpty
            ? _submit
            : null,
        // },
      ),
    );
  }

  TextFormField customTouristsTextFormField(TextEditingController controller, List<dynamic> listKey, int index, FormFieldValidator<String?> validator,
      String title, ValueChanged<String?> onChanged, List<TextInputFormatter>? inputFormatters, TextInputType textInputType) {
    return TextFormField(
      autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      controller: controller,
      key: listKey[index],
      validator: validator,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      keyboardType: textInputType,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: textFormFieldDecorationWidget(title),
    );
  }

  String? birthdayValidator(String? value) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy');
    final String formatted = formatter.format(now);
    String str1 = value!;
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

  InputDecoration textFormFieldDecorationWidget(String text) {
    return InputDecoration(
      // errorText: 'Поле обязательно для заполнения',
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      labelText: text,
      labelStyle: const TextStyle(color: AppColors.formLabelTextColor, fontSize: 12, fontWeight: FontWeight.w400),
    );
  }
}
