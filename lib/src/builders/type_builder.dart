// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of code_builder;

/// Build a [TypeName] AST.
class TypeBuilder implements CodeBuilder<TypeName> {
  final String _identifier;
  final String _importFrom;

  /// Create a builder for emitting a [TypeName] AST.
  ///
  /// Optionally specify what must be imported for this type to resolve.
  ///
  /// __Example use__:
  ///     const TypeBuilder('String', importFrom: 'dart:core')
  const TypeBuilder(this._identifier, {String importFrom})
      : _importFrom = importFrom;

  @override
  TypeName toAst([Scope scope = const Scope.identity()]) {
    return new TypeName(scope.getIdentifier(_identifier, _importFrom), null);
  }
}
