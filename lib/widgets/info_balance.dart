import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoBalance extends StatelessWidget {
  const InfoBalance({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double containerHeight = 80;
    double iconSize = screenWidth * 0.08; 
    double textFontSize = screenWidth * 0.045; 

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF00A86B),
              borderRadius: BorderRadius.circular(30),
            ),
            height: containerHeight,
            child: Container(
              padding: EdgeInsets.all(12),
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12), 
                      child: SvgPicture.asset(
                        'assets/icons/income.svg',
                        width: iconSize,
                        height: iconSize,
                      ),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Income",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
                Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFD3C4A),
              borderRadius: BorderRadius.circular(30),
            ),
            height: containerHeight,
            child: Container(
              padding: EdgeInsets.all(12),
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12), 
                      child: SvgPicture.asset(
                        'assets/icons/expense.svg',
                        width: iconSize,
                        height: iconSize,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Expenses",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                           fontSize: 15
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
