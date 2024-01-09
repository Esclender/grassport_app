import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/components/counter_timer.dart';
import 'package:grassport_app/presentation/styles/colors.dart';
import 'package:gap/gap.dart';

class CodeConfirmationWidget extends StatefulWidget {
  final Function onCodeConfirmed;
  final Function onCancel;
  final int code;
  final int expirationTime;
  final String phoneNumber;

  CodeConfirmationWidget({
    required this.onCodeConfirmed,
    required this.onCancel,
    required this.code,
    required this.expirationTime,
    required this.phoneNumber,
  });

  @override
  _CodeConfirmationWidgetState createState() => _CodeConfirmationWidgetState();
}

class _CodeConfirmationWidgetState extends State<CodeConfirmationWidget> {
  final TextEditingController _confirmarCodeController =
      TextEditingController();

  isValidCode() async {
    if (int.tryParse(_confirmarCodeController.text) == widget.code) {
      await widget.onCodeConfirmed();
    } else {
      widget.onCancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: c8,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 230,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CountdownTimer(
                durationInSeconds: widget.expirationTime,
                onFinish: isValidCode),
            RichText(
              text: TextSpan(
                style: TextStyle(color: c1),
                text: 'Ingresa el codigo enviado a tu numero:',
                children: [
                  TextSpan(
                    text: ' +51${widget.phoneNumber}',
                    style: TextStyle(fontWeight: FontWeight.bold, color: c1),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: c1,
                    width: 2.0,
                  ),
                ),
              ),
              child: TextField(
                controller: _confirmarCodeController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await isValidCode();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                  ),
                  icon: Icon(
                    Icons.person_add,
                    color: c8,
                  ),
                  label: Text(
                    'Confirmar',
                    style: TextStyle(color: c8),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    widget.onCancel();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                  ),
                  icon: Icon(
                    Icons.cancel,
                    color: c8,
                  ),
                  label: Text(
                    'Cancelar',
                    style: TextStyle(color: c8),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
