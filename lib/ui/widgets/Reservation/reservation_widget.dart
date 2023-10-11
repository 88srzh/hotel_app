import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_app/domain/api_client/network_client.dart';
import 'package:hotel_app/domain/entity/reservation.dart';
import 'package:hotel_app/resources/app_colors.dart';
import 'package:hotel_app/resources/resources.dart';
import 'package:hotel_app/ui/components/custom_app_bar_widget.dart';
import 'package:hotel_app/ui/components/custom_bottom_navigation_bar.dart';
import 'package:hotel_app/ui/components/headline_text_widget.dart';
import 'package:hotel_app/ui/widgets/OrderPaid/order_paid_widget.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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

  @override
  Widget build(BuildContext context) {
    final _mobileFormatter = PhoneNumberTextInputFormatter();
    var phoneController = TextEditingController();
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var surnameController = TextEditingController();
    var birthdayController = TextEditingController();
    var citizenshipController = TextEditingController();
    var passwordNumberController = TextEditingController();
    var passwordValidityPeriodController = TextEditingController();
    String phone;
    String email;
    String name;
    String surname;
    String birthday;
    String citizenship;
    String passwordNumber;
    String passportValidityPeriod;
    final emailFormKey = GlobalKey<FormState>();
    final phoneFormKey = GlobalKey<FormState>();
    final nameKey = GlobalKey<FormState>();
    final surnameKey = GlobalKey<FormState>();
    final birthdayKey = GlobalKey<FormState>();
    final citizenshipKey = GlobalKey<FormState>();
    final passportNumberKey = GlobalKey<FormState>();
    final passportValidityPeriodKey = GlobalKey<FormState>();

    // TODO need to fix to normal formula with formatter may be?
    final String startTourPrice = reservation.tourPrice.toStringAsFixed(4).substring(0, 3);
    final String endTourPrice = reservation.tourPrice.toStringAsFixed(4).substring(3, 6);
    final String fuelCharge = reservation.fuelCharge.toString();
    final String serviceCharge = reservation.serviceCharge.toString();
    final String payable = (reservation.tourPrice + reservation.fuelCharge + reservation.serviceCharge).toString();

    return Scaffold(
      // TODO add to separate widget
      appBar: const CustomAppBarWidget(title: 'Бронирование'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            Container(
              height: 120.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    // TODO add to separate widget
                    Container(
                      height: 29.0,
                      width: 153.0,
                      decoration: const BoxDecoration(
                        color: AppColors.orangeBackground,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: AppColors.orangeText, size: 15),
                            Text(
                              reservation.horating.toString(),
                              // TODO add to separate widget
                              style: const TextStyle(color: AppColors.orangeText, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              reservation.ratingName,
                              style: const TextStyle(color: AppColors.orangeText, fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
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
            // information about customer
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
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
                      _mobileFormatter,
                    ],
                    maxLength: 15,
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
                    key: emailFormKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите текст';
                      }
                      return null;
                    },
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
            // first customer
            const SizedBox(height: 10.0),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const HeadlineTextWidget(text: 'Первый турист'),
                      Image.asset(AppImages.upArrow),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: nameController,
                    key: nameKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Имя';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      name = value;
                    },
                    keyboardType: TextInputType.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: textFormFieldDecorationWidget('Имя'),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    key: surnameKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Фамилия';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: textFormFieldDecorationWidget('Фамилия'),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    key: birthdayKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Дата рождения';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.datetime,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: textFormFieldDecorationWidget('Дата рождения'),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    key: citizenshipKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Гражданство';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: textFormFieldDecorationWidget('Гражданство'),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    key: passportNumberKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Номер паспорта';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: textFormFieldDecorationWidget('Номер паспорта'),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    key: passportValidityPeriodKey,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Срок действия загранпаспорта';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    decoration: textFormFieldDecorationWidget('Срок действия загранпаспорта'),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeadlineTextWidget(text: 'Второй турист'),
                    Image.asset(AppImages.downArrow),
                  ],
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
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeadlineTextWidget(text: 'Добавить туриста'),
                    Image.asset(AppImages.addArrow),
                  ],
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
                padding: const EdgeInsets.symmetric(vertical: 10.0),
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
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        text: 'Оплатить $payable ₽',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const OrderPaidWidget()));
        },
      ),
    );
  }

  InputDecoration textFormFieldDecorationWidget(String text) {
    return InputDecoration(
      errorText: 'Поле обязательно для заполнения',
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      labelText: text,
      labelStyle: const TextStyle(color: AppColors.formLabelTextColor, fontSize: 12, fontWeight: FontWeight.w400),
    );
  }
}

class CustomAppBarWithNavigatorPop extends StatelessWidget {
  const CustomAppBarWithNavigatorPop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Бронирование',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Image.asset(AppImages.backwardArrow),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
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
