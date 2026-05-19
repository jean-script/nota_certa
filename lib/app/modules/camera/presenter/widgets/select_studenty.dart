import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ml_nota_certa/app/modules/camera/presenter/controllers/camera_controller.dart';
import 'package:ml_nota_certa/app/modules/school/presenter/controllers/school_controller.dart';

class StudentSelector extends StatelessWidget {
  const StudentSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final students = SchoolController.to.students;

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Obx(() {
        return DropdownButtonFormField<String>(
          initialValue: MyCameraController.to.selectedStudentId.value,

          // initialValue: MyCameraController.to.selectedStudentId.value,
          decoration: InputDecoration(
            labelText: 'Selecionar aluno',
            labelStyle: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade100),
            ),
          ),

          items: students.map((student) {
            return DropdownMenuItem<String>(
              value: student.id,
              child: Text(
                '${student.name} • ${student.registration}',
                style: TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
          onChanged: (value) {
            MyCameraController.to.selectedStudentId.value = value;
          },
        );
      }),
    );
  }
}
