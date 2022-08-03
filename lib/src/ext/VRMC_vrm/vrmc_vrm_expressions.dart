/*
 * # Copyright (c) 2016-2019 The Khronos Group Inc.
 * #
 * # Licensed under the Apache License, Version 2.0 (the "License");
 * # you may not use this file except in compliance with the License.
 * # You may obtain a copy of the License at
 * #
 * #     http://www.apache.org/licenses/LICENSE-2.0
 * #
 * # Unless required by applicable law or agreed to in writing, software
 * # distributed under the License is distributed on an "AS IS" BASIS,
 * # WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * # See the License for the specific language governing permissions and
 * # limitations under the License.
 */

library gltf.extensions.vrmc_vrm_expressions;

import 'package:gltf/src/base/gltf_property.dart';
import 'package:gltf/src/ext/KHR_materials_unlit/khr_materials_unlit.dart';

// morphTargetBind
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/schema/VRMC_vrm.expressions.expression.morphTargetBind.schema.json

const NODE = 'node';
const INDEX = 'index';
const WEIGHT = 'weight';

const List<String> VRMC_VRM_EXPRESSIONS_MORPH_TARGET_BIND = <String>[
  NODE,
  INDEX,
  WEIGHT,
];

class VrmcVrmExpressionsMorphTargetBind extends GltfProperty {
  final int nodeIndex;
  final int index;
  final double weight;

  Node node;

  VrmcVrmExpressionsMorphTargetBind._(this.nodeIndex, this.index, this.weight,
      Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcVrmExpressionsMorphTargetBind fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_EXPRESSIONS_MORPH_TARGET_BIND, context);
    }

    return VrmcVrmExpressionsMorphTargetBind._(
        getIndex(map, NODE, context, req: true),
        getIndex(map, INDEX, context, req: true),
        getFloat(map, WEIGHT, context, req: true),
        getExtensions(map, VrmcVrmExpressionsMorphTargetBind, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    node = gltf.nodes[nodeIndex];

    if (context.validate) {
      // check node
      if (nodeIndex != -1) {
        if (node == null) {
          context.addIssue(LinkError.unresolvedReference,
              name: NODE, args: [nodeIndex]);
        } else {
          node.markAsUsed();
        }
      }

      // check weight index
      if (node != null) {
        final targetsCount = node?.mesh?.primitives?.first?.targets?.length;

        if (targetsCount == null || targetsCount <= index) {
          context.addIssue(LinkError.vrmcVrmExpressionsNoTargetMorph,
              name: INDEX, args: [nodeIndex, index]);
        }
      }
    }
  }
}

// materialColorBind
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/schema/VRMC_vrm.expressions.expression.materialColorBind.schema.json

const MATERIAL = 'material';
const TYPE = 'type';
const TARGET_VALUE = 'targetValue';

const List<String> VRMC_VRM_EXPRESSIONS_MATERIAL_COLOR_BIND = <String>[
  MATERIAL,
  TYPE,
  TARGET_VALUE,
];

const COLOR = 'color';
const EMISSION_COLOR = 'emissionColor';
const SHADE_COLOR = 'shadeColor';
const RIM_COLOR = 'rimColor';
const OUTLINE_COLOR = 'outlineColor';

const List<String> VRMC_VRM_EXPRESSIONS_MATERIAL_COLOR_BIND_TYPES = <String>[
  COLOR,
  EMISSION_COLOR,
  SHADE_COLOR,
  RIM_COLOR,
  OUTLINE_COLOR,
];

const VRMC_MATERIALS_MTOON = 'VRMC_materials_mtoon';

class VrmcVrmExpressionsMaterialColorBind extends GltfProperty {
  final int materialIndex;
  final String type;
  final List<double> targetValue;

  Material material;

