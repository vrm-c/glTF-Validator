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
import 'package:gltf/src/ext/VRMC_springBone/vrmc_spring_bone.dart';
import 'package:gltf/src/ext/VRMC_springBone/vrmc_spring_bone_collider_group.dart';
import 'package:gltf/src/ext/VRMC_springBone/vrmc_spring_bone_spring_joint.dart';

// spring
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_springBone-1.0-beta/schema/VRMC_springBone.spring.schema.json

const String NAME = 'name';
const String JOINTS = 'joints';
const String COLLIDER_GROUPS = 'colliderGroups';
const String CENTER = 'center';

const List<String> VRMC_SPRING_BONE_SPRING_MEMBERS = <String>[
  NAME,
  JOINTS,
  COLLIDER_GROUPS,
  CENTER,
];

class VrmcSpringBoneSpring extends GltfProperty {
  final String name;
  final List<VrmcSpringBoneSpringJoint> joints;
  final List<int> colliderGroupIndices;
  final int centerIndex;

  List<VrmcSpringBoneColliderGroup> colliderGroups;
  Node center;

  VrmcSpringBoneSpring._(this.name, this.joints, this.colliderGroupIndices,
      this.centerIndex, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static SafeList<T> getObjectList<T>(Map<String, Object> map, String name,
      Context context, FromMapFunction<T> fromMap,
      {bool req = false}) {
    if (!map.containsKey(name)) {
      if (context.validate && req) {
        context.addIssue(SchemaError.undefinedProperty, args: [name]);
      }

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

  static VrmcSpringBoneSpring fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_SPRING_BONE_SPRING_MEMBERS, context);
    }

    final joints = VrmcSpringBoneSpring.getObjectList(
        map, JOINTS, context, VrmcSpringBoneSpringJoint.fromMap,
        req: true);

    return VrmcSpringBoneSpring._(
        getString(map, NAME, context),
        joints,
        getIndicesList(map, COLLIDER_GROUPS, context, req: false),
        getIndex(map, CENTER, context, req: false),
        getExtensions(map, VrmcSpringBoneSpring, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    // joints
    context.path.add(JOINTS);

    if (joints != null) {
      for (var i = 0; i < joints.length; i++) {
        context.path.add(i.toString());
        joints[i].link(gltf, context);
        context.path.removeLast();
      }
    }

    context.path.removeLast();

    // collider groups
    context.path.add(COLLIDER_GROUPS);

    if (colliderGroupIndices != null) {
      colliderGroups = List.filled(colliderGroupIndices.length, null);

      final ext = gltf.extensions[VRMC_SPRING_BONE];
      if (ext is VrmcSpringBone) {
        for (var i = 0; i < colliderGroupIndices.length; i++) {
          context.path.add(i.toString());

          final index = colliderGroupIndices[i];
          final colliderGroup = ext.colliderGroups[index];
          colliderGroups[i] = colliderGroup;

          if (context.validate && colliderGroup == null) {
            context.addIssue(LinkError.unresolvedReference, args: [index]);
          }

          context.path.removeLast();
        }
      }
    }

    context.path.removeLast();

    // center
    center = gltf.nodes[centerIndex];

    if (context.validate && centerIndex != -1) {
      if (center == null) {
        context.addIssue(LinkError.unresolvedReference,
            name: CENTER, args: [centerIndex]);
      } else {
        center.markAsUsed();
      }
    }
  }
}
