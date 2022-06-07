import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/component/sending_option.dart';
import 'package:mo_opendata_v2/helper/datetime_formatter.dart';
import 'package:mo_opendata_v2/helper/string_formatter.dart';
import 'package:mo_opendata_v2/model/feedback_model.dart';
import 'package:mo_opendata_v2/screen/home_screen.dart';
import 'package:mo_opendata_v2/service/feedback_service.dart';

class DetailScreen extends StatefulWidget {
  final FeedbackModel feedback;
  const DetailScreen({
    Key? key,
    required this.feedback,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _notesController =
      TextEditingController(text: '');

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Feedback Detail'),
        actions: widget.feedback.status
            ? null
            : [
                PopupMenuButton(
                  onSelected: (value) {
                    _updateStatus(context);
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          Text('Mark as Done'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
      ),
      body: SafeArea(
        child: _listView(context),
      ),
    );
  }

  Future<dynamic> _updateStatus(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 24,
        ),
        title: const Text('Add Notes'),
        content: SizedBox(
          height: 140,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: TextField(
                  controller: _notesController,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  minLines: 1,
                  maxLines: 2,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    counterText: '',
                    hintText: 'Add notes here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    final fs = FeedbackService();
                    final result = await fs.updateStatus(
                      no: widget.feedback.no,
                      notes: _notesController.text,
                    );

                    if (result['ok']) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const HomeScreen(),
                        ),
                        (route) => false,
                      );
                    }
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListView _listView(BuildContext context) {
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
                      const SizedBox(
                        height: 8,
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => SendingOption(
                          feedback: widget.feedback,
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
