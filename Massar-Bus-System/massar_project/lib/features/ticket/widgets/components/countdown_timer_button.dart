import 'package:massar_project/core/theme/app_colors.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimerButton extends StatefulWidget {
  final DateTime deadline;
  final VoidCallback onTimeExpired;

  const CountdownTimerButton({
    Key? key,
    required this.deadline,
    required this.onTimeExpired,
  }) : super(key: key);

  @override
  State<CountdownTimerButton> createState() => _CountdownTimerButtonState();
}

class _CountdownTimerButtonState extends State<CountdownTimerButton> {
  Timer? _timer;
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    _calculateTimeLeft();
    if (_timeLeft.inSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _calculateTimeLeft();
        if (_timeLeft.inSeconds <= 0) {
          timer.cancel();
          widget.onTimeExpired();
        }
        setState(() {}); // Only updates this specific button
      });
    }
  }

  void _calculateTimeLeft() {
    final now = DateTime.now();
    if (widget.deadline.isAfter(now)) {
      _timeLeft = widget.deadline.difference(now);
    } else {
      _timeLeft = Duration.zero;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "$hours:$minutes:$seconds";
    }
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final isExpired = _timeLeft.inSeconds <= 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isExpired ? Colors.grey.shade200 : const Color(0xFFFEF3F2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timer_outlined,
              size: 18,
              color: isExpired ? Colors.grey.shade600 : AppColors.textCancel,
            ),
            const SizedBox(width: 8),
            Text(
              isExpired ? 'انتهى وقت الدفع' : 'نهاية الدفع ${_formatDuration(_timeLeft)}',
              style: TextStyle(
                color: isExpired ? Colors.grey.shade600 : AppColors.textCancel,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}




