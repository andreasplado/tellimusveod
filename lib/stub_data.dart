// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'place.dart';

class StubData {
  static const List<Place> places = [
    Place(
      id: '1',
      latLng: LatLng(45.524676, -122.681922),
      name: 'Klaveri vedu',
      description:
          'Vea klaverit 12 korrusele Raadiku 2/1.',
      category: PlaceCategory.favorite,
      starRating: 5,
    ),
    Place(
      id: '2',
      latLng: LatLng(45.516887, -122.675417),
      name: 'Teleri vedu',
      description:
          'Vea telerit 3 korrusele Mahtra 50a-70..',
      category: PlaceCategory.favorite,
      starRating: 5,
    ),
    Place(
      id: '3',
      latLng: LatLng(45.528952, -122.698344),
      name: 'Playboy ajakirja tellimus',
      description:
          'Kiimas mees soovib näha playboy ajakirja ruttu Tõnismäe 2/4-34.',
      category: PlaceCategory.favorite,
      starRating: 5,
    ),
    Place(
      id: '4',
      latLng: LatLng(45.525253, -122.684423),
      name: 'Külmkapp',
      description:
          'Külmkapp lekib ja tahetakse kiirelt välja vahetada Maakri 7-8',
      category: PlaceCategory.favorite,
      starRating: 4,
    ),
    Place(
      id: '5',
      latLng: LatLng(45.513485, -122.657982),
      name: 'Mikrofon',
      description:
          'Räpparid soovivad osta AKG mikrofoni Kadrioru 56-7.',
      category: PlaceCategory.favorite,
      starRating: 4,
    ),
    Place(
      id: '6',
      latLng: LatLng(45.487137, -122.799940),
      name: 'Laud',
      description:
          'Kiiremas korras oleks vaja köögilauda Sõle 32-6.',
      category: PlaceCategory.visited,
      starRating: 2,
    ),
    Place(
      id: '7',
      latLng: LatLng(45.416986, -122.743171),
      name: 'Marjad',
      description:
          'Õismäe tee 45-7 oleks vaja marju vanaprouale.',
      category: PlaceCategory.visited,
      starRating: 2,
    ),
    Place(
      id: '8',
      latLng: LatLng(45.430489, -122.831802),
      name: 'Kõlar',
      description:
          'Soovitakse Viimsi Autotöökotta suurt basskõlarit(Viimsi 27A).',
      category: PlaceCategory.visited,
      starRating: 1,
    ),
    Place(
      id: '9',
      latLng: LatLng(45.383030, -122.758372),
      name: 'Auto aku',
      description:
            'Tartu maante kolmekümnendal kilomeetril Tallina algusest(Ülemiste juures) läks auto aku katki ja lõpetas töö.',
      category: PlaceCategory.visited,
      starRating: 2,
    ),
    Place(
      id: '10',
      latLng: LatLng(45.493321, -122.669330),
      name: 'Vana mööbli äravedu',
      description:
          'Vana mööbel tuleks Soo 27-21 viia jäätmejaama.',
      category: PlaceCategory.visited,
      starRating: 2,
    ),
    Place(
      id: '11',
      latLng: LatLng(45.548606, -122.675286),
      name: 'Pitsa',
      description:
          'Näljane isik otsib käbe midagi hamba alla Tatari 8-6.',
      category: PlaceCategory.wantToGo,
      starRating: 1,
    ),
    Place(
      id: '12',
      latLng: LatLng(45.420226, -122.740347),
      name: 'Suitsu',
      description:
          'Soovitakse pidulistele suitsu Merivälja tee 8.',
      category: PlaceCategory.wantToGo,
      starRating: 4,
    ),
    Place(
      id: '13',
      latLng: LatLng(45.541202, -122.676432),
      name: 'Mälupulk',
      description:
          'Mälupulga peab kiiresti viima Kaja 7-70',
      category: PlaceCategory.wantToGo,
      starRating: 4,
    ),
    Place(
      id: '14',
      latLng: LatLng(45.559783, -122.924103),
      name: 'Telefon',
      description:
          'Leitud telefon soovib omanikku, kes on liikumispuudega Uus-karja 8-14.',
      category: PlaceCategory.wantToGo,
      starRating: 5,
    ),
    Place(
      id: '15',
      latLng: LatLng(45.485612, -122.784733),
      name: 'Arvutid',
      description:
          'Vaja viia suured arvutid Kriidi 7 kontorist Viimsi 8.',
      category: PlaceCategory.wantToGo,
      starRating: 1,
    ),
  ];

  static const reviewStrings = <String>[
    'Minu lemmik teenus siiamaani on klaveri vedu.'
  ];
}