  VrmcVrmExpressionsMaterialColorBind._(this.materialIndex, this.type,
      this.targetValue, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcVrmExpressionsMaterialColorBind fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_EXPRESSIONS_MORPH_TARGET_BIND, context);
    }

    return VrmcVrmExpressionsMaterialColorBind._(
        getIndex(map, MATERIAL, context, req: true),
        getString(map, TYPE, context,
            list: VRMC_VRM_EXPRESSIONS_MATERIAL_COLOR_BIND_TYPES, req: true),
        getFloatList(map, TARGET_VALUE, context,
            req: true, lengthsList: const [4]),
        getExtensions(map, VrmcVrmExpressionsMaterialColorBind, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    material = gltf.materials[materialIndex];

    if (context.validate) {
      // check material
      if (materialIndex != -1) {
        if (material == null) {
          context.addIssue(LinkError.unresolvedReference,
              name: MATERIAL, args: [materialIndex]);
        } else {
          material.markAsUsed();
        }
      }

      // check type
      if (material != null && type != null) {
        if (material.extensions.containsKey(VRMC_MATERIALS_MTOON)) {
          // MToon should support all types
        } else if (material.extensions.containsKey(KHR_MATERIALS_UNLIT)) {
          // KHR_materials_unlit only supports `color`
          if (!(const [COLOR].contains(type))) {
            context.addIssue(
                LinkError.vrmcVrmExpressionsIncompatibleMaterialBindType,
                name: TYPE,
                args: [materialIndex, type]);
          }
        } else {
          // It's probably PBR material
          // PBR materials supports `color` and `emissionColor`
          if (!(const [COLOR, EMISSION_COLOR].contains(type))) {
            context.addIssue(
                LinkError.vrmcVrmExpressionsIncompatibleMaterialBindType,
                name: TYPE,
                args: [materialIndex, type]);
          }
        }
      }
    }
  }
}

// textureTransformBind
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/schema/VRMC_vrm.expressions.expression.textureTransformBind.schema.json

const SCALE = 'scale';
const OFFSET = 'offset';

const List<String> VRMC_VRM_EXPRESSIONS_TEXTURE_TRANSFORM_BIND = <String>[
  MATERIAL,
  SCALE,
  OFFSET,
];

class VrmcVrmExpressionsTextureTransformBind extends GltfProperty {
  final int materialIndex;
  final List<double> scale;
  final List<double> offset;

  Material material;

  VrmcVrmExpressionsTextureTransformBind._(this.materialIndex, this.scale,
      this.offset, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcVrmExpressionsTextureTransformBind fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_EXPRESSIONS_MORPH_TARGET_BIND, context);
    }

    return VrmcVrmExpressionsTextureTransformBind._(
        getIndex(map, MATERIAL, context, req: true),
        getFloatList(map, SCALE, context,
            lengthsList: const [2], def: const [1, 1]),
        getFloatList(map, OFFSET, context,
            lengthsList: const [2], def: const [0, 0]),
        getExtensions(map, VrmcVrmExpressionsTextureTransformBind, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    material = gltf.materials[materialIndex];

    if (context.validate) {
      // check material
      if (materialIndex != -1) {
        if (material == null) {
          context.addIssue(LinkError.unresolvedReference,
              name: MATERIAL, args: [materialIndex]);
        } else {
          material.markAsUsed();
        }
      }
    }
  }
}

// expression
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/schema/VRMC_vrm.expressions.expression.schema.json

const String MORPH_TARGET_BINDS = 'morphTargetBinds';
const String MATERIAL_COLOR_BINDS = 'materialColorBinds';
const String TEXTURE_TRANSFORM_BINDS = 'textureTransformBinds';
const String IS_BINARY = 'isBinary';
const String OVERRIDE_BLINK = 'overrideBlink';
const String OVERRIDE_LOOK_AT = 'overrideLookAt';
const String OVERRIDE_MOUTH = 'overrideMouth';

const List<String> VRMC_VRM_EXPRESSIONS_EXPRESSION_MEMBERS = <String>[
  MORPH_TARGET_BINDS,
  MATERIAL_COLOR_BINDS,
  TEXTURE_TRANSFORM_BINDS,
  IS_BINARY,
  OVERRIDE_BLINK,
  OVERRIDE_LOOK_AT,
  OVERRIDE_MOUTH,
];

const String NONE = 'none';
const String BLOCK = 'block';
const String BLEND = 'blend';

const List<String> VRMC_VRM_EXPRESSIONS_OVERRIDES = <String>[
  NONE,
  BLOCK,
  BLEND,
];

class VrmcVrmExpressionsExpression extends GltfProperty {
  final List<VrmcVrmExpressionsMorphTargetBind> morphTargetBinds;
  final List<VrmcVrmExpressionsMaterialColorBind> materialColorBinds;
  final List<VrmcVrmExpressionsTextureTransformBind> textureTransformBinds;
  final bool isBinary;
  final String overrideBlink;
  final String overrideLookAt;
  final String overrideMouth;

