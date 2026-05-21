import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA1...",
      authDomain: "proje-idsi.firebaseapp.com",
      projectId: "proje-idsi",
      storageBucket: "proje-idsi.firebasestorage.app",
      messagingSenderId: "123456789012",
      appId: "1:123456789012:web:abc123xyz",
      measurementId: "G-XXXXXXXXXX"
    ),
  ); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff1e293b), 
          brightness: Brightness.light
        ),
        useMaterial3: true,
      ),
      home: const TodoHomeScreen(),
    );
  }
}

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final Map<String, IconData> todoIcons = {
    'Genel': Icons.blur_on_rounded,
    'Sosyal': Icons.co_present_outlined,
    'Finans': Icons.account_balance_wallet_outlined,
    'Akademik': Icons.auto_stories_outlined,
    'Sağlık': Icons.favorite_border_rounded,
    'Fikir': Icons.lightbulb_outline_rounded,
    'Yazılım': Icons.code_rounded,
    'Eğlence': Icons.celebration_rounded,
    'Seyahat': Icons.explore_outlined,
    'Acil': Icons.new_releases_outlined,
  };

  void _showAddTodoBottomSheet() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController subtitleController = TextEditingController();
    String selectedIconKey = 'Genel'; 
    DateTime selectedDate = DateTime.now();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xfff8fafc), 
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder( 
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                top: 24,
                left: 24,
                right: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Yeni Görev Ekle',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff0f172a)),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Başlık',
                      prefixIcon: const Icon(Icons.title_rounded),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: subtitleController,
                    decoration: InputDecoration(
                      labelText: 'Açıklama / Detay',
                      prefixIcon: const Icon(Icons.description_outlined),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 14),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('Kategori: ', style: TextStyle(fontWeight: FontWeight.w600)),
                          DropdownButton<String>(
                            value: selectedIconKey,
                            dropdownColor: const Color(0xfff8fafc),
                            items: todoIcons.keys.map((String key) {
                              return DropdownMenuItem<String>(
                                value: key,
                                child: Row(
                                  children: [
                                    Icon(todoIcons[key], color: const Color(0xff0284c7)),
                                    const SizedBox(width: 8),
                                    Text(key),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setModalState(() => selectedIconKey = value);
                              }
                            },
                          ),
                        ],
                      ),
                      
                      TextButton.icon(
                        icon: const Icon(Icons.calendar_month_rounded, color: Color(0xff0284c7)),
                        label: Text(
                          DateFormat('dd/MM/yyyy').format(selectedDate),
                          style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xff0284c7)),
                        ),
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now().subtract(const Duration(days: 365)),
                            lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                          );
                          if (picked != null) {
                            setModalState(() => selectedDate = picked);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff0f172a),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        if (titleController.text.trim().isNotEmpty) {
                          await FirebaseFirestore.instance.collection('ajanda_verileri').add({
                            'g_baslik': titleController.text.trim(),
                            'g_detay': subtitleController.text.trim(),
                            'g_ikon': selectedIconKey,
                            'g_tarih': DateFormat('dd/MM/yyyy').format(selectedDate),
                            'g_durum': false, 
                            'kayit_tarihi': FieldValue.serverTimestamp(), 
                          });
                          if (context.mounted) Navigator.pop(context);
                        }
                      },
                      child: const Text('Kaydet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f5f9),
      appBar: AppBar(
        title: const Text('ToDo List', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.5)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xff0f172a),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ajanda_verileri').orderBy('kayit_tarihi', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Veri akışında bir hata oluştu!'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final docs = snapshot.data?.docs ?? [];
          
          if (docs.isEmpty) {
            return const Center(child: Text('Henüz bir görev planlanmamış.', style: TextStyle(color: Colors.grey)));
          }
          
          return ListView.builder(
            itemCount: docs.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemBuilder: (context, index) {
              final doc = docs[index];
              final data = doc.data() as Map<String, dynamic>;
              
              final String title = data['g_baslik'] ?? '';
              final String subtitle = data['g_detay'] ?? '';
              final String iconKey = data['g_ikon'] ?? 'Rutin';
              final String date = data['g_tarih'] ?? '';
              final bool isDone = data['g_durum'] ?? false;
              
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 2)),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  leading: CircleAvatar(
                    backgroundColor: isDone ? Colors.grey.shade100 : const Color(0xffe0f2fe),
                    child: Icon(
                      todoIcons[iconKey] ?? Icons.task, 
                      color: isDone ? Colors.grey : const Color(0xff0369a1)
                    ),
                  ),
                  title: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
                      color: isDone ? Colors.grey.shade400 : const Color(0xff1e293b),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '$subtitle\nTarih: $date', 
                      style: TextStyle(color: isDone ? Colors.grey.shade400 : const Color(0xff64748b), fontSize: 13)
                    ),
                  ),
                  isThreeLine: true,
                  trailing: Transform.scale(
                    scale: 1.05,
                    child: Checkbox(
                      value: isDone,
                      activeColor: const Color(0xff0f172a),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      onChanged: (bool? value) async {
                        if (value != null) {
                          await FirebaseFirestore.instance.collection('ajanda_verileri').doc(doc.id).update({
                            'g_durum': value,
                          });
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoBottomSheet,
        backgroundColor: const Color(0xff0f172a),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}