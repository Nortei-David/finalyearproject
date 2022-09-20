import 'package:finalyearproject/model/drug.dart';
import 'package:flutter/material.dart';

// class DrugCard extends StatelessWidget {
//   final Drug drug;

//   const DrugCard({Key? key, required this.drug}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String defaultImage = "assets/image/bg.jpg";

//     return Expanded(
//       child: GridView.builder(
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.8
//         ),
//         itemBuilder: (context, index) => ItemCard(
//           drug: drug,
//         ),
//         itemCount: 2,
//       ),
//     );
//     // ItemCard(drug: drug, defaultImage: defaultImage, press: (){},);
//     // )

//     // ),
//   }
// }

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.drug,
  }) : super(key: key);

  final Drug drug;

  final String defaultImage = "assets/images/bg.jpg";

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 180.0,
            width: 160,
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: Colors.blueGrey[200],
                borderRadius: BorderRadius.circular(16)),
            child: Image.network(
              drug.url != null ? drug.url! : defaultImage,
              fit: BoxFit.fill,
              errorBuilder: (context, object, stackTrace) {
                return const Text("Something went wrong.\nImage Failed to load");
              },
              // loadingBuilder: (context, object, imageChunkEvent) {
              //   return const Center(child: CircularProgressIndicator(),);
              // },
              loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }
              // width: 80,
              // height: 100,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
            child: Text(
              drug.name,
              style: TextStyle(color: Colors.blueGrey[600]),
            ),
          ),
          Text('GHC' + drug.price.toString())
        ]
        // const SizedBox(
        //   width: 10.0,
        // ),
        // Flexible(
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     mainAxisSize: MainAxisSize.max,
        //     children: [
        //       Text(drug.name),
        //       const SizedBox(height: 5),
        // Text(
        //   drug.description!,
        //   overflow: TextOverflow.ellipsis,
        //   maxLines: 3,
        // // ),
        // const SizedBox(height: 5),
        // Text(drug.price.toString())
        // ],
        );
  }
}
