import 'package:flutter/material.dart';
import 'package:hydrogrow/core/theme/colors.dart';
import 'package:hydrogrow/l10n/app_localizations.dart';

class Stock {
  final String id;
  final String name;
  final String brand;
  final String category;
  final int quantity;
  final int minThreshold;
  final String unit;
  final double costPerUnit;
  final String currency;
  final String? expirationDate;
  final String? notes;
  final String? imageUrl;

  Stock({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.quantity,
    required this.minThreshold,
    required this.unit,
    required this.costPerUnit,
    required this.currency,
    this.expirationDate,
    this.notes,
    this.imageUrl,
  });

  /// Crée un Stock à partir du JSON
  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      category: json['category'] ?? '',
      quantity: json['quantity'] ?? 0,
      minThreshold: json['min_threshold'] ?? 0,
      unit: json['unit'] ?? '',
      costPerUnit: (json['cost_per_unit'] ?? 0).toDouble(),
      currency: json['currency'] ?? '€',
      expirationDate: json['expiration_date'],
      notes: json['notes'],
      imageUrl: json['image_url'],
    );
  }

  /// Convertit en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'category': category,
      'quantity': quantity,
      'min_threshold': minThreshold,
      'unit': unit,
      'cost_per_unit': costPerUnit,
      'currency': currency,
      'expiration_date': expirationDate,
      'notes': notes,
      'image_url': imageUrl,
    };
  }

  /// Détermine le statut du stock (rupture, faible, moyen, optimal)
  String getStatus() {
    if (quantity <= 0) return 'rupture';
    if (quantity < minThreshold) return 'faible';
    if (quantity >= minThreshold * 2) return 'optimal';
    return 'moyen';
  }

  /// Retourne la couleur associée au statut
  Color getStatusColor() {
    final status = getStatus();
    switch (status) {
      case 'rupture':
        return AppColors.warning;
      case 'faible':
        return AppColors.warning;
      case 'optimal':
        return AppColors.success;
      default:
        return AppColors.notification;
    }
  }

  /// Retourne le label du statut traduit
  String getStatusLabel(AppLocalizations translate) {
    final status = getStatus();
    switch (status) {
      case 'rupture':
        return 'Rupture';
      case 'faible':
        return 'Faible';
      case 'optimal':
        return 'Optimal';
      default:
        return 'Moyen';
    }
  }

  /// Calcule la valeur totale de cet article en stock
  double getTotalValue() {
    return quantity * costPerUnit;
  }

  /// Vérifie si le stock est critique
  bool isCritical() {
    return quantity <= minThreshold;
  }

  /// Copie l'objet avec des paramètres modifiés
  Stock copyWith({
    String? id,
    String? name,
    String? brand,
    String? category,
    int? quantity,
    int? minThreshold,
    String? unit,
    double? costPerUnit,
    String? currency,
    String? expirationDate,
    String? notes,
    String? imageUrl,
  }) {
    return Stock(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      minThreshold: minThreshold ?? this.minThreshold,
      unit: unit ?? this.unit,
      costPerUnit: costPerUnit ?? this.costPerUnit,
      currency: currency ?? this.currency,
      expirationDate: expirationDate ?? this.expirationDate,
      notes: notes ?? this.notes,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
