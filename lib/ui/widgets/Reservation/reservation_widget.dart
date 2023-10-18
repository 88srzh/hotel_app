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

  TextEditingController nameController = TextEditingController();
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

  // List<dynamic> dynamicValue = List<dynamic>.from(afterTwoNames);

  void addTourist() {
    setState(() {
      names.insert(2, listOfTourists[1]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final _mobileFormatter = PhoneNumberTextInputFormatter();
    final emailFormKey = GlobalKey<FormState>();
    final phoneFormKey = GlobalKey<FormState>();

    // TODO need to fix to normal formula with formatter may be?
    final String startTourPrice = reservation.tourPrice.toStringAsFixed(4).substring(0, 3);
    final String endTourPrice = reservation.tourPrice.toStringAsFixed(4).substring(3, 6);
    final String fuelCharge = reservation.fuelCharge.toString();
    final String serviceCharge = reservation.serviceCharge.toString();
    final String payable = (reservation.tourPrice + reservation.fuelCharge + reservation.serviceCharge).toString();

    String email;

    var maskFormatter = MaskTextInputFormatter(
      mask: '* (***) ***-**-**',
      filter: {"*": RegExp(r'[0-9]')},
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
                      ReservationBlackDataText(reservation: reservation.room),
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
                    key: phoneFormKey,
                    onChanged: (phone) {
                      // print(phone.completeNumber);
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      maskFormatter,
                      // _mobileFormatter,
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
                          customTouristTextFormField('Имя', 'Имя', Keys.nameKey),
                          const SizedBox(height: 10.0),
                          customTouristTextFormField('Фамилия', 'Фамилия', Keys.surnameKey),
                          const SizedBox(height: 10.0),
                          customTouristTextFormField('Дата рождения', 'Дата рождения', Keys.birthdayKey),
                          const SizedBox(height: 10.0),
                          customTouristTextFormField('Гражданство', 'Гражданство', Keys.citizenshipKey),
                          const SizedBox(height: 10.0),
                          customTouristTextFormField('Номер паспорта', 'Номер паспорта', Keys.passportNumber),
                          const SizedBox(height: 10.0),
                          customTouristTextFormField('Срок действия загранпаспорта', 'Срок действия загранпаспорта', Keys.passportValidityPeriod),
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
                  ReservationTourPrices(header: 'Тур', amount: '$startTourPrice $endTourPrice ₽'),
                  const SizedBox(height: 10.0),
                  ReservationTourPrices(header: 'Топливный сбор', amount: '$fuelCharge ₽'),
                  const SizedBox(height: 10.0),
                  ReservationTourPrices(header: 'Сервисный сбор', amount: '$serviceCharge ₽'),
                  const SizedBox(height: 10.0),
                  ReservationTourPrices(header: 'К оплате', amount: '$payable ₽'),
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
          if (Keys.nameKey.currentState == null &&
              Keys.surnameKey.currentState == null &&
              Keys.birthdayKey.currentState == null &&
              Keys.citizenshipKey.currentState == null &&
              Keys.passportNumber.currentState == null &&
              Keys.passportValidityPeriod.currentState == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Не все поля заполнены')));
          } else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPaidWidget()));
          }
        },
      ),
    );
  }

  TextFormField customTouristTextFormField(String validate, String textFormField, GlobalKey key) {
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
      keyboardType: TextInputType.name,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      decoration: textFormFieldDecorationWidget(textFormField),
    );
  }
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

class ReservationTourPrices extends StatelessWidget {
  const ReservationTourPrices({
    super.key,
    required this.header,
    required this.amount,
  });

  final String header;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header,
          style: const TextStyle(fontSize: 16, color: AppColors.greyText, fontWeight: FontWeight.w400),
        ),
        Text(
          amount,
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}

class ReservationBlackDataText extends StatelessWidget {
  const ReservationBlackDataText({
    super.key,
    required this.reservation,
  });

  final String reservation;

  @override
  Widget build(BuildContext context) {
    return Text(
      reservation,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
  }
}

class ReservationGreyDataText extends StatelessWidget {
  const ReservationGreyDataText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.greyText),
      ),
    );
  }
}

class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 2) {
      newText.write('${newValue.text.substring(0, usedSubstringIndex = 1)}-');
      if (newValue.selection.end >= 2) {
        selectionIndex += 1;
      }
    }
    if (newTextLength >= 5) {
      newText.write('${newValue.text.substring(1, usedSubstringIndex = 4)}-');
      if (newValue.selection.end >= 5) {
        selectionIndex++;
      }
    }
    if (newTextLength >= 8) {
      newText.write('${newValue.text.substring(4, usedSubstringIndex = 7)}-');
      if (newValue.selection.end >= 8) {
        selectionIndex++;
      }
    }
    if (newTextLength >= 9) {
      newText.write('${newValue.text.substring(7, usedSubstringIndex = 9)}-');
      if (newValue.selection.end >= 9) {
        selectionIndex++;
      }
    }
    if (newTextLength >= 12) {
      newText.write(newValue.text.substring(9, usedSubstringIndex = 11));
      if (newValue.selection.end >= 12) {
        selectionIndex++;
      }
    }
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class TouristExpansionTile extends StatefulWidget {
  const TouristExpansionTile({super.key});

  @override
  State<TouristExpansionTile> createState() => _TouristExpansionTileState();
}

class _TouristExpansionTileState extends State<TouristExpansionTile> {
  final List<Map<String, dynamic>> _texts = List.generate(10, (index) => {});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Keys {
  static final nameKey = GlobalKey<FormState>();
  static final surnameKey = GlobalKey<FormState>();
  static final birthdayKey = GlobalKey<FormState>();
  static final citizenshipKey = GlobalKey<FormState>();
  static final passportNumber = GlobalKey<FormState>();
  static final passportValidityPeriod = GlobalKey<FormState>();
}
