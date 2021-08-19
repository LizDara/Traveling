import 'package:flutter/material.dart';
import 'package:traveling/src/models/notification_model.dart';
import 'package:traveling/src/models/searchTicket_model.dart';
import 'package:traveling/src/providers/TravelProvider.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    print('Ida Vuelta: ' + data["ida_vuelta"]);
    print('Numero viajeros: ' + data["numero_viajeros"]);
    final Notify notification = new Notify(
        fechaSalida: data["fecha_salida"],
        fechaLlegada: data["fecha_llegada"],
        salidaIsoCodigo: data["salida_iso_codigo"],
        llegadaIsoCodigo: data["llegada_iso_codigo"],
        idaVuelta: data["ida_vuelta"].toString() == 'true',
        numeroViajeros: int.parse(data["numero_viajeros"].toString()),
        segmentoId: data["segmento_id"],
        segmentoSalidaIataCodigo: data["segmento_salida_iata_codigo"],
        segmentoSalidaHora: data["segmento_salida_hora"],
        segmentoLlegadaIataCodigo: data["segmento_llegada_iata_codigo"],
        segmentoLlegadaHora: data["segmento_llegada_hora"],
        segmentoCodigoAerolinea: data["segmento_codigo_aerolinea"],
        segmentoDuracion: data["segmento_duracion"],
        segmentoCodigoVuelo: data["segmento_codigo_vuelo"],
        segmentoCodigoAvion: data["segmento_codigo_avion"],
        menos30Minutos: data["menos_30_minutos"],
        entre30Y60Minutos: data["entre_30_y_60_minutos"],
        entre60MinutosY120Minutos: data["entre_60_y_120_minutos"],
        mas60MinutosOCancelado: data["mas_60_minutos_o_cancelado"],
        reservaId: data["reserva_id"],
        lugarSalida: data["lugar_salida"],
        lugarLlegada: data["lugar_llegada"]);
    return Scaffold(
      key: scaffoldKey,
      body: Stack(
        children: <Widget>[
          Background(),
          Notifications(
            scaffoldKey: scaffoldKey,
            notification: notification,
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.chevron_left,
          color: Colors.white60,
        ),
        backgroundColor: Color.fromRGBO(6, 6, 6, 1),
        onPressed: () => Navigator.of(context).pushReplacementNamed('main'),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(89, 72, 119, 1),
              Color.fromRGBO(149, 86, 135, 1)
            ]),
      ),
    );
  }
}

class Notifications extends StatefulWidget {
  Notifications({Key? key, this.scaffoldKey, required this.notification})
      : super(key: key);
  final scaffoldKey;
  final Notify notification;

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 14),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
                color: Colors.white54, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/pass.png'),
                  height: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'El vuelo ' +
                            (widget.notification.segmentoCodigoVuelo ?? '') +
                            ' en fecha ' +
                            _getDateTime(
                                widget.notification.segmentoSalidaHora ?? '') +
                            ' tiene una probabilidad de ' +
                            widget.notification.menos30Minutos!
                                .substring(2, 2) +
                            '% de ser retrasado menos de 30 min, ' +
                            widget.notification.entre30Y60Minutos!
                                .substring(2, 2) +
                            '% de ser retrasado entre 30 y 60 min, ' +
                            widget.notification.entre60MinutosY120Minutos!
                                .substring(2, 2) +
                            '% de ser retrasado entre 60 y 120 min. Además la probabilidad de que sea cancelado es un ' +
                            widget.notification.mas60MinutosOCancelado!
                                .substring(2, 2) +
                            '%.',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        '¿Desea obtener un plan de contingencia?',
                        style: TextStyle(fontSize: 13, color: Colors.black54),
                        maxLines: 3,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () => _showDialog(context),
        );
      },
    );
  }

  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Mensaje de Confirmación'),
          content: Text(
              '¿Desea cancelar su reserva y generar un plan de contingencia?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () => _createReservation(context),
              child: Text('OK'),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('CANCELAR'),
            ),
          ],
        );
      },
    );
  }

  _createReservation(BuildContext context) async {
    final TravelProvider travelProvider = new TravelProvider();
    final result =
        await travelProvider.deleteTravel(widget.notification.reservaId ?? '');
    if (result) {
      final fechaSalida = widget.notification.fechaSalida!.split('T');
      final fechaLlegada = widget.notification.fechaLlegada!.split('T');
      final SearchTicket searchTicket = new SearchTicket(
          fromIsoRegion: widget.notification.salidaIsoCodigo,
          fromDateRange: fechaSalida[0],
          fromTimeRange: fechaSalida[1],
          toIsoRegion: widget.notification.llegadaIsoCodigo,
          toDateRange: fechaLlegada[0],
          toTimeRange: fechaLlegada[1],
          travelersNumbers: widget.notification.numeroViajeros,
          roundTrip: widget.notification.idaVuelta,
          fromName: widget.notification.lugarSalida,
          toName: widget.notification.lugarLlegada);
      Navigator.of(context)
          .pushReplacementNamed('offers', arguments: searchTicket);
    } else {
      _showMessage(
          'No se pudo eliminar la reserva. Inténtelo nuevamente por favor.');
    }
  }

  String _getDateTime(String dateTime) {
    if (dateTime.length == 0) return "";
    List<String> separateDateTime = dateTime.split('T');
    List<String> date = separateDateTime[0].split('-');
    String result = '';
    switch (date[1]) {
      case "01":
        result += 'Ene ';
        break;
      case "02":
        result += 'Feb ';
        break;
      case "03":
        result += 'Mar ';
        break;
      case "04":
        result += 'Abr ';
        break;
      case "05":
        result += 'May ';
        break;
      case "06":
        result += 'Jun ';
        break;
      case "07":
        result += 'Jul ';
        break;
      case "08":
        result += 'Ago ';
        break;
      case "09":
        result += 'Sep ';
        break;
      case "10":
        result += 'Oct ';
        break;
      case "11":
        result += 'Nov ';
        break;
      case "12":
        result += 'Dic ';
        break;
    }
    result += date[2];
    return result;
  }

  _showMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );
    widget.scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
