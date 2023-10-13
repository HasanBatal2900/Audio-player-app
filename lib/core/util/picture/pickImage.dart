  // void takeImageCamera() async {
  //   final ImagePicker picker = ImagePicker();
  //   var image = await picker.pickImage(source: ImageSource.camera);

  //   setState(() {
  //     log(image!.path);
  //     selectedImage = File(image!.path);
  //   });
  // }

  // void takeImageGallery() async {
  //   final ImagePicker picker = ImagePicker();
  //   var image = await picker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     selectedImage = File(image!.path);
  //   });
  // }




// showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return Positioned(
//                 top: 200, // Set the desired top position
//                 left: 20, // Set the desired left position
//                 child: Dialog(
//                   alignment: Alignment.center,
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: Container(
//                       height: 300,
//                       width: 300,
//                       alignment: Alignment.center,
//                       child: Column(
//                         children: [
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           const Text("Pick Image For Cover"),
//                           const SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             alignment: Alignment.center,
//                             height: 150,
//                             width: 150,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12.0),
//                                 border: Border.all(
//                                   color: Colors.black,
//                                 )),
//                             child: selectedImage == null
//                                 ? const Text("No selected image")
//                                 : Image.file(selectedImage!),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             children: [
//                               TextButton.icon(
//                                 label: Text("From Gallery"),
//                                 onPressed: takeImageGallery,
//                                 icon: Icon(FontAwesomeIcons.images),
//                               ),
//                               TextButton.icon(
//                                 label: Text("From Camera"),
//                                 onPressed: takeImageCamera,
//                                 icon: Icon(FontAwesomeIcons.camera),
//                               ),
//                             ],
//                           ),
//                         ],
//                       )),
//                 ),
//               );
//             },
//           );