  VrmcVrmExpressionsExpression._(
      this.morphTargetBinds,
      this.materialColorBinds,
      this.textureTransformBinds,
      this.isBinary,
      this.overrideBlink,
      this.overrideLookAt,
      this.overrideMouth,
      Map<String, Object> extensions,
      Object extras)
      : super(extensions, extras);

  static SafeList<T> getObjectList<T>(Map<String, Object> map, String name,
      Context context, FromMapFunction<T> fromMap) {
    if (!map.containsKey(name)) {
      return SafeList<T>.empty(name);
    }

    final list = getMapList(map, name, context);
    final result = SafeList<T>(list.length, name);

    context.path.add(name);
    for (var i = 0; i < list.length; i++) {
      final item = list[i];
      context.path.add(i.toString());
      result[i] = fromMap(item, context);
      context.path.removeLast();
    }
    context.path.removeLast();

    return result;
  }

  static VrmcVrmExpressionsExpression fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_EXPRESSIONS_EXPRESSION_MEMBERS, context);
    }

    final morphTargetBinds = VrmcVrmExpressionsExpression.getObjectList<
            VrmcVrmExpressionsMorphTargetBind>(map, MORPH_TARGET_BINDS, context,
        VrmcVrmExpressionsMorphTargetBind.fromMap);
    final materialColorBinds = VrmcVrmExpressionsExpression.getObjectList<
            VrmcVrmExpressionsMaterialColorBind>(map, MATERIAL_COLOR_BINDS,
        context, VrmcVrmExpressionsMaterialColorBind.fromMap);
    final textureTransformBinds = VrmcVrmExpressionsExpression.getObjectList<
            VrmcVrmExpressionsTextureTransformBind>(
        map,
        TEXTURE_TRANSFORM_BINDS,
        context,
        VrmcVrmExpressionsTextureTransformBind.fromMap);

    return VrmcVrmExpressionsExpression._(
        morphTargetBinds,
        materialColorBinds,
        textureTransformBinds,
        getBool(map, IS_BINARY, context),
        getString(map, OVERRIDE_BLINK, context,
            list: VRMC_VRM_EXPRESSIONS_OVERRIDES, req: false),
        getString(map, OVERRIDE_LOOK_AT, context,
            list: VRMC_VRM_EXPRESSIONS_OVERRIDES, req: false),
        getString(map, OVERRIDE_MOUTH, context,
            list: VRMC_VRM_EXPRESSIONS_OVERRIDES, req: false),
        getExtensions(map, VrmcVrmExpressionsExpression, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    context.path.add(MORPH_TARGET_BINDS);
    for (var i = 0; i < morphTargetBinds.length; i ++) {
      context.path.add(i.toString());
      morphTargetBinds[i].link(gltf, context);
      context.path.removeLast();
    }
    context.path.removeLast();

    context.path.add(MATERIAL_COLOR_BINDS);
    for (var i = 0; i < materialColorBinds.length; i ++) {
      context.path.add(i.toString());
      materialColorBinds[i].link(gltf, context);
      context.path.removeLast();
    }
    context.path.removeLast();

    context.path.add(TEXTURE_TRANSFORM_BINDS);
    for (var i = 0; i < textureTransformBinds.length; i ++) {
      context.path.add(i.toString());
      textureTransformBinds[i].link(gltf, context);
      context.path.removeLast();
    }
    context.path.removeLast();
  }

  void validateOverride(String name, Context context) {
    // Override settings for the same kind are ignored
    // https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/expressions.md#procedural-override
    if (VRMC_VRM_EXPRESSIONS_BLINK_EXPRESSIONS.contains(name) &&
        (overrideBlink != null && overrideBlink != NONE)) {
      context.addIssue(
          SemanticError.vrmcVrmExpressionsInvalidExpressionOverride,
          name: OVERRIDE_BLINK,
          args: [name, OVERRIDE_BLINK]);
    }

    if (VRMC_VRM_EXPRESSIONS_LOOK_AT_EXPRESSIONS.contains(name) &&
        (overrideLookAt != null && overrideLookAt != NONE)) {
      context.addIssue(
          SemanticError.vrmcVrmExpressionsInvalidExpressionOverride,
          name: OVERRIDE_LOOK_AT,
          args: [name, OVERRIDE_LOOK_AT]);
    }

    if (VRMC_VRM_EXPRESSIONS_MOUTH_EXPRESSIONS.contains(name) &&
        (overrideMouth != null && overrideMouth != NONE)) {
      context.addIssue(
          SemanticError.vrmcVrmExpressionsInvalidExpressionOverride,
          name: OVERRIDE_MOUTH,
          args: [name, OVERRIDE_MOUTH]);
    }
  }
}

