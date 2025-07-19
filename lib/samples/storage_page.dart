import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StoragePage extends StatefulWidget {
  const StoragePage({super.key});

  @override
  State<StoragePage> createState() => _StoragePageState();
}

class _StoragePageState extends State<StoragePage> {
  bool _uploading = false;
  List<Reference> _files = [];
  bool _loadingFiles = false;
  String? _selectedDownloadUrl;

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário não autenticado!')),
        );
      }
      return;
    }

    if (!mounted) return;
    setState(() => _uploading = true);
    final file = pickedFile;
    final storageRef = FirebaseStorage.instance.ref().child(
      'uploads/$uid/${DateTime.now().millisecondsSinceEpoch}_${file.name}',
    );
    try {
      await storageRef.putData(await file.readAsBytes());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Upload realizado!')),
        );
      }
      await _listFiles();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao fazer upload: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _listFiles() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      setState(() => _files = []);
      return;
    }
    setState(() => _loadingFiles = true);
    try {
      final result = await FirebaseStorage.instance
          .ref('uploads/$uid')
          .listAll();
      if (!mounted) return;
      setState(() => _files = result.items);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao listar arquivos: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loadingFiles = false);
    }
  }

  Future<void> _deleteFile(Reference ref) async {
    try {
      await ref.delete();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Arquivo excluído!')),
        );
        await _listFiles();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao excluir: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _listFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firebase Storage Test')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Moldura fixa para preview da imagem selecionada
            Container(
              height: 180,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[100],
              ),
              child: _selectedDownloadUrl != null
                  ? Image.network(_selectedDownloadUrl!, height: 150)
                  : const Text('Selecione uma imagem para visualizar'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _uploading ? null : _pickAndUploadImage,
              child: _uploading
                  ? const CircularProgressIndicator()
                  : const Text('Selecionar e Enviar Imagem'),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Arquivos no Storage:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadingFiles ? null : _listFiles,
                ),
              ],
            ),
            if (_loadingFiles)
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            if (!_loadingFiles && _files.isEmpty)
              const Text('Nenhum arquivo encontrado.'),
            if (!_loadingFiles && _files.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _files.length,
                  itemBuilder: (context, index) {
                    final ref = _files[index];
                    String displayName = ref.name;
                    if (displayName.length > 30) {
                      displayName =
                          '...${displayName.substring(displayName.length - 30)}';
                    }
                    return FutureBuilder<String>(
                      future: ref.getDownloadURL(),
                      builder: (context, snapshot) {
                        return ListTile(
                          title: Text(displayName),
                          onTap: snapshot.hasData
                              ? () {
                                  setState(() {
                                    _selectedDownloadUrl = snapshot.data;
                                  });
                                }
                              : null,
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteFile(ref),
                          ),
                        );
                      },
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
