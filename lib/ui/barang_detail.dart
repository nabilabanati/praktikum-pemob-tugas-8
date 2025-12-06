import 'package:flutter/material.dart';
import 'package:supermarket/bloc/barang_bloc.dart';
import 'package:supermarket/model/barang.dart';
import 'package:supermarket/ui/barang_form.dart';
import 'package:supermarket/ui/barang_page.dart';
import 'package:supermarket/widget/warning_dialog.dart';

// ignore: must_be_immutable
class BarangDetail extends StatefulWidget {
  Barang? barang;

  BarangDetail({Key? key, this.barang}) : super(key: key);

  @override
  _BarangDetailState createState() => _BarangDetailState();
}

class _BarangDetailState extends State<BarangDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Inventaris Banati'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildDetailRow(
                        Icons.label_outline,
                        "Nama Barang",
                        widget.barang!.namaBarang ?? '-',
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        Icons.attach_money,
                        "Harga",
                        "Rp. ${widget.barang!.harga}",
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        Icons.inventory,
                        "Jumlah",
                        widget.barang!.jumlah.toString(),
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        Icons.calendar_today,
                        "Tanggal Masuk",
                        widget.barang!.tglMasuk ?? '-',
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        Icons.event_busy,
                        "Tanggal Kadaluarsa",
                        widget.barang!.tglKadaluarsa ?? '-',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              _tombolHapusEdit(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.green.shade600, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BarangForm(
                    barang: widget.barang!,
                  ),
                ),
              );
            },
            child: const Text('Edit'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            onPressed: () => confirmHapus(),
            child: const Text('Hapus'),
          ),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      title: const Text('Hapus barang?'),
      content: const Text('Data tidak dapat dikembalikan.'),
      actions: [
        TextButton(
          child: const Text('Batal'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: Text('Hapus', style: TextStyle(color: Colors.red.shade600)),
          onPressed: () {
            BarangBloc.deleteBarang(id: int.parse(widget.barang!.id!)).then(
              (value) => {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const BarangPage()))
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
