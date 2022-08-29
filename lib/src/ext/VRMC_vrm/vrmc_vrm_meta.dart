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

library gltf.extensions.vrmc_vrm_meta;

import 'package:gltf/src/base/gltf_property.dart';

const String NAME = 'name';
const String VERSION = 'version';
const String AUTHORS = 'authors';
const String COPYRIGHT_INFORMATION = 'copyrightInformation';
const String CONTACT_INFORMATION = 'contactInformation';
const String REFERENCES = 'references';
const String THIRD_PARTY_LICENSES = 'thirdPartyLicenses';
const String THUMBNAIL_IMAGE = 'thumbnailImage';
const String LICENSE_URL = 'licenseUrl';
const String AVATAR_PERMISSION = 'avatarPermission';
const String ALLOW_EXCESSIVELY_VIOLENT_USAGE = 'allowExcessivelyViolentUsage';
const String ALLOW_EXCESSIVELY_SEXUAL_USAGE = 'allowExcessivelySexualUsage';
const String ALLOW_POLITICAL_OR_RELIGIOUS_USAGE =
    'allowPoliticalOrReligiousUsage';
const String ALLOW_ANTISOCIAL_OR_HATE_USAGE = 'allowAntisocialOrHateUsage';
const String COMMERCIAL_USAGE = 'commercialUsage';
const String CREDIT_NOTATION = 'creditNotation';
const String ALLOW_REDISTRIBUTION = 'allowRedistribution';
const String MODIFICATION = 'modification';
const String OTHER_LICENSE_URL = 'otherLicenseUrl';

const List<String> VRMC_VRM_META_MEMBERS = <String>[
  NAME,
  VERSION,
  AUTHORS,
  COPYRIGHT_INFORMATION,
  CONTACT_INFORMATION,
  REFERENCES,
  THIRD_PARTY_LICENSES,
  THUMBNAIL_IMAGE,
  LICENSE_URL,
  AVATAR_PERMISSION,
  ALLOW_EXCESSIVELY_VIOLENT_USAGE,
  ALLOW_EXCESSIVELY_SEXUAL_USAGE,
  COMMERCIAL_USAGE,
  ALLOW_POLITICAL_OR_RELIGIOUS_USAGE,
  ALLOW_ANTISOCIAL_OR_HATE_USAGE,
  CREDIT_NOTATION,
  ALLOW_REDISTRIBUTION,
  MODIFICATION,
  OTHER_LICENSE_URL,
];

const String VRM_LICENSE_URL_10 = 'https://vrm.dev/licenses/1.0/';

const List<String> VRMC_VRM_META_LICENSE_URLS = <String>[
  VRM_LICENSE_URL_10,
];

const String ONLY_AUTHOR = 'onlyAuthor';
const String ONLY_SEPARATELY_LICENSED_PERSON = 'onlySeparatelyLicensedPerson';
const String EVERYONE = 'everyone';

const List<String> VRMC_VRM_META_AVATAR_PERMISSIONS = <String>[
  ONLY_AUTHOR,
  ONLY_SEPARATELY_LICENSED_PERSON,
  EVERYONE,
];

const String PERSONAL_NON_PROFIT = 'personalNonProfit';
const String PERSONAL_PROFIT = 'personalProfit';
const String CORPORATION = 'corporation';

const List<String> VRMC_VRM_META_COMMERCIAL_USAGES = <String>[
  PERSONAL_NON_PROFIT,
  PERSONAL_PROFIT,
  CORPORATION,
];

const String REQUIRED = 'required';
const String UNNECESSARY = 'unnecessary';

const List<String> VRMC_VRM_META_CREDIT_NOTATIONS = <String>[
  REQUIRED,
  UNNECESSARY,
];

const String PROHIBITED = 'prohibited';
const String ALLOW_MODIFICATION = 'allowModification';
const String ALLOW_MODIFICATION_REDISTRIBUTION =
    'allowModificationRedistribution';

const List<String> VRMC_VRM_META_MODIFICATIONS = <String>[
  PROHIBITED,
  ALLOW_MODIFICATION,
  ALLOW_MODIFICATION_REDISTRIBUTION,
];

class VrmcVrmMeta extends GltfProperty implements ResourceValidatable {
  final String name;
  final String version;
  final List<String> authors;
  final String copyrightInformation;
  final String contactInformation;
  final List<String> references;
  final String thirdPartyLicenses;
  final int thumbnailImageIndex;
  final String licenseUrl;
  final String avatarPermission;
  final bool allowExcessivelyViolentUsage;
  final bool allowExcessivelySexualUsage;
  final String commercialUsage;
  final bool allowPoliticalOrReligiousUsage;
  final bool allowAntisocialOrHateUsage;
  final String creditNotation;
  final bool allowRedistribution;
  final String modification;
  final String otherLicenseUrl;

