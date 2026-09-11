/// Datos inmutables de un estudiante y su asistencia inicial.
class Student {
  const Student({
    required this.name,
    required this.id,
    required this.initiallyPresent,
  });

  final String name;
  final String id;
  final bool initiallyPresent;
}

const List<Student> initialStudents = <Student>[
  Student(name: 'Andrea Martínez', id: '20260101', initiallyPresent: true),
  Student(name: 'Carlos Hernández', id: '20260102', initiallyPresent: false),
  Student(name: 'Daniela Rivera', id: '20260103', initiallyPresent: true),
  Student(name: 'Eduardo López', id: '20260104', initiallyPresent: true),
  Student(name: 'Fernanda Castillo', id: '20260105', initiallyPresent: false),
  Student(name: 'Gabriel Ramírez', id: '20260106', initiallyPresent: true),
  Student(name: 'Isabel Mendoza', id: '20260107', initiallyPresent: true),
  Student(name: 'Jorge Álvarez', id: '20260108', initiallyPresent: false),
  Student(name: 'Karla Flores', id: '20260109', initiallyPresent: true),
  Student(name: 'Luis González', id: '20260110', initiallyPresent: false),
  Student(name: 'María Pineda', id: '20260111', initiallyPresent: true),
  Student(name: 'Nicolás Torres', id: '20260112', initiallyPresent: false),
];
