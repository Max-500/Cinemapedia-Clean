import 'package:flutter/material.dart';

class FullLoader extends StatelessWidget {
  const FullLoader({super.key});

  Stream<String> getLoadingMessages() {
    const List<String> messages = [
      "🎬 ¿Listo para un maratón de pelis? ¡Tu sofá ya sacó palomitas!",
      "🍿 ¡Advertencia! Esta película puede causar risa, llanto, y adicción a las palomitas.",
      "📽️ ¡No es ciencia ficción! Hemos encontrado la peli perfecta para ti.",
      "🍕 Película seleccionada. Recomendación: Combinar con pizza y amigos.",
      "🎥 ¡Acción! Prepara tu manta favorita, que esto se va a poner bueno.",
      "🍫 ¿Película o chocolate? ¿Por qué no los dos?",
      "🎞️ ¿Te apetece una dosis de drama o mejor vamos con risas hoy?",
      "🎉 ¡Tu noche de cine empieza ahora! Solo faltas tú y el control remoto.",
      "🍔 Cine, comida rápida y diversión... ¡La trilogía perfecta!",
      "😎 Pon tus gafas de sol... porque esta peli es tan genial que brilla.",
      "🕶️ Película en 3, 2, 1... ¡No olvides tus gafas de cine (o de sol)!",
      "👀 ¿Buscando algo para ver? ¡Tenemos más opciones que el menú del cine!",
      "🚪 No necesitas salir de casa para una experiencia cinematográfica épica.",
      "🛋️ Tu sofá + nuestras pelis = la mejor cita que tendrás esta semana.",
      "🥤 Prepárate un mega combo de snacks... ¡la peli lo merece!",
      "🎬 Luces, cámara... ¡Disfruta! Porque mereces un buen rato.",
      "🛌 Esta peli es tan buena que ni la cama te hará caer en la tentación.",
    ];

    return Stream.periodic( 
      const Duration( milliseconds: 1500 ), (step) {
        return messages[step];
      }, 
    ).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere Por Favor :('),
          const SizedBox(height: 15,),
          const CircularProgressIndicator(),
          const SizedBox(height: 15,),
          StreamBuilder(stream: getLoadingMessages(), builder: (context, snapshot) {
            if( !snapshot.hasData ) return const Text('Cargando...');

            return Text(snapshot.data!);
          },)
        ],
      ),
    );
  }
}