// expressions
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/schema/VRMC_vrm.expressions.schema.json

const HAPPY = 'happy';
const ANGRY = 'angry';
const SAD = 'sad';
const RELAXED = 'relaxed';
const SURPRISED = 'surprised';
const AA = 'aa';
const IH = 'ih';
const OU = 'ou';
const EE = 'ee';
const OH = 'oh';
const BLINK = 'blink';
const BLINK_LEFT = 'blinkLeft';
const BLINK_RIGHT = 'blinkRight';
const LOOK_UP = 'lookUp';
const LOOK_DOWN = 'lookDown';
const LOOK_LEFT = 'lookLeft';
const LOOK_RIGHT = 'lookRight';
const NEUTRAL = 'neutral';

const List<String> VRMC_VRM_EXPRESSIONS_PRESET_MEMBERS = <String>[
  HAPPY,
  ANGRY,
  SAD,
  RELAXED,
  SURPRISED,
  AA,
  IH,
  OU,
  EE,
  OH,
  BLINK,
  BLINK_LEFT,
  BLINK_RIGHT,
  LOOK_UP,
  LOOK_DOWN,
  LOOK_LEFT,
  LOOK_RIGHT,
  NEUTRAL,
];

const String PRESET = 'preset';
const String CUSTOM = 'custom';

const List<String> VRMC_VRM_EXPRESSIONS_MEMBERS = <String>[
  PRESET,
  CUSTOM,
];

const List<String> VRMC_VRM_EXPRESSIONS_BLINK_EXPRESSIONS = <String>[
  BLINK,
  BLINK_LEFT,
  BLINK_RIGHT,
];

const List<String> VRMC_VRM_EXPRESSIONS_LOOK_AT_EXPRESSIONS = <String>[
  LOOK_UP,
  LOOK_DOWN,
  LOOK_LEFT,
  LOOK_RIGHT,
];

const List<String> VRMC_VRM_EXPRESSIONS_MOUTH_EXPRESSIONS = <String>[
  AA,
  IH,
  OU,
  EE,
  OH,
];

class VrmcVrmExpressions extends GltfProperty {
  final Map<String, VrmcVrmExpressionsExpression> preset;
  final Map<String, VrmcVrmExpressionsExpression> custom;

  VrmcVrmExpressions._(
      this.preset, this.custom, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcVrmExpressions fromMap(Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_EXPRESSIONS_MEMBERS, context);
    }

    final preset = <String, VrmcVrmExpressionsExpression>{};

    final presetMap = getMap(map, PRESET, context, req: false);
    if (presetMap != null) {
      context.path.add(PRESET);
      for (final name in presetMap.keys) {
        checkMembers(presetMap, VRMC_VRM_EXPRESSIONS_PRESET_MEMBERS, context);

        preset[name] = getObjectFromInnerMap(
            presetMap, name, context, VrmcVrmExpressionsExpression.fromMap);
      }
      context.path.removeLast();
    }

    final custom = <String, VrmcVrmExpressionsExpression>{};

    final customMap = getMap(map, CUSTOM, context, req: false);
    if (customMap != null) {
      context.path.add(CUSTOM);
      for (final name in customMap.keys) {
        // Custom Expressions cannot have names
        // that are the same as any Preset Expressions
        // https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/expressions.md#custom-expressions
        if (VRMC_VRM_EXPRESSIONS_PRESET_MEMBERS.contains(name)) {
          context.addIssue(
              SemanticError.vrmcVrmExpressionsInvalidCustomExpression,
              name: name,
              args: [name]);
        }

        custom[name] = getObjectFromInnerMap(
            customMap, name, context, VrmcVrmExpressionsExpression.fromMap);
      }
      context.path.removeLast();
    }

    return VrmcVrmExpressions._(
        preset,
        custom,
        getExtensions(map, VrmcVrmExpressions, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    context.path.add(PRESET);
    preset.forEach((name, expression) {
      context.path.add(name);
      expression
        ..link(gltf, context)
        ..validateOverride(name, context);
      context.path.removeLast();
    });
    context.path.removeLast();

    context.path.add(CUSTOM);
    custom.forEach((name, expression) {
      context.path.add(name);
      expression.link(gltf, context);
      context.path.removeLast();
    });
    context.path.removeLast();
  }
}
