import 'package:analyzer/analyzer.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/src/dart/ast/token.dart';
import 'package:code_builder/src/builders/annotation.dart';
import 'package:code_builder/src/builders/class.dart';
import 'package:code_builder/src/builders/expression.dart';
import 'package:code_builder/src/builders/shared.dart';
import 'package:code_builder/src/builders/statement.dart';
import 'package:code_builder/src/builders/type.dart';
import 'package:code_builder/src/tokens.dart';

/// Short-hand for [FieldBuilder].
FieldBuilder varField(
  String name, {
  TypeBuilder type,
  ExpressionBuilder value,
}) {
  return new FieldBuilder(
    name,
    type: type,
    value: value,
  );
}

/// Short-hand for [FieldBuilder].
FieldBuilder varFinal(
  String name, {
  TypeBuilder type,
  ExpressionBuilder value,
}) {
  return new FieldBuilder.asFinal(
    name,
    type: type,
    value: value,
  );
}

/// Short-hand for [FieldBuilder].
FieldBuilder varConst(
  String name, {
  TypeBuilder type,
  ExpressionBuilder value,
}) {
  return new FieldBuilder.asConst(
    name,
    type: type,
    value: value,
  );
}

/// Lazily builds an field AST when builder is invoked.
abstract class FieldBuilder
    implements AstBuilder, HasAnnotations, StatementBuilder, ValidClassMember {
  /// Creates a new [FieldBuilder] defining a new `var`.
  factory FieldBuilder(
    String name, {
    TypeBuilder type,
    ExpressionBuilder value,
  }) =>
      new _FieldBuilderImpl(
        name,
        keyword: type == null ? Keyword.VAR : null,
        type: type,
        value: value,
      );

  /// Creates a new [FieldBuilder] defining a new `const`.
  factory FieldBuilder.asConst(
    String name, {
    TypeBuilder type,
    ExpressionBuilder value,
  }) =>
      new _FieldBuilderImpl(
        name,
        keyword: Keyword.CONST,
        type: type,
        value: value,
      );

  /// Creates a new [FieldBuilder] defining a new `final`.
  factory FieldBuilder.asFinal(
    String name, {
    TypeBuilder type,
    ExpressionBuilder value,
  }) =>
      new _FieldBuilderImpl(
        name,
        keyword: Keyword.FINAL,
        type: type,
        value: value,
      );

  /// Returns as a [FieldDeclaration] AST.
  FieldDeclaration buildField(bool static, [Scope scope]);

  /// Returns as a [TopLevelVariableDeclaration] AST.
  TopLevelVariableDeclaration buildTopLevel([Scope scope]);
}

class _FieldBuilderImpl extends Object
    with HasAnnotationsMixin
    implements FieldBuilder {
  final Keyword _keyword;
  final String _name;
  final TypeBuilder _type;
  final ExpressionBuilder _value;

  _FieldBuilderImpl(
    String name, {
    Keyword keyword,
    TypeBuilder type,
    ExpressionBuilder value,
  })
      : _keyword = keyword,
        _name = name,
        _type = type,
        _value = value;

  @override
  AstNode buildAst([Scope scope]) => buildStatement(scope);

  @override
  FieldDeclaration buildField(bool static, [Scope scope]) {
    return new FieldDeclaration(
      null,
      buildAnnotations(scope),
      static ? $static : null,
      _buildVariableList(scope),
      $semicolon,
    );
  }

  @override
  Statement buildStatement([Scope scope]) {
    return new VariableDeclarationStatement(
      _buildVariableList(scope),
      $semicolon,
    );
  }

  @override
  TopLevelVariableDeclaration buildTopLevel([Scope scope]) {
    return new TopLevelVariableDeclaration(
      null,
      null,
      _buildVariableList(scope),
      $semicolon,
    );
  }

  VariableDeclarationList _buildVariableList([Scope scope]) {
    return new VariableDeclarationList(
      null,
      null,
      _keyword != null ? new KeywordToken(_keyword, 0) : null,
      _type?.buildType(scope),
      [
        new VariableDeclaration(
          stringIdentifier(_name),
          _value != null ? $equals : null,
          _value?.buildExpression(scope),
        )
      ],
    );
  }
}
