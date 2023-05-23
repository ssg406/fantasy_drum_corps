import 'package:fantasy_drum_corps/src/common_widgets/action_button.dart';
import 'package:fantasy_drum_corps/src/common_widgets/page_scaffold.dart';
import 'package:fantasy_drum_corps/src/constants/app_sizes.dart';
import 'package:fantasy_drum_corps/src/features/profile/presentation/flutter_moji_customizer/flutter_moji_picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

class FlutterMojiPicker extends ConsumerWidget {
  const FlutterMojiPicker({Key? key, this.playerId}) : super(key: key);
  final String? playerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Get.put(FluttermojiController());
    final theme = Theme.of(context);
    return PageScaffolding(
      pageTitle: 'Create your Avatar',
      child: Column(
        children: [
          Flex(
            direction:
                ResponsiveBreakpoints.of(context).largerOrEqualTo(DESKTOP)
                    ? Axis.horizontal
                    : Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FluttermojiCircleAvatar(
                radius: 100,
                backgroundColor: theme.colorScheme.primary,
              ),
              gapW32,
              FluttermojiCustomizer(
                scaffoldHeight: 400,
                scaffoldWidth:
                    ResponsiveBreakpoints.of(context).screenWidth * 0.4,
                theme: FluttermojiThemeData(
                    labelTextStyle: theme.textTheme.titleLarge!
                        .copyWith(color: Colors.black87, fontSize: 32.0)),
              ),
            ],
          ),
          gapH24,
          FluttermojiSaveWidget(
            child: ActionButton(
              isLoading: false,
              label: 'SAVE AVATAR',
              onPressed: () {
                FluttermojiFunctions().encodeMySVGtoString().then((svgString) {
                  ref
                      .read(flutterMojiPickerControllerProvider.notifier)
                      .setPlayerAvatarString(svgString);
                  context.pop();
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
