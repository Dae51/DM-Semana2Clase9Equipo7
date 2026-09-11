import 'package:flutter/material.dart';

import 'student.dart';
import 'student_attendance_tile.dart';

void main() {
  runApp(const AttendanceApp());
}

class AttendanceApp extends StatelessWidget {
  const AttendanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control de asistencia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  static const String _groupName = 'Grupo 3 · Desarrollo Móvil';

  late List<bool> _attendance;

  @override
  void initState() {
    super.initState();
    _attendance = _initialAttendance();
  }

  List<bool> _initialAttendance() {
    return initialStudents
        .map((Student student) => student.initiallyPresent)
        .toList();
  }

  int get _presentCount => _attendance.where((bool isPresent) => isPresent).length;

  void _setAttendance(int index, bool isPresent) {
    setState(() {
      _attendance[index] = isPresent;
    });
  }

  void _markEveryonePresent() {
    setState(() {
      _attendance = List<bool>.filled(initialStudents.length, true);
    });
  }

  void _restoreInitialAttendance() {
    setState(() {
      _attendance = _initialAttendance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control de asistencia')),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _groupName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$_presentCount/${initialStudents.length} presentes',
                        key: const Key('present-count'),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: <Widget>[
                          FilledButton.icon(
                            key: const Key('mark-all-present'),
                            onPressed: _markEveryonePresent,
                            icon: const Icon(Icons.done_all),
                            label: const Text('Todos presentes'),
                          ),
                          OutlinedButton.icon(
                            key: const Key('restore-initial'),
                            onPressed: _restoreInitialAttendance,
                            icon: const Icon(Icons.restart_alt),
                            label: const Text('Restablecer'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: initialStudents.length,
                itemBuilder: (BuildContext context, int index) {
                  return StudentAttendanceTile(
                    student: initialStudents[index],
                    isPresent: _attendance[index],
                    onChanged: (bool isPresent) =>
                        _setAttendance(index, isPresent),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
