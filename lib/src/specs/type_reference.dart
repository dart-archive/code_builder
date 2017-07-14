// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library code_builder.src.specs.type_reference;

import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:meta/meta.dart';

import '../base.dart';
import '../mixins/generics.dart';
import '../visitors.dart';
import 'reference.dart';

part 'type_reference.g.dart';

@immutable
abstract class TypeReference extends Object
    with HasGenerics
    implements Built<TypeReference, TypeReferenceBuilder>, Reference, Spec {
  factory TypeReference([
    void updates(TypeReferenceBuilder b),
  ]) = _$TypeReference;

  TypeReference._();

  @override
  String get symbol;

  @override
  @nullable
  String get url;

  /// Optional bound generic.
  @nullable
  Reference get bound;

  @override
  BuiltList<Reference> get types;

  @override
  R accept<R>(SpecVisitor<R> visitor) => visitor.visitType(this);

  @override
  TypeReference toType() => this;
}

abstract class TypeReferenceBuilder extends Object
    with HasGenericsBuilder
    implements Builder<TypeReference, TypeReferenceBuilder> {
  factory TypeReferenceBuilder() = _$TypeReferenceBuilder;

  TypeReferenceBuilder._();

  String symbol;

  String url;

  /// Optional bound generic.
  Reference bound;

  @override
  ListBuilder<Reference> types = new ListBuilder<Reference>();
}
