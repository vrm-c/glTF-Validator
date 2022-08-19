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
import 'package:gltf/src/ext/VRMC_springBone/vrmc_spring_bone_collider.dart';

// collider group
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_springBone-1.0-beta/schema/VRMC_springBone.colliderGroup.schema.json

const String NAME = 'name';
const String COLLIDERS = 'colliders';

const List<String> VRMC_SPRING_BONE_COLLIDER_MEMBERS = <String>[
  NAME,
  COLLIDERS,
];

class VrmcSpringBoneColliderGroup extends GltfProperty {
  final String name;
  final List<int> colliderIndices;

  List<VrmcSpringBoneCollider> colliders;

  VrmcSpringBoneColliderGroup._(this.name, this.colliderIndices,
      Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcSpringBoneColliderGroup fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_SPRING_BONE_COLLIDER_MEMBERS, context);
    }

    return VrmcSpringBoneColliderGroup._(
        getString(map, NAME, context),
        getIndicesList(map, COLLIDERS, context, req: true),
        getExtensions(map, VrmcSpringBoneColliderGroup, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    context.path.add(COLLIDERS);

    if (colliderIndices != null) {
      colliders = List.filled(colliderIndices.length, null);

      final ext = gltf.extensions[VRMC_SPRING_BONE];
      if (ext is VrmcSpringBone) {
        for (var i = 0; i < colliderIndices.length; i++) {
          context.path.add(i.toString());

          final index = colliderIndices[i];
          final collider = ext.colliders[index];
          colliders[i] = collider;

          if (context.validate && collider == null) {
            context.addIssue(LinkError.unresolvedReference, args: [index]);
          }

          context.path.removeLast();
        }
      }
    }

    context.path.removeLast();
  }
}
