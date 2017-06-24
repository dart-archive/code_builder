// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/dartdoc.dart';
import '../utils/assert.dart';
import '../visitor.dart';

/// A generated class definition.
@immutable
class ClassSpec extends Spec with DartDocMixin {
  final bool isAbstract;
  @override
  final String dartDoc;
  final String name;

  ClassSpec._({
    @required this.isAbstract,
    @required this.dartDoc,
    @required this.name,
  });

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitClass(this);
}

ClassSpecBuilder classBuilder(String name, {bool isAbstract: false}) =>
    new ClassSpecBuilder._(
      notNull(name, 'name'),
      isAbstract,
    );

@immutable
class ClassSpecBuilder extends SpecBuilder<ClassSpec> with DartDocBuilderMixin {
  final bool _abstract;
  final String _name;

  ClassSpecBuilder._(this._name, this._abstract);

  @override
  ClassSpec build() => new ClassSpec._(
        name: _name,
        dartDoc: dartDoc.toString(),
        isAbstract: _abstract,
      );
}
