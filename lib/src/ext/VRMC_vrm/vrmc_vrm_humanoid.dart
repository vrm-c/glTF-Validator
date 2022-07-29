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

library gltf.extensions.vrmc_vrm_humanoid;

import 'package:gltf/src/base/gltf_property.dart';

const List<String> VRMC_VRM_HUMANOID_HUMAN_BONE_MEMBERS = <String>[
  NODE,
];

class VrmcVrmHumanoidHumanBone extends GltfProperty {
  final int nodeIndex;

  Node node;

  VrmcVrmHumanoidHumanBone._(
      this.nodeIndex, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcVrmHumanoidHumanBone fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_HUMANOID_HUMAN_BONE_MEMBERS, context);
    }

    final index = getIndex(map, NODE, context, req: true);

    return VrmcVrmHumanoidHumanBone._(index,
        getExtensions(map, VrmcVrmHumanoid, context), getExtras(map, context));
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

const String HIPS = 'hips';
const String SPINE = 'spine';
const String CHEST = 'chest';
const String UPPER_CHEST = 'upperChest';
const String NECK = 'neck';
const String HEAD = 'head';
const String LEFT_EYE = 'leftEye';
const String RIGHT_EYE = 'rightEye';
const String JAW = 'jaw';
const String LEFT_UPPER_LEG = 'leftUpperLeg';
const String LEFT_LOWER_LEG = 'leftLowerLeg';
const String LEFT_FOOT = 'leftFoot';
const String LEFT_TOES = 'leftToes';
const String RIGHT_UPPER_LEG = 'rightUpperLeg';
const String RIGHT_LOWER_LEG = 'rightLowerLeg';
const String RIGHT_FOOT = 'rightFoot';
const String RIGHT_TOES = 'rightToes';
const String LEFT_SHOULDER = 'leftShoulder';
const String LEFT_UPPER_ARM = 'leftUpperArm';
const String LEFT_LOWER_ARM = 'leftLowerArm';
const String LEFT_HAND = 'leftHand';
const String RIGHT_SHOULDER = 'rightShoulder';
const String RIGHT_UPPER_ARM = 'rightUpperArm';
const String RIGHT_LOWER_ARM = 'rightLowerArm';
const String RIGHT_HAND = 'rightHand';
const String LEFT_THUMB_METACARPAL = 'leftThumbMetacarpal';
const String LEFT_THUMB_PROXIMAL = 'leftThumbProximal';
const String LEFT_THUMB_DISTAL = 'leftThumbDistal';
const String LEFT_INDEX_PROXIMAL = 'leftIndexProximal';
const String LEFT_INDEX_INTERMEDIATE = 'leftIndexIntermediate';
const String LEFT_INDEX_DISTAL = 'leftIndexDistal';
const String LEFT_MIDDLE_PROXIMAL = 'leftMiddleProximal';
const String LEFT_MIDDLE_INTERMEDIATE = 'leftMiddleIntermediate';
const String LEFT_MIDDLE_DISTAL = 'leftMiddleDistal';
const String LEFT_RING_PROXIMAL = 'leftRingProximal';
const String LEFT_RING_INTERMEDIATE = 'leftRingIntermediate';
const String LEFT_RING_DISTAL = 'leftRingDistal';
const String LEFT_LITTLE_PROXIMAL = 'leftLittleProximal';
const String LEFT_LITTLE_INTERMEDIATE = 'leftLittleIntermediate';
const String LEFT_LITTLE_DISTAL = 'leftLittleDistal';
const String RIGHT_THUMB_METACARPAL = 'rightThumbMetacarpal';
const String RIGHT_THUMB_PROXIMAL = 'rightThumbProximal';
const String RIGHT_THUMB_DISTAL = 'rightThumbDistal';
const String RIGHT_INDEX_PROXIMAL = 'rightIndexProximal';
const String RIGHT_INDEX_INTERMEDIATE = 'rightIndexIntermediate';
const String RIGHT_INDEX_DISTAL = 'rightIndexDistal';
const String RIGHT_MIDDLE_PROXIMAL = 'rightMiddleProximal';
const String RIGHT_MIDDLE_INTERMEDIATE = 'rightMiddleIntermediate';
const String RIGHT_MIDDLE_DISTAL = 'rightMiddleDistal';
const String RIGHT_RING_PROXIMAL = 'rightRingProximal';
const String RIGHT_RING_INTERMEDIATE = 'rightRingIntermediate';
const String RIGHT_RING_DISTAL = 'rightRingDistal';
const String RIGHT_LITTLE_PROXIMAL = 'rightLittleProximal';
const String RIGHT_LITTLE_INTERMEDIATE = 'rightLittleIntermediate';
const String RIGHT_LITTLE_DISTAL = 'rightLittleDistal';

