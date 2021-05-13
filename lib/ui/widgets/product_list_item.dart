part of 'widgets.dart';

class ProductListItem extends StatelessWidget {
  final Product product;

  ProductListItem({
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //todo go to product details
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 26,
          horizontal: 24,
        ),
        child: Row(
          children: [
            Container(

              height: 50,
              width: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.picture),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width:24),
            Expanded(
              child: Text(
                product.name,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Text(
              NumberFormat.currency(
                symbol: "IDR ",
                decimalDigits: 0,
                locale: "id-ID",
              ).format(product.price),
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: AppColor.textHintColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
