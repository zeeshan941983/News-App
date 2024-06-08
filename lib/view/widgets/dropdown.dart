import 'package:flutter/material.dart';

class HomeDropdown extends StatelessWidget {
  final Function(String?)? onchange;
  final String current;

  const HomeDropdown({
    super.key,
    required this.onchange,
    required this.current,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    return SizedBox(
      width: width * 0.5,
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.black,
        decoration: InputDecoration(
            fillColor: Colors.black,
            filled: true,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(20))),
        borderRadius: BorderRadius.circular(20),
        style: const TextStyle(fontSize: 15, color: Colors.black),
        items: const [
          DropdownMenuItem<String>(
            value: 'abc-news',
            child: Text(
              "ABC",
              style: TextStyle(color: Colors.white),
            ),
          ),
          DropdownMenuItem<String>(
            value: 'ary-news',
            child: Text("Ary News", style: TextStyle(color: Colors.white)),
          ),
          DropdownMenuItem<String>(
            value: 'al-jazeera-english',
            child: Text("Al Jazeera", style: TextStyle(color: Colors.white)),
          ),
          DropdownMenuItem<String>(
            value: 'aftenposten',
            child: Text("AftenPosten", style: TextStyle(color: Colors.white)),
          ),
          DropdownMenuItem<String>(
            value: 'ansa',
            child: Text("Ansa", style: TextStyle(color: Colors.white)),
          ),
          DropdownMenuItem<String>(
            value: 'bbc-news',
            child: Text("BBC", style: TextStyle(color: Colors.white)),
          ),
        ],
        onChanged: onchange,
        hint: Text(
          current,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
