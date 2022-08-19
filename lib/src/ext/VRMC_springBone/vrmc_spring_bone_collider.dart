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
import 'package:gltf/src/ext/VRMC_springBone/vrmc_spring_bone_collider_shape.dart';

// collider
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_springBone-1.0-beta/schema/VRMC_springBone.collider.schema.json

const String NODE = 'node';
const String SHAPE = 'shape';

const List<String> VRMC_SPRING_BONE_COLLIDER_MEMBERS = <String>[
  NODE,
  SHAPE,
];

class VrmcSpringBoneCollider extends GltfProperty {
  final int nodeIndex;
  final VrmcSpringBoneColliderShape shape;

  Node node;

  VrmcSpringBoneCollider._(
      this.nodeIndex, this.shape, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcSpringBoneCollider fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_SPRING_BONE_COLLIDER_MEMBERS, context);
    }

    return VrmcSpringBoneCollider._(
        getIndex(map, NODE, context),
        getObjectFromInnerMap(
            map, SHAPE, context, VrmcSpringBoneColliderShape.fromMap),
        getExtensions(map, VrmcSpringBoneCollider, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
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
