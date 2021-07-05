#version 310 es

// SPDX-License-Identifier: Unlicense OR MIT

#extension GL_GOOGLE_include_directive : enable

precision highp float;

#include "common.h"

layout(binding = 0) uniform Block {
	vec4 transform;
	vec4 uvTransformR1;
	vec4 uvTransformR2;
	float z;
} _block;

layout(location = 0) in vec2 pos;

layout(location = 1) in vec2 uv;

layout(location = 0) out vec2 vUV;

void main() {
	vec2 p = pos*_block.transform.xy + _block.transform.zw;
	gl_Position = toClipSpace(vec4(p, _block.z, 1));
	vUV = transform3x2(m3x2(_block.uvTransformR1.xyz, _block.uvTransformR2.xyz), vec3(uv,1)).xy;
}
