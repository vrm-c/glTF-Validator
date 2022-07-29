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
import 'package:gltf/src/ext/VRMC_vrm/vrmc_vrm_humanoid.dart';
import 'package:gltf/src/ext/VRMC_vrm/vrmc_vrm_meta.dart';
import 'package:gltf/src/ext/extensions.dart';

const String VRMC_VRM = 'VRMC_vrm';
const String SPEC_VERSION = 'specVersion';
const String META = 'meta';
const String HUMANOID = 'humanoid';

const List<String> VRMC_VRM_MEMBERS = <String>[
  SPEC_VERSION,
  META,
  HUMANOID,
];

const String SPEC_VERSION_10_BETA = '1.0-beta';

const List<String> VRMC_VRM_SPEC_VERSIONS = <String>[
  SPEC_VERSION_10_BETA,
];

class VrmcVrm extends GltfProperty {
  final String specVersion;
  final VrmcVrmMeta meta;
  final VrmcVrmHumanoid humanoid;

  VrmcVrm._(this.specVersion, this.meta, this.humanoid,
      Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcVrm fromMap(Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_MEMBERS, context);
    }

    final specVersion = getString(map, SPEC_VERSION, context,
        list: VRMC_VRM_SPEC_VERSIONS, req: true);

    return VrmcVrm._(
        specVersion,
        getObjectFromInnerMap(map, META, context, VrmcVrmMeta.fromMap,
            req: true),
        getObjectFromInnerMap(map, HUMANOID, context, VrmcVrmHumanoid.fromMap,
            req: true),
        getExtensions(map, VrmcVrm, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    meta?.link(gltf, context);
    humanoid?.link(gltf, context);
  }
}

const Extension vrmcVrmExtension =
    Extension(VRMC_VRM, <Type, ExtensionDescriptor>{
  Gltf: ExtensionDescriptor(VrmcVrm.fromMap),
});
