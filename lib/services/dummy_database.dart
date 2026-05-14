class DummyDatabase {
  String formatRupiah(int amount) {
    // Format seperti 200.000 (tanpa desimal) untuk locale id-ID
    final s = amount.toString();
    final buffer = StringBuffer();
    final len = s.length;
    for (var i = 0; i < len; i++) {
      final indexFromEnd = len - i;
      buffer.write(s[i]);
      if (indexFromEnd > 1 && indexFromEnd % 3 == 1) {
        buffer.write('.');
      }
    }
    return buffer.toString();
  }

  static final DummyDatabase _instance = DummyDatabase._internal();
  factory DummyDatabase() => _instance;
  DummyDatabase._internal();

  // Data profil
  Map<String, String> userProfile = {
    'name': 'Malioboro AM',
    'address': 'JL.Danau Towuti IV G5 D12, Kota Malang, Jawa Timur',
    'level': 'Eco Rookie',
  };

  // Data statistik
  Map<String, dynamic> stats = {
    'income': 200000,
    'totalDrop': 19,
    'totalPickup': 0,
  };

  // Data achievement
  List<Map<String, dynamic>> achievements = [
    {
      'title': 'Taruh sampah 3kg sekaligus',
      'date': '14/06/2025',
      'achieved': true,
    },
    {
      'title': 'Memperoleh 200k Pertama',
      'date': '14/06/2025',
      'achieved': true,
    },
    {
      'title': 'Pengguna pertama',
      'date': '14/06/2025',
      'achieved': true,
    },
  ];

  // Data untuk halaman Artikel
  Map<String, dynamic> featuredArticle = {
    'title': 'Tips mengelola sampah',
    'subtitle': 'Bioplastic',
    'imageUrl': null, // null artinya placeholder kosong
  };

  List<Map<String, dynamic>> recommendAccounts = [
    {
      'name': 'Budi Speed Ngaku Nabi',
      'followers': '66k Pengikut',
      'avatarUrl': null,
    },
    {
      'name': 'Pria iq 85 Mengelola Sampah',
      'followers': '66k Pengikut',
      'avatarUrl': null,
    },
    {
      'name': 'Cara ubah iq Pemulung 85 ke 150',
      'followers': '66k Pengikut',
      'avatarUrl': null,
    },
    {
      'name': 'TrashBack Information',
      'followers': '66k Pengikut',
      'avatarUrl': null,
    },
    {
      'name': 'Cara Dr.Tirta Join Pandawara',
      'followers': '66k Pengikut',
      'avatarUrl': null,
    },
    {
      'name': 'Windah Bersih Bersih',
      'followers': '66k Pengikut',
      'avatarUrl': null,
    },
  ];



  // Saldo EcoCash
  int ecoCashBalance = 200000; // dalam rupiah

  // Daftar pesanan jemput sampah
  List<Map<String, dynamic>> pickupOrders = [
    {
      'name': 'Earlene Zabrina',
      'caption': 'Buangin Master Limbad gua',
      'amount': '250M',
      'avatarUrl': null,
    },
    {
      'name': 'Pria IQ 80',
      'caption': 'Buang hajat',
      'amount': '350M',
      'avatarUrl': null,
    },
    {
      'name': 'Windah Barusadar',
      'caption': 'Buangin air besar gw dapat 10rb',
      'amount': '450M',
      'avatarUrl': null,
    },
    {
      'name': 'Malio Hertigan',
      'caption': 'Buang sepeda rongsok',
      'amount': '500M',
      'avatarUrl': null,
    },
    {
      'name': 'Budi Dari Tadi',
      'caption': 'Buang apes',
      'amount': '700M',
      'avatarUrl': null,
    },
  ];

  // Histori transaksi (untuk halaman Riwayat)
  List<Map<String, dynamic>> transactions = [
    {'title': 'Tas Plastik', 'date': '14/06/2025', 'amount': -5000},
    {'title': 'Tas Plastik', 'date': '14/06/2025', 'amount': -5000},
    {'title': 'Tas Plastik', 'date': '14/06/2025', 'amount': -5000},
    {'title': 'Tas Plastik', 'date': '14/06/2024', 'amount': -5000},
    {'title': 'Tas Plastik', 'date': '14/06/2025', 'amount': -5000},
    {'title': 'Tas Plastik', 'date': '14/06/2025', 'amount': -5000},
    {'title': 'Tas Plastik', 'date': '14/06/2025', 'amount': -5000},
  ];

  // Method untuk mengambil pesanan (simulasi)
  void takeOrder(int index) {
    if (index < 0 || index >= pickupOrders.length) return;
    final name = pickupOrders[index]['name'] ?? '';
    pickupOrders.removeAt(index);
    // ignore: avoid_print
    print('Order taken: $name');
  }

  // Method untuk mensimulasikan refresh data (bisa dikosongkan, tapi panggil setState)
  void refreshData() {
    // Tidak mengubah data, hanya untuk trigger UI refresh
  }

  // Data sementara untuk taruh sampah (step 1)
  Map<String, dynamic> taruhSampahData = {
    'jenisSampah': null, // String
    'fotoPath': null, // String? (placeholder)
    'estimasiBerat': 3.0, // double
    'kondisiSampah': null, // String
    'catatan': '', // String
  };

  // Daftar pilihan jenis sampah (dummy)
  List<Map<String, dynamic>> jenisSampahOptions = [
    {'name': 'Limbah Fashion', 'price': 5000},
    {'name': 'Limbah Elektronik', 'price': 10000},
    {'name': 'Limbah Kaca', 'price': 2000},
  ];

  // Method untuk menyimpan data step 1
  void saveTaruhSampahStep1(Map<String, dynamic> data) {
    taruhSampahData = {...taruhSampahData, ...data};
  }

  // Reset data
  void resetTaruhSampah() {
    taruhSampahData = {
      'jenisSampah': null,
      'fotoPath': null,
      'estimasiBerat': 3.0,
      'kondisiSampah': null,
      'catatan': '',
    };
  }

  // Daftar video panduan
  List<Map<String, dynamic>> videoTutorials = [
    {
      'title': 'Cara budi speed mengelola sampah dengan iq 150 nya!!',
      'description': 'MARAPTHON UNDANG PANDAWARA!! Serasa ikut nongkrang',
      'creator': 'Budi Speed',
      'followers': '66k Pengikut',
      'thumbnailUrl': null,
    },
    {
      'title': 'Tips memilah sampah organik dan anorganik',
      'description': 'Praktik langsung bersama EcoRanger',
      'creator': 'EcoRanger Team',
      'followers': '120k Pengikut',
      'thumbnailUrl': null,
    },
    {
      'title': 'Cara daur ulang plastik menjadi ecobrick',
      'description': 'Mudah dan bermanfaat untuk lingkungan',
      'creator': 'Sampah Jadi Berkah',
      'followers': '45k Pengikut',
      'thumbnailUrl': null,
    },
  ];

  // Data percakapan EcoMentor
  List<Map<String, dynamic>> chatMessages = [


    // Yesterday
    {
      'sender': 'mentor',
      'message': 'Hai, Aku baru membuka fitur premium hari ini',
      'time': '10:05',
      'dateGroup': 'Yesterday',
    },
    {
      'sender': 'user',
      'message': 'Hi Earlene, Terimakasih, semoga kamu puas!',
      'time': '10:35',
      'dateGroup': 'Yesterday',
    },

    // Today
    {
      'sender': 'user',
      'message': 'Sampah dirumahku Terlalu banyak',
      'time': '12:00',
      'dateGroup': 'Today',
    },
    {
      'sender': 'user',
      'message': 'Bagaimana cara aku menguranginya?',
      'time': '12:25',
      'dateGroup': 'Today',
    },
    {
      'sender': 'mentor',
      'message': 'Anda mungkin bisa menggunakan fitur Angkut Sampah atau fitur Taruh Sampah di beberapa mitra agar bisa mengurangi sampah dirumah anda',
      'time': '12:34',
      'dateGroup': 'Today',
    },
    {
      'sender': 'user',
      'message': 'Baiklah, Terimakasih sarannya!',
      'time': '12:40',
      'dateGroup': 'Today',
    },
  ];

  // Method untuk mendapatkan saldo terformat
  String getFormattedBalance() {
    return 'Rp. ${formatRupiah(ecoCashBalance)}';
  }
}



































