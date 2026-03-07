import 'package:flutter/material.dart';
import 'package:mala3bna/core/utils/assets_data.dart';
import 'package:mala3bna/features/player/profile/models/my_booking_court_card_model.dart';
import 'package:mala3bna/features/player/profile/views/widgets/custome_court_card.dart';

class CourtCardListView extends StatelessWidget {
  const CourtCardListView({super.key});
  static const list = [
    MyBookingCourtCardModel(
      image: AssetsData.padelCourtBackGround,
      title: "Padel Court",
      date: 'Mon 28Oct',
      time: '08:00 PM - 09:00 PM',
      paidStatus: true,
      sportsIconType: 'padel',
    ),
    MyBookingCourtCardModel(
      image: AssetsData.padelCourtBackGround,
      title: "Padel Court",
      date: 'Mon 28Oct',
      time: '08:00 PM - 09:00 PM',
      paidStatus: true,
      sportsIconType: 'padel',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return CustomeCourtCard(myBookingCourtCardModel: list[index]);
      },
    );
  }
}
