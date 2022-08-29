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
import 'package:gltf/src/ext/VRMC_materials_mtoon/vrmc_materials_mtoon_shading_shift_texture_info.dart';
import 'package:gltf/src/ext/extensions.dart';

// VRMC_materials_mtoon
// https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_materials_mtoon-1.0-beta/schema/VRMC_materials_mtoon.schema.json

const String VRMC_MATERIALS_MTOON = 'VRMC_materials_mtoon';
const String SPEC_VERSION = 'specVersion';
const String TRANSPARENT_WITH_Z_WRITE = 'transparentWithZWrite';
const String RENDER_QUEUE_OFFSET_NUMBER = 'renderQueueOffsetNumber';
const String SHADE_COLOR_FACTOR = 'shadeColorFactor';
const String SHADE_MULTIPLY_TEXTURE = 'shadeMultiplyTexture';
const String SHADING_SHIFT_FACTOR = 'shadingShiftFactor';
const String SHADING_SHIFT_TEXTURE = 'shadingShiftTexture';
const String SHADING_TOONY_FACTOR = 'shadingToonyFactor';
const String GI_EQUALIZATION_FACTOR = 'giEqualizationFactor';
const String MATCAP_FACTOR = 'matcapFactor';
const String MATCAP_TEXTURE = 'matcapTexture';
const String PARAMETRIC_RIM_COLOR_FACTOR = 'parametricRimColorFactor';
const String RIM_MULTIPLY_TEXTURE = 'rimMultiplyTexture';
const String RIM_LIGHTING_MIX_FACTOR = 'rimLightingMixFactor';
const String PARAMETRIC_RIM_FRESNEL_POWER_FACTOR =
    'parametricRimFresnelPowerFactor';
const String PARAMETRIC_RIM_LIFT_FACTOR = 'parametricRimLiftFactor';
const String OUTLINE_WIDTH_MODE = 'outlineWidthMode';
const String OUTLINE_WIDTH_FACTOR = 'outlineWidthFactor';
const String OUTLINE_WIDTH_MULTIPLY_TEXTURE = 'outlineWidthMultiplyTexture';
const String OUTLINE_COLOR_FACTOR = 'outlineColorFactor';
const String OUTLINE_LIGHTING_MIX_FACTOR = 'outlineLightingMixFactor';
const String UV_ANIMATION_MASK_TEXTURE = 'uvAnimationMaskTexture';
const String UV_ANIMATION_SCROLL_X_SPEED_FACTOR =
    'uvAnimationScrollXSpeedFactor';
const String UV_ANIMATION_SCROLL_Y_SPEED_FACTOR =
    'uvAnimationScrollYSpeedFactor';
const String UV_ANIMATION_ROTATION_SPEED_FACTOR =
    'uvAnimationRotationSpeedFactor';

const List<String> VRMC_NODE_CONSTRAINT_MEMBERS = <String>[
  SPEC_VERSION,
  TRANSPARENT_WITH_Z_WRITE,
  RENDER_QUEUE_OFFSET_NUMBER,
  SHADE_COLOR_FACTOR,
  SHADE_MULTIPLY_TEXTURE,
  SHADING_SHIFT_FACTOR,
  SHADING_SHIFT_TEXTURE,
  SHADING_TOONY_FACTOR,
  GI_EQUALIZATION_FACTOR,
  MATCAP_FACTOR,
  MATCAP_TEXTURE,
  PARAMETRIC_RIM_COLOR_FACTOR,
  RIM_MULTIPLY_TEXTURE,
  RIM_LIGHTING_MIX_FACTOR,
  PARAMETRIC_RIM_FRESNEL_POWER_FACTOR,
  PARAMETRIC_RIM_LIFT_FACTOR,
  OUTLINE_WIDTH_MODE,
  OUTLINE_WIDTH_FACTOR,
  OUTLINE_WIDTH_MULTIPLY_TEXTURE,
  OUTLINE_COLOR_FACTOR,
  OUTLINE_LIGHTING_MIX_FACTOR,
  UV_ANIMATION_MASK_TEXTURE,
  UV_ANIMATION_SCROLL_X_SPEED_FACTOR,
  UV_ANIMATION_SCROLL_Y_SPEED_FACTOR,
  UV_ANIMATION_ROTATION_SPEED_FACTOR,
];

