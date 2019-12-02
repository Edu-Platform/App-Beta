import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'place.dart';

class StubData {
  static const List<Place> places = [
    Place(
      id: '1',
      latLng: LatLng(37.3496733,127.1090892),
      name: '솔루션수학학원 중등부',
      description:
          'Beers brewed on-site & gourmet pub grub in a converted auto-body shop with a fireplace & wood beams.',
      category: PlaceCategory.favorite,
      starRating: 5,
    ),
    Place(
      id: '2',
      latLng: LatLng(37.351591,127.1047463),
      name: '수학대가 미금캠퍼스',
      description:
          'Popular counter-serve offering pho, banh mi & other Vietnamese favorites in a stylish setting.',
      category: PlaceCategory.favorite,
      starRating: 5,
    ),
  ];

  static const List<String> reviewStrings = [
    '이번 중간고사에서 혜영쌤 덕분에 점수 많이 올랐어요!',
    '졸립지 않고 재미있게 가르쳐 주십니다.',
    'Best. Place. In. Town. Period.'
  ];
}
