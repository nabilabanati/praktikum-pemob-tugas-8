import 'package:flutter/material.dart';
import 'package:supermarket/bloc/barang_bloc.dart';
import 'package:supermarket/model/barang.dart';
import 'package:supermarket/ui/barang_page.dart';
import 'package:supermarket/widget/warning_dialog.dart';

// ignore: must_be_immutable
class BarangForm extends StatefulWidget {
  Barang? barang;

  BarangForm({Key? key, this.barang}) : super(key: key);

  @override
  _BarangFormState createState() => _BarangFormState();
}

class _BarangFormState extends State<BarangForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Barang";
  String tombolSubmit = "SIMPAN";
  final _namaBarangTextboxController = TextEditingController();
  final _hargaTextboxController = TextEditingController();
  final _jumlahTextboxController = TextEditingController();
  final _tglMasukTextboxController = TextEditingController();
  final _tglKadaluarsaTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.barang != null) {
      setState(() {
        judul = "Ubah Inventaris Banati";
        tombolSubmit = "UBAH";
        _namaBarangTextboxController.text = widget.barang!.namaBarang!;
        _hargaTextboxController.text = widget.barang!.harga.toString();
        _jumlahTextboxController.text = widget.barang!.jumlah.toString();
        _tglMasukTextboxController.text = widget.barang!.tglMasuk!;
        _tglKadaluarsaTextboxController.text = widget.barang!.tglKadaluarsa!;
      });
    } else {
      judul = "Tambah Inventaris Banati";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 8),
                _namaBarangTextField(),
                const SizedBox(height: 16),
                _hargaTextField(),
                const SizedBox(height: 16),
                _jumlahTextField(),
                const SizedBox(height: 16),
                _tglMasukTextField(),
                const SizedBox(height: 16),
                _tglKadaluarsaTextField(),
                const SizedBox(height: 32),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _namaBarangTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Nama Barang",
        prefixIcon: Icon(Icons.inventory_2_outlined),
      ),
      keyboardType: TextInputType.text,
      controller: _namaBarangTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama barang harus diisi";
        }
        return null;
      },
    );
  }

  Widget _hargaTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Harga",
        prefixIcon: Icon(Icons.attach_money),
      ),
      keyboardType: TextInputType.number,
      controller: _hargaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  Widget _jumlahTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Jumlah",
        prefixIcon: Icon(Icons.numbers),
      ),
      keyboardType: TextInputType.number,
      controller: _jumlahTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah harus diisi";
        }
        return null;
      },
    );
  }

  Widget _tglMasukTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Tanggal Masuk",
        hintText: "YYYY-MM-DD",
        prefixIcon: Icon(Icons.calendar_today),
      ),
      keyboardType: TextInputType.text,
      controller: _tglMasukTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal masuk harus diisi";
        }
        return null;
      },
    );
  }

  Widget _tglKadaluarsaTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Tanggal Kadaluarsa",
        hintText: "YYYY-MM-DD",
        prefixIcon: Icon(Icons.event_busy),
      ),
      keyboardType: TextInputType.text,
      controller: _tglKadaluarsaTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tanggal kadaluarsa harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.barang != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        },
        child: _isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(tombolSubmit),
      ),
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });
    Barang createBarang = Barang(id: null);
    createBarang.namaBarang = _namaBarangTextboxController.text;
    createBarang.harga = int.parse(_hargaTextboxController.text);
    createBarang.jumlah = int.parse(_jumlahTextboxController.text);
    createBarang.tglMasuk = _tglMasukTextboxController.text;
    createBarang.tglKadaluarsa = _tglKadaluarsaTextboxController.text;
    BarangBloc.addBarang(barang: createBarang).then((value) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const BarangPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });
    Barang updateBarang = Barang(id: widget.barang!.id!);
    updateBarang.namaBarang = _namaBarangTextboxController.text;
    updateBarang.harga = int.parse(_hargaTextboxController.text);
    updateBarang.jumlah = int.parse(_jumlahTextboxController.text);
    updateBarang.tglMasuk = _tglMasukTextboxController.text;
    updateBarang.tglKadaluarsa = _tglKadaluarsaTextboxController.text;
    BarangBloc.updateBarang(barang: updateBarang).then((value) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const BarangPage()));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Permintaan ubah data gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }
}