const String SPEC_VERSION_10_BETA = '1.0-beta';

const List<String> VRMC_MATERIALS_MTOON_SPEC_VERSIONS = <String>[
  SPEC_VERSION_10_BETA,
];

const String NONE = 'none';
const String WORLD_COORDINATES = 'worldCoordinates';
const String SCREEN_COORDINATES = 'screenCoordinates';

const List<String> VRMC_MATERIALS_MTOON_OUTLINE_WIDTH_MODES = <String>[
  NONE,
  WORLD_COORDINATES,
  SCREEN_COORDINATES,
];

class VrmcMaterialsMtoon extends GltfProperty {
  final String specVersion;
  final bool transparentWithZWrite;
  final int renderQueueOffsetNumber;
  final List<double> shadeColorFactor;
  final TextureInfo shadeMultiplyTexture;
  final double shadingShiftFactor;
  final VrmcMaterialsMtoonShadingShiftTextureInfo shadingShiftTexture;
  final double shadingToonyFactor;
  final double giEqualizationFactor;
  final List<double> matcapFactor;
  final TextureInfo matcapTexture;
  final List<double> parametricRimColorFactor;
  final TextureInfo rimMultiplyTexture;
  final double rimLightingMixFactor;
  final double parametricRimFresnelPowerFactor;
  final double parametricRimLiftFactor;
  final String outlineWidthMode;
  final double outlineWidthFactor;
  final TextureInfo outlineWidthMultiplyTexture;
  final List<double> outlineColorFactor;
  final double outlineLightingMixFactor;
  final TextureInfo uvAnimationMaskTexture;
  final double uvAnimationScrollXSpeedFactor;
  final double uvAnimationScrollYSpeedFactor;
  final double uvAnimationRotationSpeedFactor;

  VrmcMaterialsMtoon._(
      this.specVersion,
      this.transparentWithZWrite,
      this.renderQueueOffsetNumber,
      this.shadeColorFactor,
      this.shadeMultiplyTexture,
      this.shadingShiftFactor,
      this.shadingShiftTexture,
      this.shadingToonyFactor,
      this.giEqualizationFactor,
      this.matcapFactor,
      this.matcapTexture,
      this.parametricRimColorFactor,
      this.rimMultiplyTexture,
      this.rimLightingMixFactor,
      this.parametricRimFresnelPowerFactor,
      this.parametricRimLiftFactor,
      this.outlineWidthMode,
      this.outlineWidthFactor,
      this.outlineWidthMultiplyTexture,
      this.outlineColorFactor,
      this.outlineLightingMixFactor,
      this.uvAnimationMaskTexture,
      this.uvAnimationScrollXSpeedFactor,
      this.uvAnimationScrollYSpeedFactor,
      this.uvAnimationRotationSpeedFactor,
      Map<String, Object> extensions,
      Object extras)
      : super(extensions, extras);

