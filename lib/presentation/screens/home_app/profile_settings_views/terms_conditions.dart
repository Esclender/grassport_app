import 'package:flutter/material.dart';

String content =
    "Bienvenido(a) a nuestra aplicación GrasSport. Antes de utilizar nuestra aplicación, te pedimos que leas detenidamente los siguientes Términos y Condiciones de Uso. Al descargar, instalar y utilizar nuestra aplicación, aceptas cumplir con estos términos y condiciones. \n \n 1. Aceptación de los Términos y Condiciones: Al utilizar nuestra aplicación, aceptas estar sujeto(a) a estos Términos y Condiciones . Si no estás de acuerdo con alguno de los términos establecidos aquí, te pedimos que no utilices nuestra aplicación. \n \n 2. Uso de la Aplicación: Nuestra aplicación tiene como objetivo principal facilitar la búsqueda de canchas de grass utilizando la tecnología de geolocalización. Podrás visualizar en un mapa las canchas cercanas a tu ubicación, así como obtener información detallada sobre cada una de ellas, como horarios, precios y servicios adicionales. \n \n 3. Responsabilidades del Usuario: Al utilizar nuestra aplicación, aceptas que eres responsable de cualquier información que proporciones, así como de cualquier acción que realices dentro de la aplicación. Debes utilizar la aplicación de manera ética y legal, y no debes utilizarla para actividades ilegales o fraudulentas. \n \n 4. Exactitud de la Información: Hacemos todo lo posible por proporcionar información precisa y actualizada sobre las canchas de grass disponibles en nuestra aplicación. Sin embargo, no podemos garantizar la exactitud de dicha información, ya que dependemos de terceros para obtenerla. Por lo tanto, no nos hacemos responsables de cualquier error, omisión o inexactitud en la información proporcionada. \n \n 5. Privacidad: Respetamos tu privacidad y nos comprometemos a proteger tus datos personales de acuerdo con nuestra Política de Privacidad. Al utilizar nuestra aplicación, aceptas el procesamiento de tus datos personales de acuerdo con dicha política. \n \n 6. Propiedad Intelectual: Todos los derechos de propiedad intelectual relacionados con nuestra aplicación, incluyendo pero no limitado a los diseños, logotipos, nombres comerciales y contenido, son propiedad exclusiva nuestra o de nuestros licenciantes. No se permite la reproducción, distribución o modificación de ningún elemento de nuestra aplicación sin nuestro consentimiento previo por escrito. \n \n 7. Modificaciones: Nos reservamos el derecho de modificar o actualizar estos Términos y Condiciones de Uso en cualquier momento y sin previo aviso. Te recomendamos que revises periódicamente estos términos para estar al tanto de cualquier cambio. \n \n 8. Contacto Si tienes alguna pregunta, comentario o inquietud sobre nuestros Términos y Condiciones de Uso, no dudes en contactarnos a través de los canales de comunicación proporcionados en nuestra aplicación. Al utilizar nuestra aplicación, aceptas estos Términos y Condiciones de Uso. Te recomendamos que los leas detenidamente y los comprendas antes de utilizar nuestra aplicación. ¡Disfruta de tu experiencia en GrasSport!";

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Terms and Conditions'),
          surfaceTintColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Text(content),
            ],
          ),
        ));
  }
}
