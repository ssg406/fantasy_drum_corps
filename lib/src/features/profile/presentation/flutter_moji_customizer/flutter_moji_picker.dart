import 'package:fantasy_drum_corps/src/common_widgets/primary_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/titled_section_card.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/flutter_moji_customizer/flutter_moji_picker_controller.dart';
import 'package:fantasy_drum_corps/src/utils/app_color_schemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class FlutterMojiPicker extends ConsumerWidget {
  const FlutterMojiPicker({Key? key, this.playerId}) : super(key: key);
  final String? playerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Get.put(FluttermojiController());
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: pagePadding,
        child: TitledSectionCard(
            title: 'Create Your Avatar',
            child: Center(
              child: Column(
                children: [
                  FluttermojiCircleAvatar(),
                  gapH64,
                  FluttermojiCustomizer(
                    scaffoldHeight: MediaQuery.of(context).size.height * 0.8,
                    scaffoldWidth: MediaQuery.of(context).size.width * 0.7,
                    theme: FluttermojiThemeData(
                      primaryBgColor: theme.colorScheme.primary,
                      secondaryBgColor: theme.colorScheme.secondary,
                      iconColor: theme.colorScheme.onSecondary,
                      selectedIconColor: theme.colorScheme.primaryContainer,
                      unselectedIconColor: theme.colorScheme.onSecondary,
                      selectedTileDecoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.customBlue.withOpacity(0.3),
                            width: 3.0),
                      ),
                    ),
                  ),
                  gapH16,
                  FluttermojiSaveWidget(
                    child: PrimaryButton(
                      isLoading: false,
                      label: 'SAVE AVATAR',
                      onPressed: () {
                        FluttermojiFunctions()
                            .encodeMySVGtoString()
                            .then((svgString) {
                          ref
                              .read(
                                  flutterMojiPickerControllerProvider.notifier)
                              .setPlayerAvatarString(svgString)
                              .then((_) => context.pop);
                        });
                      },
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
