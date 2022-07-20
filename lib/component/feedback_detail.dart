import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/component/sending_option.dart';
import 'package:mo_opendata_v2/helper/datetime_formatter.dart';
import 'package:mo_opendata_v2/helper/string_formatter.dart';
import 'package:mo_opendata_v2/model/feedback_model.dart';

class FeedbackDetail extends StatefulWidget {
  final FeedbackModel feedback;
  const FeedbackDetail({Key? key, required this.feedback}) : super(key: key);

  @override
  State<FeedbackDetail> createState() => _FeedbackDetailState();
}

class _FeedbackDetailState extends State<FeedbackDetail> {
  List<String> members = [
    'Tutus',
    'Rima',
    'Nisa',
    'Nia',
  ];

  String? picMO;

  Widget selectMember() {
    return DropdownButtonFormField(
      value: picMO,
      hint: Text(
        widget.feedback.picMO.isNotEmpty
            ? widget.feedback.picMO
            : "Pilih PIC MO",
        style: const TextStyle(color: Colors.grey),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      onChanged: (selectedType) {
        picMO = selectedType.toString();
      },
      items: members.map((value) {
        return DropdownMenuItem(
          child: Text(
            value,
          ),
          value: value,
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(getAcronym(widget.feedback.sektor)),
                  ),
                  title: Text(widget.feedback.kontak),
                  subtitle: Text(widget.feedback.sektor),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tanggal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        DateTimeFormatter.format(
                                widget.feedback.tanggal, 'EEEE, d MMMM yyyy')
                            .toString(),
                      ),
                      const Divider(color: Colors.grey),
                      const Text(
                        'Tujuan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(widget.feedback.tujuan),
                      const Divider(color: Colors.grey),
                      const Text(
                        'Masalah',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(widget.feedback.masalah.isEmpty
                          ? "Tidak ada"
                          : widget.feedback.masalah),
                      const Divider(color: Colors.grey),
                      const Text(
                        'Saran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(widget.feedback.saran.isEmpty
                          ? "Tidak ada"
                          : widget.feedback.saran),
                      const Divider(color: Colors.grey),
                      const Text(
                        'Tanggapan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(widget.feedback.tanggapan),
                      const Divider(color: Colors.grey),
                      const Text(
                        'Catatan MO',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        widget.feedback.catatanMO.isEmpty
                            ? "Balasan belum dibuat"
                            : widget.feedback.catatanMO,
                      ),
                      const Divider(color: Colors.grey),
                      const Text(
                        'PIC MO',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      widget.feedback.picMO.isNotEmpty
                          ? Text(widget.feedback.picMO)
                          : selectMember()
                      // const Divider(color: Colors.grey),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 45,
            child: widget.feedback.status
                ? const SizedBox()
                : ElevatedButton(
                    onPressed: widget.feedback.catatanMO.isEmpty
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) => SendingOption(
                                phoneNumber: widget.feedback.kontak,
                                message: widget.feedback.catatanMO,
                              ),
                            );
                          },
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ),
        )
      ],
    );
  }
}
