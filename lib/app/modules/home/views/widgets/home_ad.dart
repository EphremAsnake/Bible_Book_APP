import 'package:flutter/material.dart';

class HomeAD extends StatelessWidget {
  const HomeAD({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffEEEDED),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 8), // horizontal, vertical offset
              ),
              BoxShadow(
                color: Color(0xffEEEDED),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, -8), // horizontal, vertical offset
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Expanded(
                  child: Text(
                    "Buy our premium app with many features.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff7B5533),
                    border: Border.all(
                      color: const Color(0xff7B5533).withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.0, horizontal: 15),
                    child: Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
