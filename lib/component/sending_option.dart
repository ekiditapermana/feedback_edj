import 'package:flutter/material.dart';
import 'package:mo_opendata_v2/model/feedback_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SendingOption extends StatefulWidget {
  final FeedbackModel feedback;
  const SendingOption({Key? key, required this.feedback}) : super(key: key);

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
      title: const Text('Send Reply Message'),
      children: [
        _dialogOption(
            option: 'wa',
            image: 'icon_whatsapp.png',
            text: 'Send with WhatsApp',
            onPressed: () {
              var url =
                  'whatsapp://send?phone=${widget.feedback.kontak}&text=${widget.feedback.catatanMO}';

              _launchURL(url: url);
            }),
        _dialogOption(
            option: 'sms',
            image: 'icon_sms.png',
            text: 'Send with Messaging',
            onPressed: () {
              final url =
                  'sms:+${widget.feedback.kontak}?body=${widget.feedback.catatanMO}';

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
