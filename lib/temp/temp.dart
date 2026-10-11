// class MenPage extends StatelessWidget {
//   const MenPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.grey,
//       body: Stack(
//         children: [
//           // الخلفية
//           Container(color: AppColors.grey),

//           // 🔥 Bottom Sheet
//           DraggableScrollableSheet(
//             initialChildSize: 0.4, // يبدأ من 40% من الشاشة
//             minChildSize: 0.3,     // أقل سحب
//             maxChildSize: 0.9,     // أقصى سحب
//             builder: (context, scrollController) {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(30),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       blurRadius: 10,
//                       color: Colors.black12,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     // 👇 handle (الشريط الصغير)
//                     Container(
//                       margin: EdgeInsets.symmetric(vertical: 10),
//                       height: 5,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[400],
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),

//                     // 👇 المحتوى (قابل للسكرول)
//                     Expanded(
//                       child: ListView.builder(
//                         controller: scrollController,
//                         itemCount: 20,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             title: Text("Item $index"),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
