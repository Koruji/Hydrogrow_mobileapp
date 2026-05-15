import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';

class Parcel {
  final String id;
  final String name;
  final String location;
  final String type;
  final int nbPlant;
  final String status;
  final DateTime commissioningDate;
  final String? notes;

  Parcel({
    required this.id,
    required this.name,
    required this.location,
    required this.type,
    required this.nbPlant,
    required this.status,
    required this.commissioningDate,
    this.notes,
  });

  factory Parcel.fromJson(Map<String, dynamic> json) {
    return Parcel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      type: json['type'] ?? '',
      nbPlant: json['nb_plant'] ?? 0,
      status: json['status'] ?? 'planned',
      commissioningDate: DateTime.parse(
        json['commissioning_date'] ?? DateTime.now().toIso8601String(),
      ),
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'type': type,
      'nb_plant': nbPlant,
      'status': status,
      'commissioning_date': commissioningDate.toIso8601String(),
      'notes': notes,
    };
  }

  Color getStatusColor() {
    switch (status) {
      case 'active':
        return AppColors.success;
      case 'planned':
      case 'setup':
        return AppColors.notification;
      case 'maintenance':
      case 'inactive':
        return AppColors.warning;
      case 'retired':
        return AppColors.textSecondary;
      default:
        return AppColors.textSecondary;
    }
  }

  String getStatusLabel() {
    switch (status) {
      case 'active':
        return 'Active';
      case 'planned':
        return 'Planifiée';
      case 'setup':
        return 'En installation';
      case 'maintenance':
        return 'Maintenance';
      case 'retired':
        return 'Retirée';
      case 'inactive':
        return 'Inactive';
      default:
        return status;
    }
  }

  IconData getTypeIcon() {
    switch (type.toLowerCase()) {
      case 'hydroponie':
        return Icons.water;
      case 'serre':
        return Icons.home_work;
      case 'plein air':
        return Icons.wb_sunny;
      case 'aquaponie':
        return Icons.set_meal;
      default:
        return Icons.grass;
    }
  }

  Parcel copyWith({
    String? id,
    String? name,
    String? location,
    String? type,
    int? nbPlant,
    String? status,
    DateTime? commissioningDate,
    String? notes,
  }) {
    return Parcel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      type: type ?? this.type,
      nbPlant: nbPlant ?? this.nbPlant,
      status: status ?? this.status,
      commissioningDate: commissioningDate ?? this.commissioningDate,
      notes: notes ?? this.notes,
    );
  }
}
