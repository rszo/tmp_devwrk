// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:app/gallery/studies/crane/colors.dart';
import 'package:flutter/material.dart';

const textFieldHeight = 60.0;
const appPaddingLarge = 120.0;
const appPaddingSmall = 24.0;

class HeaderFormField {
  // final int index;
  final IconData iconData;
  final String title;
  // final TextEditingController textController;

  const HeaderFormField({
    // required this.index,
    required this.iconData,
    required this.title,
    // required this.textController,
  });
}

class HeaderForm extends StatelessWidget {
  final List<HeaderFormField> fields;

  const HeaderForm({Key? key, required this.fields}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallDesktop = 1024 > constraints.maxWidth;
        final itemWidth = !isSmallDesktop ? 504.0 : double.infinity;
        return Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            for (final field in fields)
              SizedBox(
                width: itemWidth,
                child: _HeaderTextField(field: field),
              )
          ],
        );
      },
    );
  }
}

class _HeaderTextField extends StatelessWidget {
  final HeaderFormField field;

  const _HeaderTextField({required this.field});

  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: field.textController,
      cursorColor: Theme.of(context).colorScheme.secondary,
      style:
          Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white),
      onTap: () {},
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        //   contentPadding: const EdgeInsets.all(16),
        //   fillColor: cranePurple700,
        //   filled: true,
        hintText: field.title,
        //   floatingLabelBehavior: FloatingLabelBehavior.never,
        prefixIcon: Icon(
          field.iconData,
          size: 24,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
