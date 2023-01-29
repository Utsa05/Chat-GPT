// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:chat_gpt/presenations/constants/color.dart';
import 'package:chat_gpt/presenations/constants/string.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  bool _isTyping = false;
  String _text = 'Press the button and start speaking';

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) {
          print('onStatus: $val');
          if (val == 'done') {
            setState(() => _isListening = false);

            ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
              content: Text(_text),
              actions: [],
              backgroundColor: AppColor.tealColor,
            ));
          }
        },
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {}
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  List<String> chats = [];
  final TextEditingController _chatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/no_bg_icon.png',
              height: 28.0,
            ),
            const SizedBox(
              width: 7.0,
            ),
            const Text(
              AppString.appName,
              style: TextStyle(fontSize: 22.0),
            )
          ],
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (ctx) => [
              _buildPopupMenuItem('Share', (() {})),
              _buildPopupMenuItem('Policy', (() {})),
              _buildPopupMenuItem('Update', (() {})),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: chats.isNotEmpty
                  ? ListView.builder(
                      itemCount: chats.length,
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          decoration: BoxDecoration(
                              color: AppColor.overflowColor,
                              borderRadius: BorderRadius.circular(5.0)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 10.0),
                                padding: const EdgeInsets.all(5.0),
                                height: 40.0,
                                width: 40.0,
                                decoration: BoxDecoration(
                                    color: AppColor.tealColor,
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Image.asset(
                                  'assets/icons/no_bg_icon.png',
                                ),
                              ),
                              const Expanded(
                                child: Text(
                                    style: TextStyle(
                                        color: AppColor.whiteColor,
                                        fontSize: 17.0),
                                    "Java is a high-level programming language used for developing applications for various devices such as desktop computers, laptops, mobile devices, and embedded systems. It is known for its "),
                              )
                            ],
                          ),
                        );
                      })
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              size: 26.0,
                              Icons.emoji_emotions_outlined,
                              color: AppColor.whiteColor,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text(
                              "Open AI",
                              style: TextStyle(
                                  color: AppColor.whiteColor, fontSize: 17.0),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              color: AppColor.overflowColor),
                          child: const Text(
                            "Hello, Ask me anything",
                            style: TextStyle(
                                color: AppColor.whiteColor, fontSize: 13.0),
                          ),
                        )
                      ],
                    )),
          bottomWidget()
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, GestureTapCallback tap) {
    return PopupMenuItem(
      onTap: tap,
      child: Text(title),
    );
  }

  Container bottomWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 15.0),
      color: AppColor.overflowColor.withOpacity(0.4),
      child: Row(
        children: [
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: TextField(
              controller: _chatController,
              autofocus: false,
              style: const TextStyle(color: AppColor.whiteColor),
              maxLines: 5,
              minLines: 1,
              onChanged: ((value) {
                if (value.isEmpty) {
                  _isTyping = false;
                } else {
                  _isTyping = true;
                }
                setState(() {});
              }),
              cursorColor: AppColor.tealColor,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Type here....',
                  hintStyle: TextStyle(color: AppColor.whiteColor)),
            ),
          )),
          AvatarGlow(
            animate: _isTyping ? false : _isListening,
            glowColor: AppColor.whiteColor,
            endRadius: 35.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 100),
            repeat: true,
            child: SizedBox(
              height: 45.0,
              child: FloatingActionButton(
                  elevation: 0.0,
                  backgroundColor: AppColor.tealColor,
                  onPressed: (() {
                    if (_isTyping) {
                      chats.add(_chatController.text);
                      _chatController.clear();
                      _isTyping = false;
                    } else {
                      _listen();
                    }
                    setState(() {});
                  }),
                  child: _isTyping
                      ? const Icon(Icons.send_outlined)
                      : SizedBox(
                          child:
                              Icon(_isListening ? Icons.mic : Icons.mic_none),
                        )),
            ),
          ),
        ],
      ),
    );
  }
}
