import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/model/feedback_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SendingOption extends StatefulWidget {
  final String phoneNumber;
  final String message;
  const SendingOption(
      {Key? key, required this.phoneNumber, required this.message})
      : super(key: key);

  @override
  State<SendingOption> createState() => _SendingOptionState();
}

class _SendingOptionState extends State<SendingOption> {
  void _launchURL({required String url}) async {
    if (!await launchUrlString(url)) throw 'Could not launch url';
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Send Reply Messages'),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
            splashRadius: 24,
          )
        ],
      ),
      children: [
        _dialogOption(
            option: 'wa',
            image: 'icon_whatsapp.png',
            text: 'Send with WhatsApp',
            onPressed: () {
              var url =
                  'whatsapp://send?phone=${widget.phoneNumber}&text=${widget.message}';

              _launchURL(url: url);
            }),
        _dialogOption(
            option: 'sms',
            image: 'icon_sms.png',
            text: 'Send with SMS',
            onPressed: () {
              final url = 'sms:+${widget.phoneNumber}?body=${widget.message}';

              _launchURL(url: url);
            }),
      ],
    );
  }

  SimpleDialogOption _dialogOption({
    required String option,
    required String image,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SimpleDialogOption(
      onPressed: onPressed,
      child: Row(
        children: [
          Image.asset(
            'assets/$image',
            height: 32,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
