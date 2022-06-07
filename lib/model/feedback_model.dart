class FeedbackModel {
  final int no;
  final String tanggal;
  final String kontak;
  final String sektor;
  final String tujuan;
  final String masalah;
  final String saran;
  final String tanggapan;
  final String catatanMO;
  final String picMO;
  final bool status;
  final String notes;

  const FeedbackModel({
    required this.no,
    required this.tanggal,
    required this.kontak,
    required this.sektor,
    required this.tujuan,
    required this.masalah,
    required this.saran,
    required this.tanggapan,
    required this.catatanMO,
    required this.picMO,
    required this.status,
    required this.notes,
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
        no: json['no'],
        tanggal: json['tanggal'],
        kontak: '62' + json['kontak'].toString(),
        sektor: json['sektor'],
        tujuan: json['tujuan'],
        masalah: json['masalah'],
        saran: json['saran'],
        tanggapan: json['tanggapan'],
        catatanMO: json['catatan_mo'],
        picMO: json['pic_mo'],
        status: json['status'],
        notes: json['notes'],
      );
}
