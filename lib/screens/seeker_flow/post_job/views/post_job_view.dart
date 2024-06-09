import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/screens/authentication/screens/widgets/custom_text_field.dart';
import 'package:haathbarhao_mobile/utils/category_options.dart';
import 'package:haathbarhao_mobile/widgets/loading_animation.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:haathbarhao_mobile/screens/seeker_flow/post_job/providers/post_job_provider.dart';

class PostJobView extends ConsumerWidget {
  const PostJobView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox.shrink(),
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
        body: Consumer(
          builder: (context, ref, child) {
            final state = ref.watch(postJobProvider);
            final notifier = ref.watch(postJobProvider.notifier);

            if (state.isLoading) const LoadingAnimation();

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 27.5,
                vertical: 16,
              ),
              child: SafeArea(
                child: Form(
                  child: Column(
                    children: [
                      CustomTextField(
                        type: 'Title',
                        onChanged: notifier.setTitle,
                        initialValue: state.title,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        type: 'Description',
                        maxLines: 5,
                        onChanged: notifier.setDescription,
                        initialValue: state.description,
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
                          value: state.selectedCategory,
                          onChanged: (String? value) {
                            if (value != null) {
                              notifier.setCategory(value);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        type: 'Location',
                        showLoading: state.isLocationLoading,
                        onPressed: () => notifier.pickLocation(),
                        textEditingController: state.location,
                        suffixIcon: const Icon(
                          Icons.location_on,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        type: 'Date',
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

                              notifier.setDate(DateFormat('yyyy-MM-ddTHH:mm:ss')
                                  .format(result));
                            }
                          }
                        },
                        textEditingController: state.date,
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
                            itemCount: state.selectedImages.length + 1,
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
                                  onPressed:
                                      index == state.selectedImages.length
                                          ? () => notifier.pickImage()
                                          : () {
                                              notifier.removeImage(index);
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
                                  child: index == state.selectedImages.length
                                      ? const Icon(
                                          Icons.camera_alt,
                                          size: 30,
                                          color: ColorName.black,
                                        )
                                      : Image.file(
                                          state.selectedImages[index],
                                          fit: BoxFit.cover,
                                          height: 110,
                                          width: 110,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        child: PrimaryButton(
                          onPressed: () => notifier.postJob(context),
                          isLoading: state.isLoading,
                          text: 'Post a new job',
                          invertColors: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
