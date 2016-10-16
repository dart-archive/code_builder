// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:code_builder/code_builder.dart';
import 'package:code_builder/dart/core.dart';
import 'package:code_builder/testing.dart';
import 'package:test/test.dart';

void main() {
  group('literal', () {
    test('should emit a null', () {
      expect(literal(null), equalsSource(r'null'));
    });

    test('should emit true', () {
      expect(literal(true), equalsSource(r'true'));
    });

    test('should emit false', () {
      expect(literal(false), equalsSource(r'false'));
    });

    test('should emit an int', () {
      expect(literal(5), equalsSource(r'5'));
    });

    test('should emit a double', () {
      expect(literal(5.5), equalsSource(r'5.5'));
    });

    test('should emit a string', () {
      expect(literal('Hello'), equalsSource(r"'Hello'"));
    });

    test('should emit a list', () {
      expect(literal([1, 2, 3]), equalsSource(r'[1, 2, 3]'));
    });

    test('should emit a map', () {
      expect(literal({1: 2, 2: 3}), equalsSource(r'{1 : 2, 2 : 3}'));
    });
  });

  test('should emit an assert statemnet', () {
    expect(
      literal(true).asAssert(),
      equalsSource(r'''
        assert(true);
      '''),
    );
  });

  test('should emit an assign expression', () {
    expect(
      literal(true).asAssign('flag'),
      equalsSource(r'''
        flag = true
      '''),
    );
  });

  test('should emit a const variable assignment statement', () {
    expect(
      literal(true).asConst('flag'),
      equalsSource(r'''
        const flag = true;
      '''),
    );
  });

  test('should emit a final variable assignment statement', () {
    expect(
      literal(true).asFinal('flag'),
      equalsSource(r'''
        final flag = true;
      '''),
    );
  });

  test('should emit a simple var assignment statement', () {
    expect(
      literal(true).asVar('flag'),
      equalsSource(r'''
        var flag = true;
      '''),
    );
  });

  test('should emit a typed assignemnt statement', () {
    expect(
      literal(true).asVar('flag', core.bool),
      equalsSource(r'''
        bool flag = true;
      '''),
    );
  });

  test('should emit a return statement', () {
    expect(
      literal(true).asReturn(),
      equalsSource(r'''
        return true;
      '''),
    );
  });

  test('should emit an expression as a statement', () {
    expect(
      literal(true).asStatement(),
      equalsSource(r'''
        true;
      '''),
    );
  });

  test('should call an expression as a function', () {
    expect(
      core.identical.call([literal(true), literal(true)]),
      equalsSource(r'''
        identical(true, true)
      '''),
    );
  });

  test('should call an expression with named arguments', () {
    expect(
      reference('doThing').call(
        [literal(true)],
        {
          'otherFlag': literal(false),
        },
      ),
      equalsSource(r'''
        doThing(true, otherFlag: false)
      '''),
    );
  });

  test('should call a method on an expression', () {
    expect(
      explicitThis.invoke('doThing', [literal(true)]),
      equalsSource(r'''
        this.doThing(true)
      '''),
    );
  });

  test('should emit an identical() expression', () {
    expect(
      literal(true).identical(literal(false)),
      equalsSource(r'''
        identical(true, false)
      '''),
    );
  });

  test('should emit an equality (==) expression', () {
    expect(
      literal(true).equals(literal(false)),
      equalsSource(r'''
        true == false
      '''),
    );
  });

  test('should emit a not equals (!=) expression', () {
    expect(
      literal(true).notEquals(literal(false)),
      equalsSource(r'''
        true != false
      '''),
    );
  });

  test('should emit a negated expression', () {
    expect(
      reference('foo').negate(),
      equalsSource(r'''
        !(foo)
      '''),
    );
  });

  test('should add two expressions', () {
    expect(
      literal(1) + literal(2),
      equalsSource(r'''
        1 + 2
      '''),
    );
  });

  test('should subtract two expressions', () {
    expect(
      literal(2) - literal(1),
      equalsSource(r'''
        2 - 1
      '''),
    );
  });

  test('should multiply two expressions', () {
    expect(
      literal(2) * literal(3),
      equalsSource(r'''
        2 * 3
      '''),
    );
  });

  test('should divide two expressions', () {
    expect(
      literal(3) / literal(2),
      equalsSource(r'''
        3 / 2
      '''),
    );
  });

  test('should wrap an expressions in ()', () {
    expect(
      literal(true).parentheses(),
      equalsSource(r'''
        (true)
      '''),
    );
  });
}
