import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final nameCtrl = TextEditingController();

  String gender = 'M';
  bool agree = false;

  List<Map<String, dynamic>> items = [];

  static const _key = 'entries';

  int? editIndex;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString(_key);

    if (data != null) {
      setState(() {
        items = List<Map<String, dynamic>>.from(jsonDecode(data));
      });
    }
  }

  Future<void> _save() async {
    if (nameCtrl.text.trim().isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter name')));
      return;
    }

    items.add({'name': nameCtrl.text.trim(), 'gender': gender, 'agree': agree});

    await _saveToPreferences();
    nameCtrl.clear();

    setState(() {
      gender = 'M';
      agree = false;
    });
  }

  Future<void> _update() async {
    if (nameCtrl.text.trim().isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter name')));
      return;
    }

    if (editIndex != null) {
      items[editIndex!] = {
        'name': nameCtrl.text.trim(),
        'gender': gender,
        'agree': agree,
      };

      await _saveToPreferences();
      nameCtrl.clear();

      setState(() {
        gender = 'M';
        agree = false;
        editIndex = null;
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data Updated Successfully')),
      );
    }
  }

  Future<void> _saveToPreferences() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_key, jsonEncode(items));
    setState(() {});
  }

  void _edit(int index) {
    final data = items[index];
    nameCtrl.text = data['name'];

    setState(() {
      gender = data['gender'];
      agree = data['agree'];
      editIndex = index;
    });
  }

  Future<void> _delete(int index) async {
    items.removeAt(index);
    await _saveToPreferences();
    setState(() {});

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Data Deleted')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Form')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            RadioListTile<String>(
              title: const Text('Male'),
              value: 'M',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text('Female'),
              value: 'F',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('I Agree'),
              value: agree,
              onChanged: (value) {
                setState(() {
                  agree = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: editIndex == null ? _save : _update,
              child: Text(editIndex == null ? 'Save' : 'Update'),
            ),
            if (editIndex != null)
              TextButton(
                onPressed: () {
                  nameCtrl.clear();
                  setState(() {
                    gender = 'M';
                    agree = false;
                    editIndex = null;
                  });
                },
                child: const Text('Cancel'),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final data = items[index];

                  return Card(
                    child: ListTile(
                      title: Text(data['name']),
                      subtitle: Text(
                        'Gender: ${data['gender']} | Agree: ${data['agree']}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _edit(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _showDeleteDialog(index),
                          ),
                        ],
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

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete'),
          content: const Text('Are you sure you want to delete this data?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _delete(index);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}


// void _update() {
//   temp_index = index;
//   nameCtrl.text = items[index]['name'];
//   gender = items[index]['gender'];
//   agree = items[index]['agree'];
// }


// Future<void> _update() async{
//   if (nameCtrl.text.trim().isEmpty) return;
//   items[temp_index] = ({
//     'name': nameCtrl.text.trim(),
//     'gender': gender,
//     'agree': agree,
//   });
//   final pref = await SharedPreferences.getInstance();
//   await pref.setString(_key, jsonEncode(items));
//   nameCtrl.clear();
//   setState(() {
//     gender = 'M';
//     agree = false;
//   });
// }

// return ListTile(
//   leading:IconButton(
//     icon: const Icon(Icons.edit),
//     onPressed: () {
//       _update_index(index),
      
//     },
//   ),
// )


