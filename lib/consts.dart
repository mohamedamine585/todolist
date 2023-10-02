import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/Backend/modules/User.dart';

double screenwidth = 0;
double screenlength = 0;

User? user;
CollectionReference? userscollection,
    taskscollection,
    groupscollection,
    grouptaskscollection;
