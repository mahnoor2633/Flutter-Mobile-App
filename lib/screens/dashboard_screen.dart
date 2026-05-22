// lib/screens/dashboard_screen.dart
import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import '../controllers/subject_controller.dart';
import '../models/subject.dart';
import 'detail_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final SubjectController _subjectController = SubjectController();

  @override
  void initState() {
    super.initState();
    _subjectController.fetchSubjects();
    _subjectController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _subjectController.dispose();
    super.dispose();
  }

  void _showAddDialog() {
    final titleCtrl = TextEditingController();
    final bodyCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Add Course'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: bodyCtrl, decoration: const InputDecoration(labelText: 'Body')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              _subjectController.addSubject(
                Subject(title: titleCtrl.text, body: bodyCtrl.text),
              );
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(int index) {
    final subject = _subjectController.subjects[index];
    final titleCtrl = TextEditingController(text: subject.title);
    final bodyCtrl = TextEditingController(text: subject.body);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Edit Course'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
            TextField(controller: bodyCtrl, decoration: const InputDecoration(labelText: 'Body')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              _subjectController.updateSubject(
                index: index,
                subject: Subject(id: subject.id, title: titleCtrl.text, body: bodyCtrl.text),
              );
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Course'),
        content: const Text('Are you sure you want to delete this course?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              _subjectController.deleteSubject(index);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = AuthController.instance;
    final userName = controller.registeredName ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(userName),
                subtitle: const Text('Welcome to your dashboard'),
              ),
            ),
            const SizedBox(height: 16),
            if (_subjectController.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (_subjectController.error != null)
              Expanded(child: Center(child: Text('Error: ${_subjectController.error}')))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _subjectController.subjects.length,
                  itemBuilder: (context, index) {
                    final subject = _subjectController.subjects[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        title: Text(subject.title),
                        subtitle: Text(subject.body),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showEditDialog(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _confirmDelete(index),
                            ),
                            const Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DetailScreen(subject: subject)),
                        ),
                      ),
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