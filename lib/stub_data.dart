// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'place.dart';

class StubData {
  static const List<Place> places = [
    Place(
      id: '1',
      latLng: LatLng(59.4411686,24.8765521),
      name: 'Klaveri vedu',
      description:
          'Vea klaverit 12 korrusele Raadiku 2/1.',
      category: PlaceCategory.favorite,
      starRating: 5,
    ),
    Place(
      id: '2',
      latLng: LatLng(59.4386208,24.8771778),
      name: 'Teleri vedu',
      description:
          'Vea telerit 3 korrusele Mahtra 50a-70..',
      category: PlaceCategory.favorite,
      starRating: 5,
    ),
    Place(
      id: '3',
      latLng: LatLng(59.4322803,24.7511733),
      name: 'Playboy ajakirja tellimus',
      description:
          'Kiimas mees soovib näha playboy ajakirja ruttu Tõnismäe 2/4-34.',
      category: PlaceCategory.favorite,
      starRating: 5,
    ),
    Place(
      id: '4',
      latLng: LatLng(59.4334347,24.7567053),
      name: 'Külmkapp',
      description:
          'Külmkapp lekib ja tahetakse kiirelt välja vahetada Maakri 7-8',
      category: PlaceCategory.favorite,
      starRating: 4,
    ),
    Place(
      id: '5',
      latLng: LatLng(59.3753982,24.6489846),
      name: 'Mikrofon',
      description:
          'Räpparid soovivad osta AKG mikrofoni Jannseni 6-7.',
      category: PlaceCategory.favorite,
      starRating: 4,
    ),
    Place(
      id: '6',
      latLng: LatLng(59.4393927,24.7058603),
      name: 'Laud',
      description:
          'Kiiremas korras oleks vaja köögilauda Sõle 32-6.',
      category: PlaceCategory.visited,
      starRating: 2,
    ),
    Place(
      id: '7',
      latLng: LatLng(59.4095239,24.6466434),
      name: 'Marjad',
      description:
          'Õismäe tee 45-7 oleks vaja marju vanaprouale.',
      category: PlaceCategory.visited,
      starRating: 2,
    ),
    Place(
      id: '8',
      latLng: LatLng(59.5001875,24.8124367),
      name: 'Kõlar',
      description:
          'Soovitakse Viimsi Autotöökotta suurt basskõlarit Viimsi 27A.',
      category: PlaceCategory.visited,
      starRating: 1,
    ),
    Place(
      id: '9',
      latLng: LatLng(59.4224063,24.7932992),
      name: 'Auto aku',
      description:
            'Tartu maanteel Ülemiste juures läks auto aku katki ja lõpetas töö.',
      category: PlaceCategory.visited,
      starRating: 2,
    ),
    Place(
      id: '10',
      latLng: LatLng(59.4462789,24.7343001),
      name: 'Vana mööbli äravedu',
      description:
          'Vana mööbel tuleks Soo 27-21 viia jäätmejaama.',
      category: PlaceCategory.visited,
      starRating: 2,
    ),
    Place(
      id: '11',
      latLng: LatLng(59.4311641,24.7442406),
      name: 'Pitsa',
      description:
          'Näljane isik otsib käbe midagi hamba alla Tatari 8-6.',
      category: PlaceCategory.wantToGo,
      starRating: 1,
    ),
    Place(
      id: '12',
      latLng: LatLng(59.4713134,24.833215),
      name: 'Suitsu',
      description:
          'Soovitakse pidulistele suitsu Merivälja tee 8.',
      category: PlaceCategory.wantToGo,
      starRating: 4,
    ),
    Place(
      id: '13',
      latLng: LatLng(59.375988,24.6879983),
      name: 'Mälupulk',
      description:
          'Mälupulga peab kiiresti viima Kaja 7-70',
      category: PlaceCategory.wantToGo,
      starRating: 4,
    ),
    Place(
      id: '14',
      latLng: LatLng(59.5760498,25.9720692),
      name: 'Telefon',
      description:
          'Leitud telefon soovib omanikku, kes on liikumispuudega Uus-karja 8-14.',
      category: PlaceCategory.wantToGo,
      starRating: 5,
    ),
    Place(
      id: '15',
      latLng: LatLng(59.4912281,24.8368745),
      name: 'Arvutid',
      description:
          'Vaja viia suured arvutid Kriidi 7 kontorist Viimsi tee 8.',
      category: PlaceCategory.wantToGo,
      starRating: 1,
    ),
  ];

  static const reviewStrings = <String>[
    'Töömehed teevad korralikku ja kiiret tööd. Olen väga rahul.'
  ];
}