const List<String> VRMC_VRM_HUMANOID_HUMAN_BONES_MEMBERS = <String>[
  HIPS,
  SPINE,
  CHEST,
  UPPER_CHEST,
  NECK,
  HEAD,
  LEFT_EYE,
  RIGHT_EYE,
  JAW,
  LEFT_UPPER_LEG,
  LEFT_LOWER_LEG,
  LEFT_FOOT,
  LEFT_TOES,
  RIGHT_UPPER_LEG,
  RIGHT_LOWER_LEG,
  RIGHT_FOOT,
  RIGHT_TOES,
  LEFT_SHOULDER,
  LEFT_UPPER_ARM,
  LEFT_LOWER_ARM,
  LEFT_HAND,
  RIGHT_SHOULDER,
  RIGHT_UPPER_ARM,
  RIGHT_LOWER_ARM,
  RIGHT_HAND,
  LEFT_THUMB_METACARPAL,
  LEFT_THUMB_PROXIMAL,
  LEFT_THUMB_DISTAL,
  LEFT_INDEX_PROXIMAL,
  LEFT_INDEX_INTERMEDIATE,
  LEFT_INDEX_DISTAL,
  LEFT_MIDDLE_PROXIMAL,
  LEFT_MIDDLE_INTERMEDIATE,
  LEFT_MIDDLE_DISTAL,
  LEFT_RING_PROXIMAL,
  LEFT_RING_INTERMEDIATE,
  LEFT_RING_DISTAL,
  LEFT_LITTLE_PROXIMAL,
  LEFT_LITTLE_INTERMEDIATE,
  LEFT_LITTLE_DISTAL,
  RIGHT_THUMB_METACARPAL,
  RIGHT_THUMB_PROXIMAL,
  RIGHT_THUMB_DISTAL,
  RIGHT_INDEX_PROXIMAL,
  RIGHT_INDEX_INTERMEDIATE,
  RIGHT_INDEX_DISTAL,
  RIGHT_MIDDLE_PROXIMAL,
  RIGHT_MIDDLE_INTERMEDIATE,
  RIGHT_MIDDLE_DISTAL,
  RIGHT_RING_PROXIMAL,
  RIGHT_RING_INTERMEDIATE,
  RIGHT_RING_DISTAL,
  RIGHT_LITTLE_PROXIMAL,
  RIGHT_LITTLE_INTERMEDIATE,
  RIGHT_LITTLE_DISTAL,
];

