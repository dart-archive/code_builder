import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  test('emit a var', () {
    expect(
      varField('a', type: core.String, value: literal('Hello')),
      equalsSource(r'''
        String a = 'Hello';
      '''),
    );
  });

  test('emit a final', () {
    expect(
      varFinal('a', type: core.String, value: literal('Hello')),
      equalsSource(r'''
        final String a = 'Hello';
      '''),
    );
  });

  test('emit a const', () {
    expect(
      varConst('a', type: core.String, value: literal('Hello')),
      equalsSource(r'''
        const String a = 'Hello';
      '''),
    );
  });
}
