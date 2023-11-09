import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_app/resources/app_colors.dart';
import 'package:hotel_app/resources/resources.dart';

class SubmitWidget extends StatefulWidget {
  const SubmitWidget({super.key, required this.onSubmit});

  final ValueChanged<String> onSubmit;

  @override
  State<SubmitWidget> createState() => _SubmitWidgetState();
}

class _SubmitWidgetState extends State<SubmitWidget> {
  final TextEditingController nameController = TextEditingController();
  String _name = '';
  bool _submitted = false;
  static final nameKey = GlobalKey<FormState>();
  bool customTileExpanded = false;
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

  void _submit() {
    setState(() => _submitted = true);
    if (nameKey.currentState!.validate()) {
      nameKey.currentState!.save();
      widget.onSubmit(_name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Form(
                  key: nameKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                        controller: nameController,
                        // key: key,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Пожалуйста заполните поле';
                          }
                          if (value.length < 4) {
                            return 'Слишком мало букв';
                          }
                          return null;
                        },
                        onChanged: (text) => setState(() => _name = text),
                        inputFormatters: [
                          FilteringTextInputFormatter.singleLineFormatter,
                        ],
                        keyboardType: TextInputType.name,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                        decoration: const InputDecoration(
                          // errorText: errorText.isEmpty ? null : errorText,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          labelText: 'Имя',
                          labelStyle: TextStyle(color: AppColors.formLabelTextColor, fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _name.isNotEmpty ? _submit : null;
                        },
                        child: const Text('Оплатить'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
