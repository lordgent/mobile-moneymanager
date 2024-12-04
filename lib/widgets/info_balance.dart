import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoBalance extends StatelessWidget {
  const InfoBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF00A86B),
              borderRadius: BorderRadius.circular(30),
            ),
            height: 80,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.all(10.0), 
                      child: SvgPicture.asset(
                        'assets/icons/income.svg',
                        width: 30.0,
                        height: 30.0, 
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Income",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18)),
                      Text("Rp 5.000.000",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 17))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFD3C4A), 
              borderRadius: BorderRadius.circular(30),
            ),
            height: 80,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.all(10.0), 
                      child: SvgPicture.asset(
                        'assets/icons/expense.svg',
                        width: 30.0,
                        height: 30.0, 
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Expenses",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 18)),
                      Text("Rp 35.000",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 17))
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
