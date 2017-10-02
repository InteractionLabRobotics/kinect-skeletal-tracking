/*******************************************************************************
*                                                                              *
*   PrimeSense NITE 1.3 - Players Sample                                       *
*   Copyright (C) 2010 PrimeSense Ltd.                                         *
*                                                                              *
*******************************************************************************/

#ifndef XNV_POINT_DRAWER_H_
#define XNV_POINT_DRAWER_H_

#include <XnCppWrapper.h>
#include <string>

void DrawDepthMap(const xn::DepthMetaData& dmd, const xn::SceneMetaData& smd, XnUserID player);

void DrawSkeleton(XnUserID player, float depth, std::string& label);

#endif