  Image thumbnailImage;

  VrmcVrmMeta._(
      this.name,
      this.version,
      this.authors,
      this.copyrightInformation,
      this.contactInformation,
      this.references,
      this.thirdPartyLicenses,
      this.thumbnailImageIndex,
      this.licenseUrl,
      this.avatarPermission,
      this.allowExcessivelyViolentUsage,
      this.allowExcessivelySexualUsage,
      this.commercialUsage,
      this.allowPoliticalOrReligiousUsage,
      this.allowAntisocialOrHateUsage,
      this.creditNotation,
      this.allowRedistribution,
      this.modification,
      this.otherLicenseUrl,
      Map<String, Object> extensions,
      Object extras)
      : super(extensions, extras);

  static VrmcVrmMeta fromMap(Map<String, Object> map, Context context) {
    if (context.validate) {
      checkMembers(map, VRMC_VRM_META_MEMBERS, context);
    }

    // length of authors must be 1 at least
    // https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/meta.md#metaauthors-
    final authors = getStringList(map, AUTHORS, context);
    if (authors == null || authors.isEmpty) {
      context.addIssue(SchemaError.undefinedProperty,
          name: AUTHORS, args: [AUTHORS]);
    }

    return VrmcVrmMeta._(
        getString(map, NAME, context, req: true),
        getString(map, VERSION, context, req: false),
        authors,
        getString(map, COPYRIGHT_INFORMATION, context, req: false),
        getString(map, CONTACT_INFORMATION, context, req: false),
        getStringList(map, REFERENCES, context),
        getString(map, THIRD_PARTY_LICENSES, context, req: false),
        getIndex(map, THUMBNAIL_IMAGE, context, req: false),
        getString(map, LICENSE_URL, context,
            list: VRMC_VRM_META_LICENSE_URLS, req: true),
        getString(map, AVATAR_PERMISSION, context,
            list: VRMC_VRM_META_AVATAR_PERMISSIONS, req: false),
        getBool(map, ALLOW_EXCESSIVELY_VIOLENT_USAGE, context),
        getBool(map, ALLOW_EXCESSIVELY_SEXUAL_USAGE, context),
        getString(map, COMMERCIAL_USAGE, context,
            list: VRMC_VRM_META_COMMERCIAL_USAGES, req: false),
        getBool(map, ALLOW_POLITICAL_OR_RELIGIOUS_USAGE, context),
        getBool(map, ALLOW_ANTISOCIAL_OR_HATE_USAGE, context),
        getString(map, CREDIT_NOTATION, context,
            list: VRMC_VRM_META_CREDIT_NOTATIONS, req: false),
        getBool(map, ALLOW_REDISTRIBUTION, context),
        getString(map, MODIFICATION, context,
            list: VRMC_VRM_META_MODIFICATIONS, req: false),
        getString(map, OTHER_LICENSE_URL, context, req: false),
        getExtensions(map, VrmcVrmMeta, context),
        getExtras(map, context));
  }

  @override
  void link(Gltf gltf, Context context) {
    thumbnailImage = gltf.images[thumbnailImageIndex];
    if (context.validate && thumbnailImageIndex != -1) {
      if (thumbnailImage == null) {
        context.addIssue(LinkError.unresolvedReference,
            name: THUMBNAIL_IMAGE, args: [thumbnailImageIndex]);
      } else {
        thumbnailImage.markAsUsed();
      }
    }
  }

  @override
  void validateResources(Gltf gltf, Context context) {
    // mimetype of thumbnail image, it must be either png or jpeg
    // See: https://github.com/vrm-c/vrm-specification/blob/master/specification/VRMC_vrm-1.0-beta/meta.md#metathumbnailimage
    final mimeType = thumbnailImage?.mimeType ?? thumbnailImage?.info?.mimeType;
    if (mimeType != null &&
        !(mimeType != IMAGE_JPEG || mimeType == IMAGE_PNG)) {
      context.addIssue(LinkError.textureInvalidImageMimeType,
          name: THUMBNAIL_IMAGE,
          args: [
            mimeType,
            const [IMAGE_JPEG, IMAGE_PNG]
          ]);
    }
  }
}
