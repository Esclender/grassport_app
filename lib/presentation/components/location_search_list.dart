import 'package:flutter/material.dart';
import 'package:grassport_app/models/lis_item_model.dart';
import 'package:grassport_app/presentation/components/location_search_list_items.dart';
import 'package:grassport_app/presentation/styles/colors.dart';

class Searching extends StatefulWidget {
  final dynamic historyData;
  final int? header;
  final List<LocationTagModel> registros;
  final bool isHomeSearch;

  const Searching({
    super.key,
    required this.historyData,
    required this.registros,
    this.header,
    this.isHomeSearch = false,
  });

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 50, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.header != null
              ? Header(historyData: widget.header)
              : Header(
                  historyData:
                      widget.historyData.state), //widget.historyData.state
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: 300,
              child: widget.registros.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        LocationTagModel registro = widget.registros[index];

                        return LocationTag(
                          isHomeSearch: widget.isHomeSearch,
                          latLng: registro.location,
                          leading: registro.leading == 'history'
                              ? const Icon(Icons.history)
                              : const Icon(Icons.location_city),
                          department: registro.department,
                          location: registro.street,
                          placeId: registro.placeId,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: widget.registros.length,
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.wysiwyg_rounded,
                          color: c10,
                        ),
                        Text(
                          'Sin datos',
                          style: TextStyle(color: c10),
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class ListOfResults extends StatefulWidget {
  const ListOfResults({super.key});

  @override
  State<ListOfResults> createState() => _ListOfResultsState();
}

class _ListOfResultsState extends State<ListOfResults> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// ignore: must_be_immutable
class Header extends StatelessWidget {
  int? historyData;

  Header({super.key, this.historyData = 0});

  String getHeader() {
    switch (historyData) {
      case 2:
        return 'Direcciones guardadas';
      case 1:
        return 'Resultados';
      case 0:
        return 'Busquedas recientes';
      default:
        return 'Busquedas recientes';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getHeader(),
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