const Map<String, bool> VRMC_VRM_HUMANOID_HUMAN_BONES_REQUIRED = {
  HIPS: true,
  SPINE: true,
  CHEST: false,
  UPPER_CHEST: false,
  NECK: false,
  HEAD: true,
  LEFT_EYE: false,
  RIGHT_EYE: false,
  JAW: false,
  LEFT_UPPER_LEG: true,
  LEFT_LOWER_LEG: true,
  LEFT_FOOT: true,
  LEFT_TOES: false,
  RIGHT_UPPER_LEG: true,
  RIGHT_LOWER_LEG: true,
  RIGHT_FOOT: true,
  RIGHT_TOES: false,
  LEFT_SHOULDER: false,
  LEFT_UPPER_ARM: true,
  LEFT_LOWER_ARM: true,
  LEFT_HAND: true,
  RIGHT_SHOULDER: false,
  RIGHT_UPPER_ARM: true,
  RIGHT_LOWER_ARM: true,
  RIGHT_HAND: true,
  LEFT_THUMB_METACARPAL: false,
  LEFT_THUMB_PROXIMAL: false,
  LEFT_THUMB_DISTAL: false,
  LEFT_INDEX_PROXIMAL: false,
  LEFT_INDEX_INTERMEDIATE: false,
  LEFT_INDEX_DISTAL: false,
  LEFT_MIDDLE_PROXIMAL: false,
  LEFT_MIDDLE_INTERMEDIATE: false,
  LEFT_MIDDLE_DISTAL: false,
  LEFT_RING_PROXIMAL: false,
  LEFT_RING_INTERMEDIATE: false,
  LEFT_RING_DISTAL: false,
  LEFT_LITTLE_PROXIMAL: false,
  LEFT_LITTLE_INTERMEDIATE: false,
  LEFT_LITTLE_DISTAL: false,
  RIGHT_THUMB_METACARPAL: false,
  RIGHT_THUMB_PROXIMAL: false,
  RIGHT_THUMB_DISTAL: false,
  RIGHT_INDEX_PROXIMAL: false,
  RIGHT_INDEX_INTERMEDIATE: false,
  RIGHT_INDEX_DISTAL: false,
  RIGHT_MIDDLE_PROXIMAL: false,
  RIGHT_MIDDLE_INTERMEDIATE: false,
  RIGHT_MIDDLE_DISTAL: false,
  RIGHT_RING_PROXIMAL: false,
  RIGHT_RING_INTERMEDIATE: false,
  RIGHT_RING_DISTAL: false,
  RIGHT_LITTLE_PROXIMAL: false,
  RIGHT_LITTLE_INTERMEDIATE: false,
  RIGHT_LITTLE_DISTAL: false,
};

const Map<String, bool> VRMC_VRM_HUMANOID_HUMAN_BONES_NEEDS_PARENT = {
  HIPS: false,
  SPINE: false,
  CHEST: false,
  UPPER_CHEST: true,
  NECK: false,
  HEAD: false,
  LEFT_EYE: false,
  RIGHT_EYE: false,
  JAW: false,
  LEFT_UPPER_LEG: false,
  LEFT_LOWER_LEG: false,
  LEFT_FOOT: false,
  LEFT_TOES: false,
  RIGHT_UPPER_LEG: false,
  RIGHT_LOWER_LEG: false,
  RIGHT_FOOT: false,
  RIGHT_TOES: false,
  LEFT_SHOULDER: false,
  LEFT_UPPER_ARM: false,
  LEFT_LOWER_ARM: false,
  LEFT_HAND: false,
  RIGHT_SHOULDER: false,
  RIGHT_UPPER_ARM: false,
  RIGHT_LOWER_ARM: false,
  RIGHT_HAND: false,
  LEFT_THUMB_METACARPAL: false,
  LEFT_THUMB_PROXIMAL: true,
  LEFT_THUMB_DISTAL: true,
  LEFT_INDEX_PROXIMAL: false,
  LEFT_INDEX_INTERMEDIATE: true,
  LEFT_INDEX_DISTAL: true,
  LEFT_MIDDLE_PROXIMAL: false,
  LEFT_MIDDLE_INTERMEDIATE: true,
  LEFT_MIDDLE_DISTAL: true,
  LEFT_RING_PROXIMAL: false,
  LEFT_RING_INTERMEDIATE: true,
  LEFT_RING_DISTAL: true,
  LEFT_LITTLE_PROXIMAL: false,
  LEFT_LITTLE_INTERMEDIATE: true,
  LEFT_LITTLE_DISTAL: true,
  RIGHT_THUMB_METACARPAL: false,
  RIGHT_THUMB_PROXIMAL: true,
  RIGHT_THUMB_DISTAL: true,
  RIGHT_INDEX_PROXIMAL: false,
  RIGHT_INDEX_INTERMEDIATE: true,
  RIGHT_INDEX_DISTAL: true,
  RIGHT_MIDDLE_PROXIMAL: false,
  RIGHT_MIDDLE_INTERMEDIATE: true,
  RIGHT_MIDDLE_DISTAL: true,
  RIGHT_RING_PROXIMAL: false,
  RIGHT_RING_INTERMEDIATE: true,
  RIGHT_RING_DISTAL: true,
  RIGHT_LITTLE_PROXIMAL: false,
  RIGHT_LITTLE_INTERMEDIATE: true,
  RIGHT_LITTLE_DISTAL: true,
};

