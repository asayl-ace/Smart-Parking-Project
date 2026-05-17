import 'package:flutter/material.dart';
import 'package:parkliapp/features/home/models/place.dart';
import 'package:parkliapp/features/home/widgets/parking_card.dart';
import 'package:parkliapp/app_data.dart';

class VisitedParksSection extends StatelessWidget {
  final List<Place> visitedPlaces;

  const VisitedParksSection({
    super.key,
    required this.visitedPlaces,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppData.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppData.translate(
                'Your most visited car parks',
                'أكثر المواقف زيارة',
              ),
              style: const TextStyle(
                color: Color(0xFF1E7280),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            if (visitedPlaces.isEmpty)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFF6FCFD),
                      Color(0xFFEAF7F9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0x33237D8C),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 92,
                          height: 92,
                          decoration: BoxDecoration(
                            color: const Color(0x1A237D8C),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0x26237D8C),
                            ),
                          ),
                        ),
                        Container(
                          width: 66,
                          height: 66,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                blurRadius: 12,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.local_parking_rounded,
                            color: Color(0xFF237D8C),
                            size: 38,
                          ),
                        ),
                        Positioned(
                          right: AppData.isArabic ? null : 10,
                          left: AppData.isArabic ? 10 : null,
                          bottom: 8,
                          child: Container(
                            width: 26,
                            height: 26,
                            decoration: const BoxDecoration(
                              color: Color(0xFF34B5CA),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                      AppData.translate(
                        'No favorite visits yet',
                        'لا توجد مواقف مزارة حتى الآن',
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF195A64),
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppData.translate(
                        'Book your first parking spot and your most visited places will appear here.',
                        'احجز أول موقف لك، وبعدها ستظهر أكثر الأماكن التي تزورها هنا.',
                      ),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF677191),
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              )
            else
              ...List.generate(visitedPlaces.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index == visitedPlaces.length - 1 ? 0 : 14,
                  ),
                  child: ParkingCard(place: visitedPlaces[index]),
                );
              }),
          ],
        ),
      ),
    );
  }
}