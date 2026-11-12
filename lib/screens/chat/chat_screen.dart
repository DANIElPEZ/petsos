import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/message.dart';
import '../../models/request_model.dart';
import '../../services/message_service.dart';
import '../../services/storage_service.dart';
import '../../services/request_service.dart';
import '../feedback/service_feedback_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatScreen extends StatefulWidget {
  final PetRequest request;

  const ChatScreen({super.key, required this.request});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  List<ChatMessage> messages = [];
  bool loading = true;
  bool sending = false;
  Stream<List<Map<String, dynamic>>>? stream;

  @override
  void initState() {
    super.initState();
    load();
    stream = MessageService().watchMessages(widget.request.id);
  }

  Future<void> load() async {
    try {
      messages = await MessageService().getMessages(widget.request.id);
    } catch (_) {}
    if (mounted) setState(() => loading = false);
  }

  Future<void> send() async {
    if (controller.text.trim().isEmpty) return;
    final text = controller.text.trim();
    controller.clear();
    setState(() => sending = true);
    try {
      await MessageService().sendMessage(
        requestId: widget.request.id,
        text: text,
      );
      await load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => sending = false);
    }
  }

  Future<void> finishService() async {
    setState(() => sending = true);
    try {
      if (widget.request.status != 'completed') {
        await RequestService().completeRequest(widget.request.id);
      }
      if (!mounted) return;
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ServiceFeedbackScreen(
            requestId: widget.request.id,
            serviceType: widget.request.type,
          ),
        ),
      );
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => sending = false);
    }
  }

  Future<void> sendPhoto() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked == null) return;
    setState(() => sending = true);
    try {
      final url = await StorageService().uploadImage(file: File(picked.path), folder: 'messages');
      await MessageService().sendMessage(
        requestId: widget.request.id,
        images: [url],
      );
      await load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.request.dog?.name ?? 'Mascota'} - ${widget.request.isLost ? 'Perdido' : 'Atención'}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: stream,
              builder: (context, snapshot) {
                final current = snapshot.hasData
                    ? snapshot.data!.map(ChatMessage.fromMap).toList()
                    : messages;

                if (current.isEmpty && loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  reverse: false,
                  padding: const EdgeInsets.all(15),
                  itemCount: current.length,
                  itemBuilder: (_, i) {
                    final m = current[i];
                    return _Bubble(message: m);
                  },
                );
              },
            ),
          ),
          if (widget.request.isMedical &&
              widget.request.userId == Supabase.instance.client.auth.currentUser?.id)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: FilledButton.icon(
                onPressed: sending ? null : finishService,
                icon: const Icon(Icons.task_alt),
                label: Text(widget.request.status == 'completed' ? 'Calificar atención' : 'Finalizar atención y calificar'),
              ),
            ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  IconButton(onPressed: sending ? null : sendPhoto, icon: const Icon(Icons.add_photo_alternate)),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(hintText: 'Escribe un mensaje...'),
                      onSubmitted: (_) => send(),
                    ),
                  ),
                  IconButton(
                    onPressed: sending ? null : send,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  final ChatMessage message;
  const _Bubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final me = message.senderId == MessageService().db.auth.currentUser?.id;
    return Align(
      alignment: me ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 320),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: me ? Colors.green.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.message != null && message.message!.isNotEmpty)
              Text(message.message!),
            ...message.images.map(
              (url) => Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Image.network(url, width: 230),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
