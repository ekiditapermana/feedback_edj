import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/component/sending_option.dart';
import 'package:mo_opendata_v2/model/survey_model.dart';
import 'package:mo_opendata_v2/screen/error_screen/general_error.dart';
import 'package:mo_opendata_v2/service/survey_service.dart';

class NumberCheck extends StatefulWidget {
  const NumberCheck({Key? key}) : super(key: key);

  @override
  State<NumberCheck> createState() => _NumberCheckState();
}

class _NumberCheckState extends State<NumberCheck> {
  List<SurveyModel> participants = [];

  bool isLoading = false;

  int _selectedIndex = 0;

  Future fetch() async {
    try {
      isLoading = true;
      final s = SurveyService();
      final newItems = await s.getParticipants();

      setState(() {
        isLoading = false;

        participants.addAll(newItems);
      });
    } catch (e) {
      Navigator.pushAndRemoveUntil(
        context,
        (MaterialPageRoute(builder: (context) => const GeneralError())),
        (route) => false,
      );
    }
  }

  void addNotes(int index, String notes) {
    final s = SurveyService();
    final participant = participants[index];

    s.postNotes(no: participant.no, notes: notes).then((ok) {
      if (!ok) {
        Navigator.pushAndRemoveUntil(
          context,
          (MaterialPageRoute(builder: (context) => const GeneralError())),
          (route) => false,
        );
      }
      setState(() {
        participants.removeAt(index);
      });
    });
  }

  Future refresh() async {
    setState(() {
      participants.clear();
      isLoading = false;
    });

    fetch();
  }

  @override
  void initState() {
    super.initState();

    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Whatsapp Number Validator',
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refresh,
              child: ListView.builder(
                itemCount: participants.length,
                itemBuilder: (context, index) {
                  if (participants[index].notes.isEmpty) {
                    return ListTile(
                      selectedTileColor: Colors.lightBlue.withOpacity(0.5),
                      selectedColor: Colors.white,
                      selected: _selectedIndex == index,
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => SendingOption(
                            phoneNumber: participants[index].phoneNumber,
                            message: '',
                          ),
                        );
                      },
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          size: 20,
                        ),
                      ),
                      title: Text(
                        participants[index].phoneNumber,
                        // style: TextStyle(fontSize: 14),
                      ),
                      trailing: statusButtons(index),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
    );
  }

  Widget statusButtons(int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          splashRadius: 24,
          onPressed: () {
            addNotes(index, 'Nomor Tidak Valid');
          },
          icon: const Icon(
            Icons.cancel_rounded,
            color: Colors.red,
          ),
        ),
        IconButton(
          splashRadius: 24,
          onPressed: () {
            addNotes(index, 'Dikirim melalui SMS');
          },
          icon: const Icon(
            Icons.error_rounded,
            color: Colors.orange,
          ),
        ),
        IconButton(
          splashRadius: 24,
          onPressed: () {
            addNotes(index, 'Dikirim melalui Whatsapp');
          },
          icon: const Icon(
            Icons.check_circle_rounded,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}
