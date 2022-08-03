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

// meshAnnotation
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/schema/VRMC_vrm.firstPerson.meshAnnotation.schema.json

const String NODE = 'node';
const String TYPE = 'type';

const List<String> VRMC_VRM_FIRST_PERSON_MESH_ANNOTATION_MEMBERS = <String>[
  NODE,
  TYPE,
];

const String AUTO = 'auto';
const String BOTH = 'both';
const String THIRD_PERSON_ONLY = 'thirdPersonOnly';
const String FIRST_PERSON_ONLY = 'firstPersonOnly';

const List<String> VRMC_VRM_FIRST_PERSON_MESH_ANNOTATION_TYPES = <String>[
  AUTO,
  BOTH,
  THIRD_PERSON_ONLY,
  FIRST_PERSON_ONLY,
];

class VrmcVrmFirstPersonMeshAnnotation extends GltfProperty {
  final int nodeIndex;
  final String type;

  Node node;

  VrmcVrmFirstPersonMeshAnnotation._(
      this.nodeIndex, this.type, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcVrmFirstPersonMeshAnnotation fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_FIRST_PERSON_MESH_ANNOTATION_MEMBERS, context);
    }

    return VrmcVrmFirstPersonMeshAnnotation._(
        getIndex(map, NODE, context, req: true),
        getString(map, TYPE, context,
            list: VRMC_VRM_FIRST_PERSON_MESH_ANNOTATION_TYPES, req: true),
        getExtensions(map, VrmcVrmFirstPersonMeshAnnotation, context),
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
    }
  }
}

// firstPerson
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/schema/VRMC_vrm.firstPerson.schema.json

const String MESH_ANNOTATIONS = 'meshAnnotations';

const List<String> VRMC_VRM_FIRST_PERSON_MEMBERS = <String>[
  MESH_ANNOTATIONS,
];

class VrmcVrmFirstPerson extends GltfProperty {
  final List<VrmcVrmFirstPersonMeshAnnotation> meshAnnotations;

  VrmcVrmFirstPerson._(
      this.meshAnnotations, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcVrmFirstPerson fromMap(Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_FIRST_PERSON_MEMBERS, context);
    }

    SafeList<VrmcVrmFirstPersonMeshAnnotation> meshAnnotations;

    if (!map.containsKey(MESH_ANNOTATIONS)) {
      meshAnnotations =
          SafeList<VrmcVrmFirstPersonMeshAnnotation>.empty(MESH_ANNOTATIONS);
    } else {
      final meshAnnotationMapList = getMapList(map, MESH_ANNOTATIONS, context);
      meshAnnotations = SafeList<VrmcVrmFirstPersonMeshAnnotation>(
          meshAnnotationMapList.length, MESH_ANNOTATIONS);

      context.path.add(MESH_ANNOTATIONS);
      for (var i = 0; i < meshAnnotationMapList.length; i++) {
        final meshAnnotationMap = meshAnnotationMapList[i];
        context.path.add(i.toString());
        meshAnnotations[i] = VrmcVrmFirstPersonMeshAnnotation.fromMap(
            meshAnnotationMap, context);
        context.path.removeLast();
      }
      context.path.removeLast();
    }

    return VrmcVrmFirstPerson._(
        meshAnnotations,
        getExtensions(map, VrmcVrmFirstPerson, context),
        getExtras(map, context));
  }

  void validateDuplicates(Context context) {
    // check node index uniqueness
    final foundSet = <int>{};

    context.path.add(MESH_ANNOTATIONS);
    for (var i = 0; i < meshAnnotations.length; i ++) {
      context.path.add(i.toString());

      final meshAnnotation = meshAnnotations[i];
      final index = meshAnnotation.nodeIndex;

      context.path.add(NODE);

      // set.add returns true if the given item is not yet in the set,
      // returns false if the item already exists
      if (!foundSet.add(index)) {
        context.addIssue(
            LinkError.vrmcVrmFirstPersonMeshAnnotationOverride,
            args: [index]);
      }

      context.path.removeLast();

      context.path.removeLast();
    }
    context.path.removeLast();
  }

  @override
  void link(Gltf gltf, Context context) {
    validateDuplicates(context);

    context.path.add(MESH_ANNOTATIONS);
    for (final meshAnnotation in meshAnnotations) {
      meshAnnotation.link(gltf, context);
    }
    context.path.removeLast();
  }
}
