import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_detail_model/customer_reviews_model.dart';
import 'package:restaurant_app/style/typography/typografy_style.dart';

class CustomerReviewCard extends StatelessWidget {
  final CustomerReviewsModel itemReview;
  const CustomerReviewCard({
    super.key,
    required this.itemReview,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: TypografyStyle.mainColor,
                  child: Text(
                    itemReview.name![0],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemReview.name!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        itemReview.review!,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 12,
                            ),
                        maxLines: 2,
                      ),
                      constrains.maxWidth <= 260
                          ? Text(
                              itemReview.date!,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 12,
                                  ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                SizedBox(
                  width: constrains.maxWidth <= 260 ? 0 : 6,
                ),
                constrains.maxWidth <= 260
                    ? const SizedBox()
                    : Text(
                        itemReview.date!,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontSize: 12,
                                ),
                      ),
              ],
            ),
            Divider(
              color: TypografyStyle.greyColor.withOpacity(0.2),
            ),
          ],
        );
      },
    );
  }
}
