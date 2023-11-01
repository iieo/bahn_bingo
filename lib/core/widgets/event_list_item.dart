import 'package:boilerplate/utils/locale/app_localization.dart';
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
                          Text("14:33 - 14:50",
                              style: Theme.of(context).textTheme.labelLarge),
                          Text(" | 2h 30min | 15 transfers",
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
                            width: MediaQuery.of(context).size.width / 2 - 50,
                            height: 22.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
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
                            width: MediaQuery.of(context).size.width / 2 - 50,
                            height: 22.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF6F7968),
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
              child: Observer(
                builder: (context) => Row(
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
            )
          ],
        ));
  }
}
