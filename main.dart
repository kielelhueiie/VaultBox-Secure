import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(VaultApp());

class VaultApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: VaultScreen(),
    );
  }
}

class VaultScreen extends StatefulWidget {
  @override
  _VaultScreenState createState() => _VaultScreenState();
}

class _VaultScreenState extends State<VaultScreen> {
  String _generatedPassword = "";
  final TextEditingController _passwordController = TextEditingController();

  void _generatePassword() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()';
    Random rnd = Random();
    String newPassword = String.fromCharCodes(
      Iterable.generate(16, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
    setState(() {
      _generatedPassword = newPassword;
    });
  }

  // Nouvelle fonction pour simuler le déverrouillage
  void _unlockVault() {
    if (_passwordController.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Access Granted"),
          content: Text("Secure data decrypted successfully."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_outline, size: 80, color: Colors.blueAccent),
              SizedBox(height: 10),
              Text(
                "VaultBox Secure",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),

              if (_generatedPassword.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SelectableText(
                    _generatedPassword,
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),

              TextField(
                controller: _passwordController, // On lie le contrôleur ici
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Master Password',
                ),
              ),
              SizedBox(height: 20),

              // Bouton 1 : Générer
              ElevatedButton(
                onPressed: _generatePassword,
                child: Text("Generate Secure Key"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(200, 50),
                ),
              ),

              SizedBox(height: 10),

              // Bouton 2 : Déverrouiller
              TextButton(
                onPressed: _unlockVault,
                child: Text(
                  "Unlock Data",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
