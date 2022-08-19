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
import 'package:vector_math/vector_math.dart';

// spring
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_springBone-1.0-beta/schema/VRMC_springBone.joint.schema.json

const String NODE = 'node';
const String HIT_RADIUS = 'hitRadius';
const String STIFFNESS = 'stiffness';
const String GRAVITY_POWER = 'gravityPower';
const String GRAVITY_DIR = 'gravityDir';
const String DRAG_FORCE = 'dragForce';

const List<String> VRMC_SPRING_BONE_SPRING_JOINT_MEMBERS = <String>[
  NODE,
  HIT_RADIUS,
  STIFFNESS,
  GRAVITY_POWER,
  GRAVITY_DIR,
  DRAG_FORCE,
];

class VrmcSpringBoneSpringJoint extends GltfProperty {
  final int nodeIndex;
  final double hitRadius;
  final double stiffness;
  final double gravityPower;
  final Vector3 gravityDir;
  final double dragForce;

  Node node;

  VrmcSpringBoneSpringJoint._(
      this.nodeIndex,
      this.hitRadius,
      this.stiffness,
      this.gravityPower,
      this.gravityDir,
      this.dragForce,
      Map<String, Object> extensions,
      Object extras)
      : super(extensions, extras);

  static VrmcSpringBoneSpringJoint fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_SPRING_BONE_SPRING_JOINT_MEMBERS, context);
    }

    Vector3 gravityDir;
    if (map.containsKey(GRAVITY_DIR)) {
      final list =
          getFloatList(map, GRAVITY_DIR, context, lengthsList: const [3]);
      if (list != null) {
        gravityDir = Vector3.array(list);
      }
    }

    return VrmcSpringBoneSpringJoint._(
        getIndex(map, NODE, context, req: true),
        getFloat(map, HIT_RADIUS, context),
        getFloat(map, STIFFNESS, context),
        getFloat(map, GRAVITY_POWER, context),
        gravityDir,
        getFloat(map, DRAG_FORCE, context),
        getExtensions(map, VrmcSpringBoneSpringJoint, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    // node
    node = gltf.nodes[nodeIndex];

    if (context.validate && nodeIndex != -1) {
      if (node == null) {
        context.addIssue(LinkError.unresolvedReference,
            name: NODE, args: [nodeIndex]);
      } else {
        node.markAsUsed();
      }
    }
  }
}
