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
import 'package:gltf/src/ext/VRMC_vrm/vrmc_vrm.dart';
import 'package:gltf/src/ext/VRMC_vrm/vrmc_vrm_expressions.dart';
import 'package:gltf/src/ext/VRMC_vrm/vrmc_vrm_humanoid.dart';
import 'package:vector_math/vector_math.dart';

// rangeMap
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/schema/VRMC_vrm.lookAt.rangeMap.schema.json

const String INPUT_MAX_VALUE = 'inputMaxValue';
const String OUTPUT_SCALE = 'outputScale';

const List<String> VRMC_VRM_LOOK_AT_RANGE_MAP_MEMBERS = <String>[
  INPUT_MAX_VALUE,
  OUTPUT_SCALE,
];

class VrmcVrmLookAtRangeMap extends GltfProperty {
  final double inputMaxValue;
  final double outputScale;

  Node node;

  VrmcVrmLookAtRangeMap._(this.inputMaxValue, this.outputScale,
      Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcVrmLookAtRangeMap fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_LOOK_AT_RANGE_MAP_MEMBERS, context);
    }

    return VrmcVrmLookAtRangeMap._(
        getFloat(map, INPUT_MAX_VALUE, context),
        getFloat(map, OUTPUT_SCALE, context),
        getExtensions(map, VrmcVrmLookAtRangeMap, context),
        getExtras(map, context));
  }
}

// lookAt
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/schema/VRMC_vrm.lookAt.schema.json

const String OFFSET_FROM_HEAD_BONE = 'offsetFromHeadBone';
const String TYPE = 'type';
const String RANGE_MAP_HORIZONTAL_INNER = 'rangeMapHorizontalInner';
const String RANGE_MAP_HORIZONTAL_OUTER = 'rangeMapHorizontalOuter';
const String RANGE_MAP_VERTICAL_DOWN = 'rangeMapVerticalDown';
const String RANGE_MAP_VERTICAL_UP = 'rangeMapVerticalUp';

const List<String> VRMC_VRM_FIRST_PERSON_MEMBERS = <String>[
  OFFSET_FROM_HEAD_BONE,
  TYPE,
  RANGE_MAP_HORIZONTAL_INNER,
  RANGE_MAP_HORIZONTAL_OUTER,
  RANGE_MAP_VERTICAL_DOWN,
  RANGE_MAP_VERTICAL_UP,
];

const BONE = 'bone';
const EXPRESSION = 'expression';

const List<String> VRMC_VRM_LOOK_AT_TYPES = <String>[
  BONE,
  EXPRESSION,
];

class VrmcVrmLookAt extends GltfProperty {
  final Vector3 offsetFromHeadBone;
  final String type;
  final VrmcVrmLookAtRangeMap rangeMapHorizontalInner;
  final VrmcVrmLookAtRangeMap rangeMapHorizontalOuter;
  final VrmcVrmLookAtRangeMap rangeMapVerticalDown;
  final VrmcVrmLookAtRangeMap rangeMapVerticalUp;

  VrmcVrmLookAt._(
      this.offsetFromHeadBone,
      this.type,
      this.rangeMapHorizontalInner,
      this.rangeMapHorizontalOuter,
      this.rangeMapVerticalDown,
      this.rangeMapVerticalUp,
      Map<String, Object> extensions,
      Object extras)
      : super(extensions, extras);

  static VrmcVrmLookAt fromMap(Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_FIRST_PERSON_MEMBERS, context);
    }

    Vector3 offsetFromHeadBone;
    if (map.containsKey(OFFSET_FROM_HEAD_BONE)) {
      final list = getFloatList(map, OFFSET_FROM_HEAD_BONE, context,
          lengthsList: const [3]);
      if (list != null) {
        offsetFromHeadBone = Vector3.array(list);
      }
    }

    return VrmcVrmLookAt._(
        offsetFromHeadBone,
        getString(map, TYPE, context, list: VRMC_VRM_LOOK_AT_TYPES),
        getObjectFromInnerMap(map, RANGE_MAP_HORIZONTAL_INNER, context,
            VrmcVrmLookAtRangeMap.fromMap),
        getObjectFromInnerMap(map, RANGE_MAP_HORIZONTAL_OUTER, context,
            VrmcVrmLookAtRangeMap.fromMap),
        getObjectFromInnerMap(map, RANGE_MAP_VERTICAL_DOWN, context,
            VrmcVrmLookAtRangeMap.fromMap),
        getObjectFromInnerMap(
            map, RANGE_MAP_VERTICAL_UP, context, VrmcVrmLookAtRangeMap.fromMap),
        getExtensions(map, VrmcVrmLookAt, context),
        getExtras(map, context));
  }

  void validateType(Gltf gltf, Context context) {
    context.path.add(TYPE);

    if (type != null) {
      final vrmExtension = gltf.extensions[VRMC_VRM];
      if (vrmExtension is VrmcVrm) {
        if (type == BONE) {
          // if type is bone and humanoid does not have eyes,
          // emit a warning

          final bones = vrmExtension.humanoid.humanBones.bones;

          if (bones.containsKey(LEFT_EYE) || bones.containsKey(RIGHT_EYE)) {
            // ok!
          } else {
            context.addIssue(LinkError.vrmcVrmLookAtTypeNoEffect,
                args: [BONE, 'bones']);
          }
        } else if (type == EXPRESSION) {
          // if type is expression and expression does not have eye expressions,
          // emit a warning

          final presets = vrmExtension.expressions.preset;

          if (presets.containsKey(LOOK_LEFT) ||
              presets.containsKey(LOOK_RIGHT) ||
              presets.containsKey(LOOK_DOWN) ||
              presets.containsKey(LOOK_UP)) {
            // ok!
          } else {
            context.addIssue(LinkError.vrmcVrmLookAtTypeNoEffect,
                args: [EXPRESSION, 'expressions']);
          }
        }
      }
    }

    context.path.removeLast();
  }

  @override
  void link(Gltf gltf, Context context) {
    validateType(gltf, context);
  }
}
