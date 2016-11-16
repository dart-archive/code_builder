// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/analyzer.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/expression.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/builders/type.dart';
import 'package:code_builder/src/tokens.dart';

/// An explicit reference to `this`.
final ReferenceBuilder explicitThis = reference('this');

/// Creates a reference called [name].
ReferenceBuilder reference(String name, [String importUri]) {
  return new ReferenceBuilder._(name, importUri);
}

/// An abstract way of representing other types of [AstBuilder].
class ReferenceBuilder extends Object
    with AbstractExpressionMixin, AbstractTypeBuilderMixin, TopLevelMixin
    implements AnnotationBuilder, ExpressionBuilder, TypeBuilder {
  final String _importFrom;
  final String _name;

  ReferenceBuilder._(this._name, [this._importFrom]);

  @override
  Annotation buildAnnotation([Scope scope]) {
    return new Annotation(
      $at,
      stringIdentifier(_name),
      null,
      null,
      null,
    );
  }

  @override
  AstNode buildAst([Scope scope]) => throw new UnimplementedError();

  @override
  Expression buildExpression([Scope scope]) {
    return identifier(
      scope,
      _name,
      _importFrom,
    );
  }

  @override
  TypeName buildType([Scope scope]) {
    return new TypeBuilder(_name, _importFrom).buildType(scope);
  }
}
