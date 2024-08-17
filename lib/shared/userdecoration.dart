
import 'package:flutter/material.dart';

const decoration = InputDecoration(
          // To delete borders
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          // fillColor: Colors.red,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
        );