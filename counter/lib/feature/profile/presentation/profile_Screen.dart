import 'package:counter/core/constants/app_color.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/Profile image@3x.png'), // Replace with your image
            ),
            SizedBox(height: 10),
            Text(
              'Youssef Mohamed',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Ym1067415446@gmail.com',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 20),
            Divider(),
            Row(
              children: [
                Text("Account Seting ",style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ) ,
            _buildProfileOption(Icons.location_on, 'Address'),
            _buildProfileOption(Icons.payment, 'Payment Method'),
            _buildProfileOption(Icons.notifications, 'Notification', isSwitch: true),
            _buildProfileOption(Icons.security, 'Account Security', badgeCount: 24),
            Divider(),
            _buildProfileOption(Icons.group, 'Invite Friends'),
            _buildProfileOption(Icons.privacy_tip, 'Privacy Policy'),
            _buildProfileOption(Icons.help_center, 'Help Center'),
            Divider(),
            _buildLogoutOption(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, {bool isSwitch = false, int? badgeCount}) {
    return ListTile(
      leading: Icon(icon, color: AppColor.buttonColor),
      title: Text(title),
      trailing: isSwitch
          ? Switch(value: true, activeTrackColor: Colors.green,onChanged: (value) {})
          : badgeCount != null
          ? Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColor.buttonColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '$badgeCount',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      )
          : Icon(Icons.arrow_forward_ios, size: 16, color: AppColor.buttonColor),
      onTap: () {},
    );
  }

  Widget _buildLogoutOption() {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.logout, color: Colors.red),
      ),
      title: Text(
        'Logout',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
      onTap: () {},
    );
  }
}
