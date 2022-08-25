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
import 'package:gltf/src/ext/VRMC_node_constraint/vrmc_node_constraint_aim_constraint.dart';
import 'package:gltf/src/ext/VRMC_node_constraint/vrmc_node_constraint_roll_constraint.dart';
import 'package:gltf/src/ext/VRMC_node_constraint/vrmc_node_constraint_rotation_constraint.dart';

// constraint
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_node_constraint-1.0_beta/schema/VRMC_node_constraint.constraint.schema.json

const String ROLL = 'roll';
const String AIM = 'aim';
const String ROTATION = 'rotation';

const List<String> VRMC_NODE_CONSTRAINT_CONSTRAINT_MEMBERS = <String>[
  ROLL,
  AIM,
  ROTATION,
];

class VrmcNodeConstraintConstraint extends GltfProperty {
  final VrmcNodeConstraintRollConstraint roll;
  final VrmcNodeConstraintAimConstraint aim;
  final VrmcNodeConstraintRotationConstraint rotation;

  VrmcNodeConstraintConstraint._(
      this.roll, this.aim, this.rotation, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcNodeConstraintConstraint fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_NODE_CONSTRAINT_CONSTRAINT_MEMBERS, context);
    }

    final roll = getObjectFromInnerMap(
        map, ROLL, context, VrmcNodeConstraintRollConstraint.fromMap);
    final aim = getObjectFromInnerMap(
        map, AIM, context, VrmcNodeConstraintAimConstraint.fromMap);
    final rotation = getObjectFromInnerMap(
        map, ROTATION, context, VrmcNodeConstraintRotationConstraint.fromMap);

    var oneOfCount = 0;
    oneOfCount += roll != null ? 1 : 0;
    oneOfCount += aim != null ? 1 : 0;
    oneOfCount += rotation != null ? 1 : 0;

    if (oneOfCount != 1) {
      context.addIssue(SchemaError.oneOfMismatch, args: [ROLL, AIM, ROTATION]);
    }

    return VrmcNodeConstraintConstraint._(
        roll, aim, rotation,
        getExtensions(map, VrmcNodeConstraintConstraint, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    context.path.add(ROLL);
    roll?.link(gltf, context);
    context.path.removeLast();

    context.path.add(AIM);
    aim?.link(gltf, context);
    context.path.removeLast();

    context.path.add(ROTATION);
    rotation?.link(gltf, context);
    context.path.removeLast();
  }
}
