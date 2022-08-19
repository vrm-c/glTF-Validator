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

library gltf.extensions.vrmc_vrm;

import 'package:gltf/src/base/gltf_property.dart';
import 'package:gltf/src/ext/VRMC_springBone/vrmc_spring_bone_collider.dart';
import 'package:gltf/src/ext/VRMC_springBone/vrmc_spring_bone_collider_group.dart';
import 'package:gltf/src/ext/VRMC_springBone/vrmc_spring_bone_spring.dart';
import 'package:gltf/src/ext/extensions.dart';

// VRMC_springBone
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_springBone-1.0-beta/schema/VRMC_springBone.schema.json

const String VRMC_SPRING_BONE = 'VRMC_springBone';
const String SPEC_VERSION = 'specVersion';
const String COLLIDERS = 'colliders';
const String COLLIDER_GROUPS = 'colliderGroups';
const String SPRINGS = 'springs';

const List<String> VRMC_SPRING_BONE_MEMBERS = <String>[
  SPEC_VERSION,
  COLLIDERS,
  COLLIDER_GROUPS,
  SPRINGS,
];

const String SPEC_VERSION_10_BETA = '1.0-beta';

const List<String> VRMC_VRM_SPEC_VERSIONS = <String>[
  SPEC_VERSION_10_BETA,
];

class VrmcSpringBone extends GltfProperty {
  final String specVersion;
  final List<VrmcSpringBoneCollider> colliders;
  final List<VrmcSpringBoneColliderGroup> colliderGroups;
  final List<VrmcSpringBoneSpring> springs;

  VrmcSpringBone._(this.specVersion, this.colliders, this.colliderGroups,
      this.springs, Map<String, Object> extensions, Object extras)
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

  static VrmcSpringBone fromMap(Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_SPRING_BONE_MEMBERS, context);
    }

    final specVersion = getString(map, SPEC_VERSION, context,
        list: VRMC_VRM_SPEC_VERSIONS, req: true);

    final colliders = VrmcSpringBone.getObjectList(
        map, COLLIDERS, context, VrmcSpringBoneCollider.fromMap);

    final colliderGroups = VrmcSpringBone.getObjectList(
        map, COLLIDER_GROUPS, context, VrmcSpringBoneColliderGroup.fromMap);

    final springs = VrmcSpringBone.getObjectList(
        map, SPRINGS, context, VrmcSpringBoneSpring.fromMap);

    return VrmcSpringBone._(specVersion, colliders, colliderGroups, springs,
        getExtensions(map, VrmcSpringBone, context), getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    context.path.add(COLLIDERS);

    if (colliders != null) {
      for (var i = 0; i < colliders.length; i++) {
        context.path.add(i.toString());
        colliders[i].link(gltf, context);
        context.path.removeLast();
      }
    }

    context.path.removeLast();

    context.path.add(COLLIDER_GROUPS);

    if (colliderGroups != null) {
      for (var i = 0; i < colliderGroups.length; i++) {
        context.path.add(i.toString());
        colliderGroups[i].link(gltf, context);
        context.path.removeLast();
      }
    }

    context.path.removeLast();

    context.path.add(SPRINGS);

    if (springs != null) {
      for (var i = 0; i < springs.length; i++) {
        context.path.add(i.toString());
        springs[i].link(gltf, context);
        context.path.removeLast();
      }
    }

    context.path.removeLast();
  }
}

const Extension vrmcSpringBoneExtension =
    Extension(VRMC_SPRING_BONE, <Type, ExtensionDescriptor>{
  Gltf: ExtensionDescriptor(VrmcSpringBone.fromMap),
});
