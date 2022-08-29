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

library gltf.extensions.vrmc_materials_mtoon;

import 'package:gltf/src/base/gltf_property.dart';

// shading shift texture info
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_materials_mtoon-1.0-beta/schema/mtoon.shadingShiftTexture.schema.json

const String SCALE = 'scale';

const List<String> VRMC_MATERIALS_MTOON_SHADING_SHIFT_TEXTURE_INFO_MEMBERS =
    <String>[
  INDEX,
  TEX_COORD,
  SCALE,
];

// I have tried to extend TextureInfo but I couldn't,
// It says that TextureInfo does not have a constructor named `_`.

class VrmcMaterialsMtoonShadingShiftTextureInfo extends GltfProperty {
  final int index;
  final int texCoord;
  final double scale;

  Texture texture;

  VrmcMaterialsMtoonShadingShiftTextureInfo._(this.index, this.texCoord,
      this.scale, Map<String, Object> extensions, Object extras)
      : super(extensions, extras);

  static VrmcMaterialsMtoonShadingShiftTextureInfo fromMap(
      Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_MATERIALS_MTOON_SHADING_SHIFT_TEXTURE_INFO_MEMBERS,
          context);
    }

    final extensions = getExtensions(
        map, VrmcMaterialsMtoonShadingShiftTextureInfo, context,
        overriddenType: Material);

    final shadingShiftTextureInfo = VrmcMaterialsMtoonShadingShiftTextureInfo._(
        getIndex(map, INDEX, context),
        getUint(map, TEX_COORD, context, def: 0),
        getFloat(map, SCALE, context, def: 1),
        extensions,
        getExtras(map, context));

    context.registerObjectsOwner(shadingShiftTextureInfo, extensions.values);

    return shadingShiftTextureInfo;
  }

  @override
  void link(Gltf gltf, Context context) {
    texture = gltf.textures[index];

    if (context.validate && index != -1) {
      if (texture == null) {
        context.addIssue(LinkError.unresolvedReference,
            name: INDEX, args: [index]);
      } else {
        texture.markAsUsed();
      }
    }

    Object o = this;
    while (o != null) {
      o = context.owners[o];
      if (o is Material) {
        o.texCoordIndices[context.getPointerString()] = texCoord;
        break;
      }
    }
  }
}