  static VrmcMaterialsMtoon fromMap(Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_NODE_CONSTRAINT_MEMBERS, context);
    }

    final specVersion = getString(map, SPEC_VERSION, context,
        list: VRMC_MATERIALS_MTOON_SPEC_VERSIONS, req: true);

    return VrmcMaterialsMtoon._(
        specVersion,
        getBool(map, TRANSPARENT_WITH_Z_WRITE, context),
        getInt(map, RENDER_QUEUE_OFFSET_NUMBER, context,
            min: -9, max: 9, def: 0, req: false),
        getFloatList(map, SHADE_COLOR_FACTOR, context,
            lengthsList: const [3], def: const [1, 1, 1]),
        getObjectFromInnerMap(
            map, SHADE_MULTIPLY_TEXTURE, context, TextureInfo.fromMap),
        getFloat(map, SHADING_SHIFT_FACTOR, context),
        getObjectFromInnerMap(map, SHADING_SHIFT_TEXTURE, context,
            VrmcMaterialsMtoonShadingShiftTextureInfo.fromMap),
        getFloat(map, SHADING_TOONY_FACTOR, context),
        getFloat(map, GI_EQUALIZATION_FACTOR, context),
        getFloatList(map, MATCAP_FACTOR, context,
            lengthsList: const [3], def: const [1, 1, 1]),
        getObjectFromInnerMap(
            map, MATCAP_TEXTURE, context, TextureInfo.fromMap),
        getFloatList(map, PARAMETRIC_RIM_COLOR_FACTOR, context,
            lengthsList: const [3], def: const [1, 1, 1]),
        getObjectFromInnerMap(
            map, RIM_MULTIPLY_TEXTURE, context, TextureInfo.fromMap),
        getFloat(map, RIM_LIGHTING_MIX_FACTOR, context),
        getFloat(map, PARAMETRIC_RIM_FRESNEL_POWER_FACTOR, context),
        getFloat(map, PARAMETRIC_RIM_LIFT_FACTOR, context),
        getString(map, OUTLINE_WIDTH_MODE, context,
            def: NONE, list: VRMC_MATERIALS_MTOON_OUTLINE_WIDTH_MODES),
        getFloat(map, OUTLINE_WIDTH_FACTOR, context),
        getObjectFromInnerMap(
            map, OUTLINE_WIDTH_MULTIPLY_TEXTURE, context, TextureInfo.fromMap),
        getFloatList(map, OUTLINE_COLOR_FACTOR, context,
            lengthsList: const [3], def: const [1, 1, 1]),
        getFloat(map, OUTLINE_LIGHTING_MIX_FACTOR, context),
        getObjectFromInnerMap(
            map, UV_ANIMATION_MASK_TEXTURE, context, TextureInfo.fromMap),
        getFloat(map, UV_ANIMATION_SCROLL_X_SPEED_FACTOR, context),
        getFloat(map, UV_ANIMATION_SCROLL_Y_SPEED_FACTOR, context),
        getFloat(map, UV_ANIMATION_ROTATION_SPEED_FACTOR, context),
        getExtensions(map, VrmcMaterialsMtoon, context),
        getExtras(map, context));
  }

  void validateRenderQueueOffset(Gltf gltf, Context context) {
    if (!context.validate) {
      return;
    }

    context.path.add(RENDER_QUEUE_OFFSET_NUMBER);

    if (renderQueueOffsetNumber == 0) {
      // 0 is always valid
      return;
    }

    // now the alphaMode must be BLEND
    // since the renderQueueOffsetNumber is not 0

    Object o = this;
    while (o != null) {
      o = context.owners[o];
      if (o is Material) {
        if (o.alphaMode != BLEND) {
          context.addIssue(LinkError.vrmcMaterialsMtoonInvalidRenderQueueOffset,
              args: [renderQueueOffsetNumber, ALPHA_MODE, o.alphaMode]);
        } else if ((transparentWithZWrite && renderQueueOffsetNumber < 0) ||
            (!transparentWithZWrite && renderQueueOffsetNumber > 0)) {
          context.addIssue(LinkError.vrmcMaterialsMtoonInvalidRenderQueueOffset,
              args: [
                renderQueueOffsetNumber,
                TRANSPARENT_WITH_Z_WRITE,
                transparentWithZWrite
              ]);
        }

        break;
      }
    }

    context.path.removeLast();
  }

  @override
  void link(Gltf gltf, Context context) {
    validateRenderQueueOffset(gltf, context);

    context.path.add(SHADE_MULTIPLY_TEXTURE);
    shadeMultiplyTexture?.link(gltf, context);
    context.path.removeLast();

    context.path.add(SHADING_SHIFT_TEXTURE);
    shadingShiftTexture?.link(gltf, context);
    context.path.removeLast();

    context.path.add(MATCAP_TEXTURE);
    matcapTexture?.link(gltf, context);
    context.path.removeLast();

    context.path.add(RIM_MULTIPLY_TEXTURE);
    rimMultiplyTexture?.link(gltf, context);
    context.path.removeLast();

    context.path.add(OUTLINE_WIDTH_MULTIPLY_TEXTURE);
    outlineWidthMultiplyTexture?.link(gltf, context);
    context.path.removeLast();

    context.path.add(UV_ANIMATION_MASK_TEXTURE);
    uvAnimationMaskTexture?.link(gltf, context);
    context.path.removeLast();
  }
}

const Extension vrmcMaterialsMtoonExtension =
    Extension(VRMC_MATERIALS_MTOON, <Type, ExtensionDescriptor>{
  Material: ExtensionDescriptor(VrmcMaterialsMtoon.fromMap),
});
