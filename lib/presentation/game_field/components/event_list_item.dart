import 'dart:math' as Math;

import 'package:bahn_bingo/constants/colors.dart';
import 'package:bahn_bingo/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EventListItem extends StatelessWidget {
  final int index;
  final bool done;
  final String task;
  final Function()? onPressed;
  final bool isGameFinished;
  const EventListItem(
      {super.key,
      required this.index,
      required this.done,
      required this.task,
      required this.isGameFinished,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    final random = Math.Random(task.hashCode);
    double randomDouble = random.nextDouble();
    double fullWidth = MediaQuery.of(context).size.width - 20 * 2;
    double minBoxWidth = fullWidth / 5;
    double randomBoxWidth = fullWidth - minBoxWidth * 2;
    double widthBox1 = minBoxWidth + randomBoxWidth * randomDouble;
    double widthBox2 = minBoxWidth + randomBoxWidth * (1 - randomDouble);
    int randomColor1 = random.nextInt(AppColors.boxColors.length);
    int randomColor2 = random.nextInt(AppColors.boxColors.length);

    //get random time
    TimeOfDay randomTimeOfDay =
        TimeOfDay(hour: random.nextInt(24), minute: random.nextInt(60));
    //get random duration
    Duration randomDuration =
        Duration(hours: random.nextInt(8) + 1, minutes: random.nextInt(60));
    //get random time + duration
    TimeOfDay randomTimeOfDay2 = TimeOfDay(
        hour: randomTimeOfDay.hour + randomDuration.inHours,
        minute: randomTimeOfDay.minute + randomDuration.inMinutes % 60);
    //format duration
    String duration =
        "${randomDuration.inHours}h ${randomDuration.inMinutes % 60}min";
    //get random transfer count
    int randomTransferCount = random.nextInt(10) + 2;

    return Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                              "${randomTimeOfDay.format(context)} - ${randomTimeOfDay2.format(context)}",
                              style: Theme.of(context).textTheme.labelLarge),
                          Text(
                              " | $duration | ${randomTransferCount.toString()} transfers",
                              style: Theme.of(context).textTheme.labelSmall)
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 8.0),
                            width: widthBox1,
                            height: 22.0,
                            decoration: BoxDecoration(
                              color: AppColors.boxColors[randomColor1],
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: Text(
                              AppLocalizations.of(context)
                                      .translate("card_no") +
                                  " $index",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(right: 8.0),
                            width: widthBox2,
                            height: 22.0,
                            decoration: BoxDecoration(
                              color: AppColors.boxColors[randomColor2],
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                            child: Text(
                              "ICE 420",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.apply(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(task),
                    ])),
            Container(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                    value: done,
                    onChanged: null,
                  ),
                  isGameFinished
                      ? SizedBox.shrink()
                      : TextButton(
                          onPressed: onPressed,
                          child: Text(
                            done
                                ? AppLocalizations.of(context)
                                    .translate("mark_uncomplete")
                                : AppLocalizations.of(context)
                                    .translate("mark_complete"),
                            style: Theme.of(context).textTheme.labelLarge,
                          ))
                ],
              ),
            ),
          ],
        ));
  }
}
