import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/user_registered_model.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<UsersInApp> userList = [];
  List<UsersInApp> topUsersList = [];

  final ApiClient _myClient = ApiClient();

  @override
  void initState() {
    setUserList();
    setTopUsers();

    super.initState();
  }

  void setUserList() async {
    List<UsersInApp> data = await _myClient.getUsersRegisteredList();

    setState(() {
      userList = data;
    });
  }

  void setTopUsers() async {
    List<UsersInApp> data = await _myClient.getTopUsersRegistered();

    setState(() {
      topUsersList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userList.isEmpty || topUsersList.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Lista de usuarios',
          style: TextStyle(color: c1, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // Horizontal list of top 10 users
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: topUsersList.length,
              itemBuilder: (context, index) {
                UsersInApp topUser = topUsersList[index];
                return GestureDetector(
                  onTap: () => _showUserDialog(context, topUser),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: EdgeInsets.all(10.0),
                    child: Container(
                      width: 80,
                      margin: EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(topUser.photoURL),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            topUser.nombre,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // List of all users
          Expanded(
            child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                UsersInApp user = userList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    onTap: () => _showUserDialog(context, user),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.photoURL),
                    ),
                    title: Text(user.nombre),
                    subtitle: Text(user.email),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Add action for the first floating button
            },
            child: const Icon(Icons.filter_alt_outlined),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Add action for the second floating button
            },
            child: const Icon(Icons.compare_arrows_rounded),
          ),
        ],
      ),
    );
  }

  void _showUserDialog(BuildContext context, UsersInApp user) {
    final Color textColor = c8;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          backgroundColor: c1,
          child: Container(
            height: 300, // Set the height of the dialog
            padding: EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side (user photo, name, email)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.greenAccent,
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            offset: Offset(0.0, 0.0),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL),
                        radius: 30, // Set the radius of the photo
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const Gap(16),
                    Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildIconTextRow(Icons.person, 'Perfil general'),
                          Container(
                            margin: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.nombre,
                                  style: TextStyle(color: textColor),
                                ),
                                Text(
                                  user.email,
                                  style: TextStyle(color: textColor),
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),
                          _buildIconTextRow(Icons.info, 'Info de la cuenta'),
                          Container(
                            margin: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Creación: ${user.fecha_creacion}',
                                  style: TextStyle(color: textColor),
                                ),
                                Text(
                                  'Último Ingreso: ${user.fecha_ultimo_ingreso}',
                                  style: TextStyle(color: textColor),
                                ),
                              ],
                            ),
                          ),
                          const Gap(8),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(), // Add space between left and right
                // Right side (conteo_ingresos inside a circle)
                const Spacer(), // Add space between left and right
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: c8,
                  ),
                  child: Center(
                    child: Text(
                      user.conteo_ingresos.toString(),
                      style: TextStyle(color: c1, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIconTextRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          color: c8,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(color: c8, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
