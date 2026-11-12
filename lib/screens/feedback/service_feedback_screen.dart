import 'package:flutter/material.dart';
import '../../services/request_service.dart';

class ServiceFeedbackScreen extends StatefulWidget {
  final String requestId;
  final String serviceType;

  const ServiceFeedbackScreen({
    super.key,
    required this.requestId,
    required this.serviceType,
  });

  @override
  State<ServiceFeedbackScreen> createState() => _ServiceFeedbackScreenState();
}

class _ServiceFeedbackScreenState extends State<ServiceFeedbackScreen> {
  final _comment = TextEditingController();
  int _rating = 5;
  bool _sending = false;

  String get _serviceName => widget.serviceType == 'lost'
      ? 'reporte de mascota perdida'
      : 'atención veterinaria';

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _sending = true);
    try {
      await RequestService().submitFeedback(
        requestId: widget.requestId,
        serviceType: widget.serviceType,
        rating: _rating,
        comment: _comment.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Gracias! Tu opinión fue registrada.')),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se pudo guardar tu opinión: $error')),
        );
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Califica tu experiencia')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(Icons.rate_review_outlined, size: 66, color: Colors.green),
          const SizedBox(height: 16),
          const Text(
            '¿Cómo fue tu experiencia?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Cuéntanos qué te pareció el servicio de $_serviceName.', textAlign: TextAlign.center),
          const SizedBox(height: 26),
          Center(
            child: Wrap(
              spacing: 5,
              children: List.generate(5, (index) {
                final value = index + 1;
                return IconButton(
                  tooltip: '$value estrellas',
                  onPressed: () => setState(() => _rating = value),
                  iconSize: 38,
                  color: Colors.amber.shade700,
                  icon: Icon(value <= _rating ? Icons.star : Icons.star_border),
                );
              }),
            ),
          ),
          Center(child: Text('$_rating de 5 estrellas')),
          const SizedBox(height: 24),
          TextField(
            controller: _comment,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Comentario (opcional)',
              hintText: '¿Qué funcionó bien o qué podríamos mejorar?',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: _sending ? null : _submit,
            icon: const Icon(Icons.send),
            label: Text(_sending ? 'Enviando...' : 'Enviar opinión'),
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(50)),
          ),
        ],
      ),
    );
  }
}
