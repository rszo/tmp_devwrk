import 'package:app/gallery/studies/crane/header_form.dart';
import 'package:app/infinite_list/catalog.dart';
import 'package:app/infinite_list/item_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  static const routeName = '/home';

  static const _sleepLayerTopOffset = 60.0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = 1024 <= width;
    final isSmallDesktop = 1024 <= width && width > 1440;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: ChangeNotifierProvider<Catalog>(
        create: (context) => Catalog(),
        child: Padding(
          // padding: EdgeInsets.symmetric(
          //   vertical: 12.0,
          //   horizontal:
          //       isDesktop && !isSmallDesktop ? appPaddingLarge : appPaddingSmall,
          // ),
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              HeaderForm(
                fields: [
                  HeaderFormField(
                    iconData: Icons.person,
                    title: AppLocalizations.of(context)!.craneFormTravelers,
                  ),
                  HeaderFormField(
                    iconData: Icons.date_range,
                    title: AppLocalizations.of(context)!.craneFormDates,
                  ),
                  HeaderFormField(
                    iconData: Icons.hotel,
                    title: AppLocalizations.of(context)!.craneFormLocation,
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                // TODO: https://github.com/flutter/samples/blob/master/infinite_list/lib/main.dart
                child: Selector<Catalog, int?>(
                  selector: (context, catalog) => catalog.itemCount,
                  builder: (context, itemCount, child) => ListView.builder(
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      var catalog = Provider.of<Catalog>(context);
                      var item = catalog.getByIndex(index);
                      if (item.isLoading) {
                        return const LoadingItemTile();
                      }

                      return ItemTile(item: item);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
