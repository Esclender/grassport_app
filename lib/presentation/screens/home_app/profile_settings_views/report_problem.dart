import 'package:flutter/material.dart';
import 'package:grassport_app/presentation/components/buttons.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class ReportProblem extends StatefulWidget {
  const ReportProblem({super.key});

  @override
  State<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Wrap(
            alignment: WrapAlignment.end,
            runSpacing: 10.0,
            children: [
              const Field(),
              const Field(),
              const Field(),
              TextField(
                maxLines: 8, //or null
                decoration: InputDecoration(
                  hintText: "Describe tu problema",
                  filled: true,
                  fillColor: c12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: CustomButton(
                  next: () {},
                  text: Text(
                    "Enviar",
                    style: TextStyle(color: c1),
                  ),
                  bg: c8,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Field extends StatelessWidget {
  const Field({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      next: () {},
      text: Row(
        children: [
          Text(
            "Sube una foto de tu problema",
            style: TextStyle(color: c18),
          ),
          Icon(
            Icons.upload,
            color: c18,
          )
        ],
      ),
      bg: c12,
    );
  }
}
