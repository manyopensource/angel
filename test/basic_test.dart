import 'package:angel_validate/angel_validate.dart';
import 'package:test/test.dart';

final Validator emailSchema = new Validator({
  'to': [isNum, isPositive]
}, customErrorMessages: {
  'to': 'Hello, world!'
});

final Validator todoSchema = new Validator({
  'id': [isInt, isPositive],
  'text*': isString,
  'completed*': isBool
}, defaultValues: {
  'completed': false
});

main() {
  test('custom error message', () {
    var result = emailSchema.check({'to': 2});

    expect(result.errors, isList);
    expect(result.errors, hasLength(1));
    expect(result.errors.first, equals('Hello, world!'));
  });

  test('todo', () {
    expect(() {
      todoSchema
          .enforce({'id': 'fool', 'text': 'Hello, world!', 'completed': 4});
    }, throwsA(new isInstanceOf<ValidationException>()));
  });
}
