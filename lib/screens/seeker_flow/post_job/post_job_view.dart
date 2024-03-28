import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/providers/tasks_repo_provider.dart';
import 'package:haathbarhao_mobile/screens/authentication/screens/widgets/custom_text_field.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../gen/colors.gen.dart';
import '../../../providers/future_providers.dart';
import '../../../widgets/loading_animation.dart';

class PostJobView extends ConsumerStatefulWidget {
  final String? title;
  final String? description;
  final String? image;
  final String? category;

  const PostJobView({
    this.title,
    this.description,
    this.image,
    this.category,
    super.key,
  });

  @override
  ConsumerState createState() => _PostJobViewState();
}

class _PostJobViewState extends ConsumerState<PostJobView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = 'Electrical';
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? date;
  bool isLoading = false;

  List<String> categoryOptions = [
    'Electrical',
    'Plumbing',
    'Mechanical',
    'Cleaning',
    'Cooking',
    'Teaching',
    'Moving',
    'House Help',
    'Woodworking'
  ];

  final List<String> _selectedImages = [];

  uploadPicture() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const LoadingAnimation();
        },
      );

      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 20,
        requestFullMetadata: false,
      );
      if (pickedFile != null) {
        final File file = File(pickedFile.path);

        final user = await ref.read(userProvider.future);

        FirebaseStorage storage = FirebaseStorage.instance;
        String filePath = 'taskImages/${user.id}-${DateTime.now()}.png';

        await storage.ref(filePath).putFile(file);

        String downloadURL = await storage.ref(filePath).getDownloadURL();

        setState(() {
          _selectedImages.add(downloadURL);
        });
      }

      if (mounted) context.pop();
    } catch (e) {
      log(e.toString());

      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: ColorName.white,
        fontSize: 16.0,
      );

      if (mounted) context.pop();
    }
  }

  postJob() async {
    try {
      if (formKey.currentState!.validate() &&
          _selectedCategory.isNotEmpty &&
          date != null) {
        final tasksRepository = ref.read(tasksRepositoryProvider);

        setState(() {
          isLoading = true;
        });

        await tasksRepository.postTask(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          category: _selectedCategory,
          location: _locationController.text.trim(),
          date: date!,
          pictures: _selectedImages,
        );

        ref.invalidate(tasksProvider);

        setState(() {
          isLoading = false;
        });

        if (mounted) context.pop();
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: ColorName.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.title != null) {
      _titleController.text = widget.title!;
    }

    if (widget.description != null) {
      _descriptionController.text = widget.description!;
    }

    if (widget.category != null) {
      _selectedCategory = widget.category!;
    }

    if (widget.image != null) {
      _selectedImages.add(widget.image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        leadingWidth: 20,
        centerTitle: false,
        title: const Text(
          'New Task',
          style: TextStyle(
            fontFamily: FontFamily.clashDisplay,
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: ColorName.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.close,
                color: ColorName.black,
                size: 40,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 27.5,
                  vertical: 16,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        type: 'Title',
                        textEditingController: _titleController,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        type: 'Description',
                        textEditingController: _descriptionController,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          underline: const SizedBox.shrink(),
                          isExpanded: true,
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                          buttonStyleData: ButtonStyleData(
                            elevation: 0,
                            decoration: BoxDecoration(
                              color: const Color(0xFF929292).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.only(
                              right: 12,
                              top: 8,
                              bottom: 8,
                            ),
                          ),
                          hint: Text(
                            'Category',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorName.lightGrey,
                            ),
                          ),
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorName.black,
                          ),
                          items: categoryOptions.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _selectedCategory,
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                _selectedCategory = value;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        type: 'Location',
                        textEditingController: _locationController,
                        onPressed: () async {
                          final newZipcode = await _getZipCodeFromGeolocation();

                          if (newZipcode != null) {
                            _locationController.text = newZipcode;
                          }
                        },
                        suffixIcon: const Icon(
                          Icons.location_on,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        type: 'Date',
                        textEditingController: _dateController,
                        onPressed: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(
                                days: 365,
                              ),
                            ),
                          );

                          if (context.mounted) {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                hour: DateTime.now().hour,
                                minute: DateTime.now().minute,
                              ),
                            );

                            if (pickedDate != null && pickedTime != null) {
                              final result = pickedDate.copyWith(
                                hour: pickedTime.hour,
                                minute: pickedTime.minute,
                              );

                              _dateController.text =
                                  DateFormat('dd-MM-yyyy hh:mm a')
                                      .format(result);
                              date = result;
                            }
                          }
                        },
                        suffixIcon: const Icon(
                          Icons.calendar_today_sharp,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Add Photos',
                          style: TextStyle(
                            fontFamily: FontFamily.clashDisplay,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: ColorName.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 110,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: _selectedImages.length + 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 110,
                                width: 110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: OutlinedButton(
                                  onPressed: index == _selectedImages.length
                                      ? uploadPicture
                                      : () {
                                          setState(() {
                                            _selectedImages.removeAt(index);
                                          });
                                        },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide.none,
                                    minimumSize: const Size(0, 0),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    ),
                                    padding: EdgeInsets.zero,
                                    backgroundColor: const Color(0xFF929292)
                                        .withOpacity(0.1),
                                  ),
                                  child: index == _selectedImages.length
                                      ? const Icon(
                                          Icons.camera_alt,
                                          size: 30,
                                          color: ColorName.black,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: _selectedImages[index],
                                          fit: BoxFit.cover,
                                          height: 110,
                                          width: 110,
                                          progressIndicatorBuilder:
                                              (context, value, progress) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: progress.progress,
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                width: 12,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.5,
              ),
              child: PrimaryButton(
                onPressed: postJob,
                isLoading: isLoading,
                text: 'Post a new job',
                invertColors: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(
        msg: 'Location services are disabled. Please enable the services.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: ColorName.white,
        fontSize: 16.0,
      );

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
          msg: 'Location permissions are denied.',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.redAccent,
          textColor: ColorName.white,
          fontSize: 16.0,
        );

        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
        msg:
            'Location permissions are permanently denied, we cannot request permissions.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: ColorName.white,
        fontSize: 16.0,
      );

      return false;
    }
    return true;
  }

  Future<String?> _getZipCodeFromGeolocation() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
              color: ColorName.primary,
            ),
          );
        },
      );

      final hasPermission = await _handleLocationPermission();
      if (!hasPermission) {
        return null;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      if (place.postalCode == '') {
        Fluttertoast.showToast(
          msg: 'Please enter postal code manually.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }

      if (mounted) context.pop();

      return place.postalCode!;
    } on Exception catch (e) {
      if (mounted) context.pop();

      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.redAccent,
        textColor: ColorName.white,
        fontSize: 16.0,
      );
    }

    return null;
  }
}
