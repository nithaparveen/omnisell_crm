import 'package:flutter/material.dart';
import 'package:omnisell_crm/core/constants/textstyles.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String addedDate;
  final String lastActive;
  final String email;
  final String phone;

  const DetailCard({
    Key? key,
    required this.title,
    required this.addedDate,
    required this.lastActive,
    required this.email,
    required this.phone,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        elevation: 2,
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 90, 90, 213),
                              Color.fromARGB(255, 185, 78, 151),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight)),
                    child: const CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.person_outlined,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .05,
                  ),
                  Text(title.toUpperCase(),
                      style: GLTextStyles.cabinStyle(
                          size: 18, weight: FontWeight.w600))
                ],
              ),
              SizedBox(height: size.width * .04),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email :",
                          style: GLTextStyles.openSans(
                              size: 12,
                              weight: FontWeight.w300,
                              color: Colors.grey)),
                      Text(email)
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mobile :",
                        style: GLTextStyles.openSans(
                            size: 12,
                            weight: FontWeight.w300,
                            color: Colors.grey),
                      ),
                      Text(phone)
                    ],
                  )
                ],
              ),
              SizedBox(height: size.width * .04),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      child: Text(
                        "Added On",
                        style: GLTextStyles.openSans(
                            color: Colors.white,
                            size: 14,
                            weight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * .04),
                  Text(
                    addedDate,
                    style: GLTextStyles.openSans(
                        size: 15, weight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: size.width * .02),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 174, 221, 198),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, right: 10, left: 10),
                      child: Text(
                        "Last Active",
                        style: GLTextStyles.openSans(
                            color: Colors.black,
                            size: 13,
                            weight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(width: size.width * .04),
                  Text(
                    lastActive,
                    style: GLTextStyles.openSans(
                        size: 15, weight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
