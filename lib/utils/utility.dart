import 'package:flutter/material.dart';

/// Mobile responsive break point
bool kIsMobile(BuildContext context) =>
    MediaQuery.of(context).size.width <= 500;
