import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/assets_data.dart';
import 'package:mala3bna/features/player/profile/models/my_booking_court_card_model.dart';
import 'package:mala3bna/features/player/profile/views/widgets/custome_court_card.dart';

class CourtCardListView extends StatelessWidget {
  const CourtCardListView({super.key});
  static const list = [
    MyBookingCourtCardModel(
      image: AssetsData.padelCourtBackGround,
      title: "The Padel Point - Court 2",
      date: 'Mon 28Oct',
      time: '08:00 PM - 09:00 PM',
      paidStatus: true,
      sportsIconType: 'padel',
    ),
    MyBookingCourtCardModel(
      image: AssetsData.footballCourtBackGround,
      title: "Smash Club - Football",
      date: 'Mon 28Oct',
      time: '08:00 PM - 09:00 PM',
      paidStatus: false,
      sportsIconType: 'football',
    ),
    MyBookingCourtCardModel(
      image: AssetsData.footballCourtBackGround,
      title: "Smash Club - Football",
      date: 'Mon 28Oct',
      time: '08:00 PM - 09:00 PM',
      paidStatus: true,
      sportsIconType: 'football',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: CustomeCourtCard(myBookingCourtCardModel: list[index]),
        );
      },
    );
  }
}