const Map<String, String> VRMC_VRM_HUMANOID_HUMAN_BONES_PARENT_MAP = {
  HIPS: null,
  SPINE: HIPS,
  CHEST: SPINE,
  UPPER_CHEST: CHEST,
  NECK: UPPER_CHEST,
  HEAD: NECK,
  LEFT_EYE: HEAD,
  RIGHT_EYE: HEAD,
  JAW: HEAD,
  LEFT_UPPER_LEG: HIPS,
  LEFT_LOWER_LEG: LEFT_UPPER_LEG,
  LEFT_FOOT: LEFT_LOWER_LEG,
  LEFT_TOES: LEFT_FOOT,
  RIGHT_UPPER_LEG: HIPS,
  RIGHT_LOWER_LEG: RIGHT_UPPER_LEG,
  RIGHT_FOOT: RIGHT_LOWER_LEG,
  RIGHT_TOES: RIGHT_FOOT,
  LEFT_SHOULDER: UPPER_CHEST,
  LEFT_UPPER_ARM: LEFT_SHOULDER,
  LEFT_LOWER_ARM: LEFT_UPPER_ARM,
  LEFT_HAND: LEFT_LOWER_ARM,
  RIGHT_SHOULDER: UPPER_CHEST,
  RIGHT_UPPER_ARM: RIGHT_SHOULDER,
  RIGHT_LOWER_ARM: RIGHT_UPPER_ARM,
  RIGHT_HAND: RIGHT_LOWER_ARM,
  LEFT_THUMB_METACARPAL: LEFT_HAND,
  LEFT_THUMB_PROXIMAL: LEFT_THUMB_METACARPAL,
  LEFT_THUMB_DISTAL: LEFT_THUMB_PROXIMAL,
  LEFT_INDEX_PROXIMAL: LEFT_HAND,
  LEFT_INDEX_INTERMEDIATE: LEFT_INDEX_PROXIMAL,
  LEFT_INDEX_DISTAL: LEFT_INDEX_INTERMEDIATE,
  LEFT_MIDDLE_PROXIMAL: LEFT_HAND,
  LEFT_MIDDLE_INTERMEDIATE: LEFT_MIDDLE_PROXIMAL,
  LEFT_MIDDLE_DISTAL: LEFT_MIDDLE_INTERMEDIATE,
  LEFT_RING_PROXIMAL: LEFT_HAND,
  LEFT_RING_INTERMEDIATE: LEFT_RING_PROXIMAL,
  LEFT_RING_DISTAL: LEFT_RING_INTERMEDIATE,
  LEFT_LITTLE_PROXIMAL: LEFT_HAND,
  LEFT_LITTLE_INTERMEDIATE: LEFT_LITTLE_PROXIMAL,
  LEFT_LITTLE_DISTAL: LEFT_LITTLE_INTERMEDIATE,
  RIGHT_THUMB_METACARPAL: RIGHT_HAND,
  RIGHT_THUMB_PROXIMAL: RIGHT_THUMB_METACARPAL,
  RIGHT_THUMB_DISTAL: RIGHT_THUMB_PROXIMAL,
  RIGHT_INDEX_PROXIMAL: RIGHT_HAND,
  RIGHT_INDEX_INTERMEDIATE: RIGHT_INDEX_PROXIMAL,
  RIGHT_INDEX_DISTAL: RIGHT_INDEX_INTERMEDIATE,
  RIGHT_MIDDLE_PROXIMAL: RIGHT_HAND,
  RIGHT_MIDDLE_INTERMEDIATE: RIGHT_MIDDLE_PROXIMAL,
  RIGHT_MIDDLE_DISTAL: RIGHT_MIDDLE_INTERMEDIATE,
  RIGHT_RING_PROXIMAL: RIGHT_HAND,
  RIGHT_RING_INTERMEDIATE: RIGHT_RING_PROXIMAL,
  RIGHT_RING_DISTAL: RIGHT_RING_INTERMEDIATE,
  RIGHT_LITTLE_PROXIMAL: RIGHT_HAND,
  RIGHT_LITTLE_INTERMEDIATE: RIGHT_LITTLE_PROXIMAL,
  RIGHT_LITTLE_DISTAL: RIGHT_LITTLE_INTERMEDIATE,
};

