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

// rotation constraint
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_node_constraint-1.0_beta/schema/VRMC_node_constraint.rotationConstraint.schema.json

const String SOURCE = 'source';
const String WEIGHT = 'weight';

const List<String> VRMC_NODE_CONSTRAINT_ROTATION_CONSTRAINT_MEMBERS = <String>[
  SOURCE,
  WEIGHT,
];

class VrmcNodeConstraintRotationConstraint extends GltfProperty {
  final int sourceIndex;
  final double weight;

  Node source;

  VrmcNodeConstraintRotationConstraint._(this.sourceIndex, this.weight,
      Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcNodeConstraintRotationConstraint fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(
          map, VRMC_NODE_CONSTRAINT_ROTATION_CONSTRAINT_MEMBERS, context);
    }

    return VrmcNodeConstraintRotationConstraint._(
        getIndex(map, SOURCE, context, req: true),
        getFloat(map, WEIGHT, context, min: 0, max: 1, def: 1),
        getExtensions(map, VrmcNodeConstraintRotationConstraint, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    source = gltf.nodes[sourceIndex];

    if (context.validate && sourceIndex != -1) {
      if (source == null) {
        context.addIssue(LinkError.unresolvedReference,
            name: SOURCE, args: [sourceIndex]);
      } else {
        source.markAsUsed();
      }
    }
  }
}
