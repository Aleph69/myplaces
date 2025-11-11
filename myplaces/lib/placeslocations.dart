class Placeslocations {
  List<String> placesname = [
    'Langkawi Sky Bridge',
    'Petronas Twin Towers',
    'Mount Kinabalu',
    'George Town Heritage Zone',
    'Cameron Highlands Tea Plantation',
    'Perhentian Islands',
    'Gunung Mulu National Park',
    'Melaka River Cruise',
    'Legoland Malaysia Resort',
    'Putrajaya Mosque',
    'Sunway Lagoon',
    'Kota Bharu Cultural Centre',
    'Taman Negara',
    'Desaru Coast',
    'Semporna Islands',
    'Bukit Tinggi Colmar Tropicale',
    'Bako National Park',
    'Kuala Sepetang Mangrove Forest',
    'Pulau Tioman',
    'Kuala Terengganu Drawbridge',
    'Alor Setar Tower',
    'Taiping Lake Gardens',
    'Menara Taming Sari',
    'Penang Hill (Bukit Bendera)',
    'Kuala Gandah Elephant Sanctuary',
    'Batu Caves',
    'The Habitat Penang Hill',
    'Lost World of Tambun',
    'Royal Belum Rainforest',
    'Pantai Cenang',
    'Penang Street Art',
    'Genting Highlands',
    'KL Bird Park',
    'Islamic Arts Museum Malaysia',
    'Thean Hou Temple',
    'Kuala Lumpur Tower (Menara KL)',
    'Ipoh Old Town',
    'Kellie’s Castle',
    'Sekinchan Paddy Field',
    'Penang Botanical Gardens',
    'Labuan Marine Museum',
    'Tip of Borneo (Tanjung Simpang Mengayau)',
    'Crocker Range National Park',
    'Sarawak Cultural Village',
    'Bario Highlands',
    'Kinabatangan River Safari',
    'Mantanani Islands',
    'Labuan Peace Park',
    'Miri Niah Caves',
    'Gunung Gading National Park',
    'Danum Valley Conservation Area',
    'Labuk Bay Proboscis Monkey Sanctuary',
    'Sipadan Island',
    'Mabul Island',
    'Tunku Abdul Rahman Marine Park',
    'Mount Trusmadi',
    'Kubah National Park',
    'Semenggoh Nature Reserve',
    'Bau Fairy Cave',
    'Kuching Waterfront',
    'Fraser’s Hill',
    'Lata Iskandar Waterfall',
    'Teluk Cempedak Beach',
    'Lake Kenyir',
    'Pantai Batu Buruk',
    'Jerangkang Waterfall',
    'Ulu Bendul Recreational Park',
    'Gunung Datuk',
    'Bukit Broga',
    'KL Forest Eco Park',
    'Pulau Pangkor',
    'Endau-Rompin National Park',
    'Putrajaya Botanical Garden',
    'Titiwangsa Lake Gardens',
    'Lang Tengah Island',
    'Bukit Keluang Beach',
    'Tanjung Piai National Park',
    'Gua Tempurung',
    'Balok Beach',
    'Penang Clan Jetties',
  ];
}

class Place {
  final String id;
  final String name;
  final String state;
  final String category;
  final String description;
  final String imageUrl;
  final String latitude;
  final String longitude;
  final String contact;
  final String rating;

  Place({
    required this.id,
    required this.name,
    required this.state,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.contact,
    required this.rating,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    // extracting the data from the api to the model class
    return Place(
      // use ?? to sub the empty values with N/A
      id: json['id']?.toString() ?? 'N/A',
      name: json['name']?.toString() ?? 'N/A',
      state: json['state']?.toString() ?? 'N/A',
      category: json['category']?.toString() ?? 'N/A',
      description: json['description']?.toString() ?? 'N/A',
      imageUrl: json['image_url']?.toString() ?? '',
      latitude: json['latitude']?.toString() ?? 'N/A',
      longitude: json['longitude']?.toString() ?? 'N/A',
      contact: json['contact']?.toString() ?? 'N/A',
      rating: json['rating']?.toString() ?? 'N/A',
    );
  }
}