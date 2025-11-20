import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/constant_colors.dart';

class OverviewCards extends ConsumerStatefulWidget{
  const OverviewCards({super.key});

  @override
  ConsumerState<OverviewCards> createState() => _OverviewCardsState();
}

class _OverviewCardsState extends ConsumerState<OverviewCards>{
  final List<CardInfo> cards = [
    CardInfo(icon: Icons.directions_car_outlined, title: "My Registered Vehicles", count: 3),
    CardInfo(icon: Icons.description_outlined, title: "Reports Submitted", count: 5),
    CardInfo(icon: Icons.search_outlined, title: "Pending Investigations", count: 1),
    CardInfo(icon: Icons.check_circle_outline, title: "Resolved Cases", count: 1)
  ];

  @override
  Widget build(BuildContext context){
    // overview cards
    return  Container(
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context, index){
            final card = cards[index];
            return Container(
              width: 220,
              margin: EdgeInsets.only(right: 15),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.grey.shade200,
                      blurRadius: 5, spreadRadius: 2, offset: Offset(0, 3))]
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ConstantColors.accentBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(card.icon, color: Colors.white, size: 35,),
                  ),
                  SizedBox(width: 15,),
                  Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(card.title, style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600
                          ),),
                          SizedBox(height: 6,),
                          Text(card.count.toString(), style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold
                          ),),

                        ],
                      )),
                ],
              ),
            );
          }),
    );
  }
}

// cards info class
class CardInfo{
final IconData icon;
final String title;
final int count;

CardInfo({required this.icon, required this.title, required this.count});
}