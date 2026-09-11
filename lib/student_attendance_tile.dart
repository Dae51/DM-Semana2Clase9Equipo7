import 'package:flutter/material.dart';

import 'student.dart';

/// Presenta un estudiante y delega al padre el cambio de asistencia.
class StudentAttendanceTile extends StatelessWidget {
  const StudentAttendanceTile({
    required this.student,
    required this.isPresent,
    required this.onChanged,
    super.key,
  });

  final Student student;
  final bool isPresent;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final Color statusColor = isPresent
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.error;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    student.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text('Carné: ${student.id}'),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  isPresent ? 'Presente' : 'Ausente',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Semantics(
                  label: 'Asistencia de ${student.name}',
                  value: isPresent ? 'Presente' : 'Ausente',
                  child: Switch(
                    key: Key('attendance-${student.id}'),
                    value: isPresent,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
