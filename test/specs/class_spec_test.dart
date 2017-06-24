// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:test/test.dart';

void main() {
  test('should build a class', () {
    expect(
      specToDart(
        classBuilder('Foo').build(),
      ),
      equalsIgnoringWhitespace(r'''
        class Foo {}
      '''),
    );
  });

  test('should build an abstract class', () {
    expect(
      specToDart(
        classBuilder('Foo', isAbstract: true).build(),
      ),
      equalsIgnoringWhitespace(r'''
        abstract class Foo {}
      '''),
    );
  });

  test('should build a class with dartdoc', () {
    expect(
      specToDart(
        (classBuilder('Foo')..addDartDoc('/// My favorite class.')).build(),
      ),
      equalsIgnoringWhitespace(r'''
        /// My favorite class.
        class Foo {}
      '''),
    );
  });
}
