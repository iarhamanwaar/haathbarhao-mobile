import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haathbarhao_mobile/providers/user_provider.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  String? chatId;

  @override
  void initState() {
    super.initState();
    _findOrCreateChat();
  }

  Future<void> _findOrCreateChat() async {
    final user = ref.read(userProvider).user!;
    try {
      final chatQuery = await FirebaseFirestore.instance
          .collection('chats')
          .where('userIds', arrayContains: user.id)
          .get();

      if (chatQuery.docs.isEmpty) {
        final newChat =
            await FirebaseFirestore.instance.collection('chats').add({
          'userIds': [user.id],
          'createdAt': Timestamp.now(),
        });
        setState(() {
          chatId = newChat.id;
        });
      } else {
        setState(() {
          chatId = chatQuery.docs.first.id;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error finding or creating chat: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFF7b95cd),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _sendMessage() async {
    final user = ref.read(userProvider).user!;
    if (_controller.text.isNotEmpty && chatId != null) {
      try {
        String msg = _controller.text;
        _controller.clear();
        await FirebaseFirestore.instance
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .add({
          'text': msg,
          'senderId': user.id,
          'timestamp': Timestamp.now(),
        });
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error sending message: $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: const Color(0xFF7b95cd),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: chatId == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 64, bottom: 32),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.black),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Demola Andreas',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '2 km away | Level 3',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.call, color: Colors.black),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .doc(chatId)
                        .collection('messages')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                      if (chatSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final chatDocs = chatSnapshot.data?.docs;
                      if (chatDocs == null || chatDocs.isEmpty) {
                        return const Center(
                          child:
                              Text('No messages yet. Start the conversation!'),
                        );
                      }
                      return ListView.builder(
                        reverse: true,
                        itemCount: chatDocs.length,
                        itemBuilder: (ctx, index) => MessageBubble(
                          chatDocs[index]['text'],
                          chatDocs[index]['senderId'] ==
                              ref.read(userProvider).user!.id,
                          Timestamp.fromMillisecondsSinceEpoch(chatDocs[index]
                                  ['timestamp']
                              .millisecondsSinceEpoch),
                          key: ValueKey(chatDocs[index].id),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Message',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: const BorderSide(
                                width: 2,
                                color: Color(0xFFc4c4c4),
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: const Color(0xFF7b95cd),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Timestamp timestamp;

  const MessageBubble(this.message, this.isMe, this.timestamp, {super.key});

  @override
  Widget build(BuildContext context) {
    final timeString = DateFormat('hh:mm a').format(timestamp.toDate());

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? const Color(0xFF00339e) : const Color(0xFFededed),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                timeString,
                style: TextStyle(
                  color: isMe ? Colors.white70 : Colors.black54,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
