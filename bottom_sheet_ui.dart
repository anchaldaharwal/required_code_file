import 'package:flutter/material.dart';

class OrderDetailsModel {
  final UserInfo user;
  final String address;
  final String serviceType;
  final String description;
  final VehicleInfo vehicle;

  OrderDetailsModel({
    required this.user,
    required this.address,
    required this.serviceType,
    required this.description,
    required this.vehicle,
  });
}

class UserInfo {
  final String name;
  final String email;
  final String phone;
  final String profileImage;

  UserInfo({
    required this.name,
    required this.email,
    required this.phone,
    required this.profileImage,
  });
}

class VehicleInfo {
  final String name;
  final String model;
  final String fuel;
  final String number;
  final String color;

  VehicleInfo({
    required this.name,
    required this.model,
    required this.fuel,
    required this.number,
    required this.color,
  });
}

void showOrderDetailsSheet(BuildContext context, OrderDetailsModel data) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: const Offset(0, 0.1),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: 1,
          child: _OrderDetailsContent(data: data),
        ),
      );
    },
  );
}

class _OrderDetailsContent extends StatelessWidget {
  final OrderDetailsModel data;

  const _OrderDetailsContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.80,
      maxChildSize: 0.95,
      minChildSize: 0.40,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade900 : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                _sectionTitle(Icons.person, "Customer Details"),
                _userCard(data),

                _sectionTitle(Icons.location_on, "Current Location"),
                _infoCard(data.address),

                _sectionTitle(Icons.build, "Service Type"),
                _infoCard(data.serviceType),

                _sectionTitle(Icons.description, "Description"),
                _infoCard(
                  data.description.isNotEmpty
                      ? data.description
                      : "No description provided",
                ),

                _sectionTitle(Icons.car_repair, "Vehicle Information"),
                _vehicleCard(data.vehicle),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  // ---------- SECTION TITLE ----------
  Widget _sectionTitle(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.red, size: 18),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- USER CARD ----------
  Widget _userCard(OrderDetailsModel data) {
    return _card(
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: NetworkImage(data.user.profileImage),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.user.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.user.email,
                  style: TextStyle(fontSize: 13.5, color: Colors.grey.shade800),
                ),
                Text(
                  data.user.phone,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ---------- BASIC INFO CARD ----------
  Widget _infoCard(String text) {
    return _card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  // ---------- VEHICLE CARD ----------
  Widget _vehicleCard(VehicleInfo v) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _vehicleItem("Vehicle Name", v.name),
          _vehicleItem("Model", v.model),
          _vehicleItem("Fuel Type", v.fuel),
          _vehicleItem("Number", v.number),
          _vehicleItem("Color", v.color),
        ],
      ),
    );
  }

  Widget _vehicleItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- CARD WRAPPER ----------
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
