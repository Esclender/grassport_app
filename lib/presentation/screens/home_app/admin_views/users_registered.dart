import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gap/gap.dart';
import 'package:grassport_app/api/api_client.dart';
import 'package:grassport_app/models/user_registered_model.dart';
import 'package:grassport_app/presentation/styles/boxx_shadows.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<UsersInApp> userList = [];
  List<UsersInApp> topUsersList = [];

  //SORITNG
  String filterByName = '';
  List<String> options = ['Nombre', 'Fecha creacion'];
  String orderBy = "Nombre";
  String isAscendingOrder = 'asc';

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

  sortList({orderBy, orden}) async {
    switch (orderBy) {
      case 'Nombre':
        List<UsersInApp> sortedData = await _myClient.getUsersRegisteredList(
          orderBy: 'nombre',
          orden: orden,
        );

        setState(() {
          userList = sortedData;
        });
        break;
      case 'Fecha creacion':
        List<UsersInApp> sortedData = await _myClient.getUsersRegisteredList(
          orderBy: 'fecha_creacion',
          orden: orden,
        );

        setState(() {
          userList = sortedData;
        });
        break;
      default:
    }
  }

  filterList({filtro}) async {
    List<UsersInApp> filteredData = await _myClient.getUsersRegisteredList(
      filtroName: filtro,
    );

    setState(() {
      userList = filteredData;
    });
  }

  clearFilter() async {
    List<UsersInApp> filteredData = await _myClient.getUsersRegisteredList();

    setState(() {
      userList = filteredData;
      filterByName = '';
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
                    margin: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.all(5.0),
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
      floatingActionButton: SpeedDial(
        renderOverlay: false,
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: c8,
        children: _buildSpeedChild(),
      ),
    );
  }

  List<SpeedDialChild> _buildSpeedChild() {
    return [
      SpeedDialChild(
        child: const Icon(Icons.filter_alt_outlined),
        backgroundColor: c8,
        label: 'Filtro',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: c8,
        ),
        onTap: () {
          _showFilterDialog(context);
        },
      ),
      SpeedDialChild(
        child: const Icon(Icons.compare_arrows_rounded),
        backgroundColor: c8,
        label: 'Ordenar',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: c8,
        ),
        onTap: () {
          _showOrderDialog(context);
        },
      ),
      SpeedDialChild(
        child: const Icon(Icons.cleaning_services),
        backgroundColor: c8,
        label: 'Limpiar',
        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: c8,
        ),
        onTap: () {
          clearFilter();
        },
      ),
    ];
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filtro por nombre'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                filterByName = value;
              });
            },
            decoration: const InputDecoration(
              hintText: 'Ingresa el filtro',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await filterList(filtro: filterByName);
              },
              child: const Text('Filtrar'),
            ),
          ],
        );
      },
    );
  }

  void _showOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Opciones de orden'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: orderBy,
                    onChanged: (value) {
                      setState(() {
                        orderBy = value!;
                      });
                    },
                    items: options
                        .map((String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Orden ascendente'),
                      StatefulBuilder(builder: ((context, setState) {
                        return Checkbox(
                          value: isAscendingOrder == 'asc',
                          onChanged: (value) {
                            //ORDEN TYPE
                            if (isAscendingOrder == 'asc') {
                              setState(() {
                                isAscendingOrder = 'desc';
                              });
                            } else {
                              setState(() {
                                isAscendingOrder = 'asc';
                              });
                            }
                          },
                        );
                      }))
                    ],
                  ),
                ],
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await sortList(orderBy: orderBy, orden: isAscendingOrder);
              },
              child: const Text('Ordenar'),
            ),
          ],
        );
      },
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
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side (user photo, name, email)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [neoShadow],
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
                                Text(
                                  user.numero,
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
                const Spacer(),
                const Spacer(),
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