class VrmcVrmHumanoidHumanBones extends GltfProperty {
  final Map<String, VrmcVrmHumanoidHumanBone> bones;

  VrmcVrmHumanoidHumanBones._(
      this.bones,
      Map<String, Object> extensions,
      Object extras)
      : super(extensions, extras);

  static VrmcVrmHumanoidHumanBones fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_HUMANOID_HUMAN_BONES_MEMBERS, context);
    }

    final bones = <String, VrmcVrmHumanoidHumanBone>{};

    for (final name in VRMC_VRM_HUMANOID_HUMAN_BONES_MEMBERS) {
      bones[name] = getObjectFromInnerMap(map, name, context,
          VrmcVrmHumanoidHumanBone.fromMap,
          req: VRMC_VRM_HUMANOID_HUMAN_BONES_REQUIRED[name]);
    }

    return VrmcVrmHumanoidHumanBones._(
        bones,
        getExtensions(map, VrmcVrmHumanoid, context),
        getExtras(map, context));
  }

  void testHierarchy(Context context, String name) {
    final boneNode = bones[name]?.node;
    if (boneNode == null) {
      return;
    }

    // traverse for ancestor
    var ancestorName = name;
    VrmcVrmHumanoidHumanBone nearestAncestor;

    do {
      ancestorName = VRMC_VRM_HUMANOID_HUMAN_BONES_PARENT_MAP[ancestorName];

      if (ancestorName == null) {
        // goes this path only when the target bone is hips
        return;
      }

      nearestAncestor = bones[ancestorName];

      if (nearestAncestor != null) {
        break;
      }

      if (VRMC_VRM_HUMANOID_HUMAN_BONES_NEEDS_PARENT[name]) {
        context.addIssue(LinkError.vrmcVrmInvalidHumanoidHierarchy,
            name: name, args: [name, ancestorName]);

        return;
      }

      if (VRMC_VRM_HUMANOID_HUMAN_BONES_REQUIRED[ancestorName]) {
        // Required bone does not exist.
        // An error for required bone should already be emitted,
        // so we just ignore the dependency.
        return;
      }
    } while (nearestAncestor == null);

    final parentNode = nearestAncestor.node;

    // check if the boneNode is a descendant of parentNode
    var current = boneNode;
    while (current != null) {
      current = current.parent;

      if (current == parentNode) {
        return;
      }
    }

    context.addIssue(LinkError.vrmcVrmInvalidHumanoidHierarchy,
        name: name, args: [name, ancestorName]);
  }

  @override
  void link(Gltf gltf, Context context) {
    bones.forEach((name, bone) {
      bone?.link(gltf, context);
      testHierarchy(context, name);
    });
  }
}

const String HUMAN_BONES = 'humanBones';

const List<String> VRMC_VRM_HUMANOID_MEMBERS = <String>[
  HUMAN_BONES,
];

class VrmcVrmHumanoid extends GltfProperty {
  final VrmcVrmHumanoidHumanBones humanBones;

  VrmcVrmHumanoid._(
      this.humanBones, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcVrmHumanoid fromMap(Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_HUMANOID_MEMBERS, context);
    }

    final humanBonesMap = getMap(map, HUMAN_BONES, context, req: true);
    context.path.add(HUMAN_BONES);
    final humanBones =
        VrmcVrmHumanoidHumanBones.fromMap(humanBonesMap, context);
    context.path.removeLast();

    return VrmcVrmHumanoid._(humanBones,
        getExtensions(map, VrmcVrmHumanoid, context), getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    humanBones?.link(gltf, context);
  }
}
