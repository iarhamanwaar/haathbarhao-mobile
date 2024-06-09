import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haathbarhao_mobile/gen/colors.gen.dart';
import 'package:haathbarhao_mobile/gen/fonts.gen.dart';
import 'package:haathbarhao_mobile/models/user_model.dart';
import 'package:haathbarhao_mobile/screens/authentication/screens/widgets/custom_text_field.dart';
import 'package:haathbarhao_mobile/screens/doer_flow/become_helper/providers/step2_provider.dart';
import 'package:haathbarhao_mobile/utils/category_options.dart';
import 'package:haathbarhao_mobile/widgets/primary_button.dart';

class Step2View extends ConsumerWidget {
  final Function() nextOnPressed;

  const Step2View({
    required this.nextOnPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step2State = ref.watch(step2Provider);
    final step2Notifier = ref.watch(step2Provider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Update',
              style: TextStyle(
                fontFamily: FontFamily.clashDisplay,
                fontWeight: FontWeight.w600,
                fontSize: 32,
                color: ColorName.primaryBlack,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Update your details.',
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w400,
                fontSize: 15,
                color: ColorName.primaryBlack.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Column(
            children: [
              CustomTextField(
                type: 'Role',
                onChanged: step2Notifier.setRole,
                initialValue: step2State.role,
              ),
              const SizedBox(
                height: 12,
              ),
              ...step2State.skills.asMap().entries.map((entry) {
                int index = entry.key;
                Skill skill = entry.value;

                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            type: 'Skill Name',
                            onChanged: (value) {
                              step2Notifier.updateSkillName(index, value);
                            },
                            initialValue: skill.name,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<SkillLevel>(
                              isExpanded: true,
                              value: skill.level,
                              onChanged: (value) {
                                if (value != null) {
                                  step2Notifier.updateSkillLevel(index, value);
                                }
                              },
                              items: SkillLevel.values.map((SkillLevel level) {
                                return DropdownMenuItem<SkillLevel>(
                                  value: level,
                                  child: Text(level.toString().split('.').last),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            step2Notifier.removeSkill(index);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                );
              }),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: step2Notifier.addSkill,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Skill'),
                ),
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
                    'Preferred Category',
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
                  value: step2State.category,
                  onChanged: (String? value) {
                    if (value != null) {
                      step2Notifier.setCategory(value);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomTextField(
                type: 'Location',
                showLoading: step2State.isLocationLoading,
                textEditingController: step2State.location,
                onPressed: () => step2Notifier.pickLocation(),
                suffixIcon: const Icon(
                  Icons.location_on,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              PrimaryButton(
                text: 'Save Changes',
                isLoading: step2State.isLoading,
                enabled: step2State.isButtonEnabled,
                invertColors: true,
                onPressed: () async {
                  await step2Notifier.saveChanges(context);
                  nextOnPressed();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
