import 'package:reflectable/reflectable.dart';

class Reflector extends Reflectable {
  const Reflector() : super(invokingCapability, typeRelationsCapability);
}

const reflector = Reflector();

@reflector
class ScriptGenerator {
  final String diyIdScript;
  final String name;
  final String websiteUrl;

  ScriptGenerator({required this.diyIdScript, required this.name, required this.websiteUrl});

  generateCode() {
    final fields = reflector.reflectType(ScriptGenerator).typeArguments.whereType<VariableMirror>();
    return fields.map((field) {
      final name = field.simpleName;
      final value = field.reflectedType;
      return "$name: $value";
    }).join(', ');
  }
}
