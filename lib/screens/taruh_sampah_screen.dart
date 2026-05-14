import 'package:flutter/material.dart';

import '../main.dart';
import '../services/dummy_database.dart';

class TaruhSampahScreen extends StatefulWidget {
  const TaruhSampahScreen({super.key});

  @override
  State<TaruhSampahScreen> createState() => _TaruhSampahScreenState();
}

class _TaruhSampahScreenState extends State<TaruhSampahScreen> {
  final DummyDatabase _db = DummyDatabase();

  int _currentStep = 1; // for UI only

  String? _selectedJenis;
  String? _selectedKondisi;
  double _estimasiBerat = 3.0;

  final TextEditingController _catatanController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // prefill from dummy db if available
    final data = _db.taruhSampahData;
    _selectedJenis = data['jenisSampah'] as String?;
    _selectedKondisi = data['kondisiSampah'] as String?;
    _estimasiBerat = (data['estimasiBerat'] as num?)?.toDouble() ?? 3.0;
    _catatanController.text = (data['catatan'] as String?) ?? '';
  }

  @override
  void dispose() {
    _catatanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFFF5F7FA);

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: ClipOval(
          child: Material(
            color: Colors.white.withOpacity(0.9),
            child: InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: const SizedBox(
                width: 36,
                height: 36,
                child: Center(
                  child: Icon(Icons.arrow_back, size: 20, color: Color(0xFF1A1A1A)),
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'Taruh Sampah',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildStepIndicator(),
              const SizedBox(height: 12),
              const SizedBox(height: 4),
              _buildStep1(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    const activeColor = Color(0xFF2E7D32);
    const inactiveColor = Color(0xFFBDBDBD);

    Widget stepItem(int step, String text) {
      final isActive = _currentStep == step;
      return Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: isActive ? activeColor : inactiveColor,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          stepItem(1, '1. Data Sampah'),
          const SizedBox(width: 8),
          const Text('•', style: TextStyle(color: Color(0xFFBDBDBD), fontSize: 14)),
          const SizedBox(width: 8),
          stepItem(2, '2. Verifikasi'),
          const SizedBox(width: 8),
          const Text('•', style: TextStyle(color: Color(0xFFBDBDBD), fontSize: 14)),
          const SizedBox(width: 8),
          stepItem(3, '3. Konfirmasi'),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),

        // 1) Jenis Sampah
        const Text(
          'Jenis Sampah',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),

        ..._buildJenisSampahOptions(),
        const SizedBox(height: 12),
        _buildTambahFotoCard(),

        // 2) Estimasi Berat
        const SizedBox(height: 16),
        const Text(
          'Estimasi Berat',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),

        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_estimasiBerat.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const Text(
                  'kg',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: Color(0xFF757575),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 6,
                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
                ),
                child: Slider(
                  value: _estimasiBerat,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: _estimasiBerat.toStringAsFixed(0),
                  activeColor: AppTheme.primaryGreen,
                  inactiveColor: const Color(0xFFE0E0E0),
                  onChanged: (v) {
                    setState(() {
                      _estimasiBerat = v;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        const Text(
          'AI Memperkirakan 3-4kg',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Color(0xFF757575),
            fontWeight: FontWeight.w500,
          ),
        ),

        // 2.1 Kondisi
        const SizedBox(height: 16),
        const Text(
          'Kondisi Sampah',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        _buildKondisiChips(),

        // 3 Catatan
        const SizedBox(height: 16),
        const Text(
          'Catatan Tambahan (Opsional)',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _catatanController,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: 'Contoh: Tolong itu nya di anukan mbud',
          ),
        ),

        // Tombol lanjutkan
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: _onContinue,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
            child: const Text(
              'LANJUTKAN',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  List<Widget> _buildJenisSampahOptions() {
    final options = _db.jenisSampahOptions;

    return options.map((e) {
      final name = e['name'] as String;
      final price = (e['price'] as num).toInt();
      final isSelected = _selectedJenis == name;

      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedJenis = name;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppTheme.primaryGreen : const Color(0xFFCCCCCC),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Radio<String>(
                value: name,
                groupValue: _selectedJenis,
                onChanged: (v) {
                  setState(() {
                    _selectedJenis = v;
                  });
                },
                activeColor: AppTheme.primaryGreen,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '(${_db.formatRupiah(price)}/kg)',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Color(0xFF757575),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildTambahFotoCard() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Fitur upload foto (simulasi)',
              style: TextStyle(fontFamily: 'Poppins'),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFCCCCCC), width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.add_a_photo,
              size: 32,
              color: AppTheme.primaryGreen,
            ),
            const SizedBox(height: 8),
            const Text(
              'Tambah Foto',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKondisiChips() {
    const chips = ['Bersih', 'Kering', 'Basah', 'Campur'];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: chips.map((c) {
        final isSelected = _selectedKondisi == c;
        return ChoiceChip(
          label: Text(
            c,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
              color: isSelected ? Colors.white : const Color(0xFF757575),
            ),
          ),
          selected: isSelected,
          selectedColor: AppTheme.primaryGreen,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isSelected ? AppTheme.primaryGreen : const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          onSelected: (_) {
            setState(() {
              _selectedKondisi = c;
            });
          },
        );
      }).toList(),
    );
  }

  void _onContinue() {
    // basic validation
    if (_selectedJenis == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pilih jenis sampah terlebih dahulu.',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      );
      return;
    }

    if (_estimasiBerat <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Estimasi berat harus lebih dari 0.',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      );
      return;
    }

    if (_selectedKondisi == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pilih kondisi sampah terlebih dahulu.',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      );
      return;
    }

    _db.saveTaruhSampahStep1({
      'jenisSampah': _selectedJenis,
      'fotoPath': null,
      'estimasiBerat': _estimasiBerat,
      'kondisiSampah': _selectedKondisi,
      'catatan': _catatanController.text.trim(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Data tersimpan, lanjut ke verifikasi (simulasi).',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
      ),
    );

    // Simulasi: step next belum ada, hanya dialog
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Verifikasi',
            style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
          ),
          content: const Text(
            'Halaman verifikasi belum dibuat. Ini hanya simulasi dari step berikutnya.',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Mengerti',
                style: TextStyle(fontFamily: 'Poppins'),
              ),
            ),
          ],
        );
      },
    );
  }
}

