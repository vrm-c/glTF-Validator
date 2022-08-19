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

// sphere

const String OFFSET = 'offset';
const String RADIUS = 'radius';

const List<String> VRMC_SPRING_BONE_COLLIDER_SHAPE_SPHERE_MEMBERS = <String>[
  OFFSET,
  RADIUS,
];

class VrmcSpringBoneColliderShapeSphere extends GltfProperty {
  final Vector3 offset;
  final double radius;

  VrmcSpringBoneColliderShapeSphere._(
      this.offset, this.radius, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcSpringBoneColliderShapeSphere fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(
          map, VRMC_SPRING_BONE_COLLIDER_SHAPE_SPHERE_MEMBERS, context);
    }

    Vector3 offset;
    if (map.containsKey(OFFSET)) {
      final list = getFloatList(map, OFFSET, context, lengthsList: const [3]);
      if (list != null) {
        offset = Vector3.array(list);
      }
    }

    return VrmcSpringBoneColliderShapeSphere._(
        offset,
        getFloat(map, RADIUS, context),
        getExtensions(map, VrmcSpringBoneColliderShapeSphere, context),
        getExtras(map, context));
  }
}

// capsule

const String TAIL = 'tail';

const List<String> VRMC_SPRING_BONE_COLLIDER_SHAPE_CAPSULE_MEMBERS = <String>[
  OFFSET,
  RADIUS,
  TAIL,
];

class VrmcSpringBoneColliderShapeCapsule extends GltfProperty {
  final Vector3 offset;
  final double radius;
  final Vector3 tail;

  VrmcSpringBoneColliderShapeCapsule._(this.offset, this.radius, this.tail,
      Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcSpringBoneColliderShapeCapsule fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(
          map, VRMC_SPRING_BONE_COLLIDER_SHAPE_CAPSULE_MEMBERS, context);
    }

    Vector3 offset;
    if (map.containsKey(OFFSET)) {
      final list = getFloatList(map, OFFSET, context, lengthsList: const [3]);
      if (list != null) {
        offset = Vector3.array(list);
      }
    }

    Vector3 tail;
    if (map.containsKey(TAIL)) {
      final list = getFloatList(map, TAIL, context, lengthsList: const [3]);
      if (list != null) {
        tail = Vector3.array(list);
      }
    }

    return VrmcSpringBoneColliderShapeCapsule._(
        offset,
        getFloat(map, RADIUS, context),
        tail,
        getExtensions(map, VrmcSpringBoneColliderShapeCapsule, context),
        getExtras(map, context));
  }
}

// shape
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_springBone-1.0-beta/schema/VRMC_springBone.shape.schema.json

const String SPHERE = 'sphere';
const String CAPSULE = 'capsule';

const List<String> VRMC_SPRING_BONE_COLLIDER_SHAPE_MEMBERS = <String>[
  SPHERE,
  CAPSULE,
];

class VrmcSpringBoneColliderShape extends GltfProperty {
  final VrmcSpringBoneColliderShapeSphere sphere;
  final VrmcSpringBoneColliderShapeCapsule capsule;

  Node node;

  VrmcSpringBoneColliderShape._(
      this.sphere, this.capsule, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcSpringBoneColliderShape fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_SPRING_BONE_COLLIDER_SHAPE_MEMBERS, context);
    }

    final sphere = getObjectFromInnerMap(
        map, SPHERE, context, VrmcSpringBoneColliderShapeSphere.fromMap);
    final capsule = getObjectFromInnerMap(
        map, CAPSULE, context, VrmcSpringBoneColliderShapeCapsule.fromMap);

    var oneOfCount = 0;
    oneOfCount += sphere != null ? 1 : 0;
    oneOfCount += capsule != null ? 1 : 0;

    if (oneOfCount != 1) {
      context.addIssue(SchemaError.oneOfMismatch, args: [SPHERE, CAPSULE]);
    }

    return VrmcSpringBoneColliderShape._(
        sphere,
        capsule,
        getExtensions(map, VrmcSpringBoneColliderShape, context),
        getExtras(map, context));
  }
}
