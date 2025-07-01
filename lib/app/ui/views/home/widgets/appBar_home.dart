import 'package:flutter/material.dart';
import 'package:semco_app_asistio/core/helpers/constant.dart';
import 'package:semco_app_asistio/core/theme/app_colors.dart';


class AppBarHome extends StatelessWidget {
  const AppBarHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: EdgeInsets.only(top: kSizeBigLarge, /* left: kMarginApp.w */),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: kSizeNormalLarge,
                  width: kSizeNormalLarge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.backgroundColor(context),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grayBlue.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    /* onPressed: () {
                      controller.navigateToScreen();
                    }, */
                    icon: Icon(
                      Icons.menu,
                      color: AppColors.primary(context),
                    ),
                  ),
                ),
               /*  Container(
                  height: kSizeNormalLarge.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: kPaddingAppLargeApp.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kRadiusMedium.h),
                    color: AppColors.backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grayBlue.withOpacity(0.1),
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        //textScaler: const TextScaler.linear(1.0),
                        'SemcoCad',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 17,
                            fontWeight: FontWeight.w900),
                            /* AppTextStyle(context)
                                .extra22(color: AppColors.primary) */
                      ),
                      SizedBox(width: kSizeBigLittle.w),

                      
                    ],
                  ),
                ), */
              ],
            ),
          ],
        ),
    );
  }
}
