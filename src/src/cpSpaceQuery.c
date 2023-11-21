/* Copyright (c) 2013 Scott Lembcke and Howling Moon Software
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

#include "chipmunk/chipmunk_private.h"

//MARK: Nearest Point Query Functions

struct PointQueryContext {
	cpVect point;
	cpFloat maxDistance;
	cpShapeFilter filter;
	cpSpacePointQueryFuncD func;
	uint64_t callbackId;
};

static cpCollisionID
NearestPointQuery(struct PointQueryContext *context, cpShape *shape, cpCollisionID id, void *data)
{
	if(
		!cpShapeFilterReject(shape->filter, context->filter)
	){
		cpPointQueryInfo info;
		cpShapePointQuery(shape, context->point, &info);
		
		if(info.shape && info.distance < context->maxDistance) context->func(shape, info.point, info.distance, info.gradient, data, context->callbackId);
	}
	
	return id;
}

// DART CALLBACK

void
cpSpacePointQuery(cpSpace *space, cpVect point, cpFloat maxDistance, cpShapeFilter filter, cpSpacePointQueryFuncD func, void *data, uint64_t callbackId)
{
	struct PointQueryContext context = {point, maxDistance, filter, func, callbackId};
	cpBB bb = cpBBNewForCircle(point, cpfmax(maxDistance, 0.0f));
	
	cpSpaceLock(space); {
		cpSpatialIndexQuery(space->dynamicShapes, &context, bb, (cpSpatialIndexQueryFunc)NearestPointQuery, data);
		cpSpatialIndexQuery(space->staticShapes, &context, bb, (cpSpatialIndexQueryFunc)NearestPointQuery, data);
	} cpSpaceUnlock(space, cpTrue);
}

static cpCollisionID
NearestPointQueryNearest(struct PointQueryContext *context, cpShape *shape, cpCollisionID id, cpPointQueryInfo *out)
{
	if(
		!cpShapeFilterReject(shape->filter, context->filter) && !shape->sensor
	){
		cpPointQueryInfo info;
		cpShapePointQuery(shape, context->point, &info);
		
		if(info.distance < out->distance) (*out) = info;
	}
	
	return id;
}

cpShape *
cpSpacePointQueryNearest(cpSpace *space, cpVect point, cpFloat maxDistance, cpShapeFilter filter, cpPointQueryInfo *out)
{
	cpPointQueryInfo info = {NULL, cpvzero, maxDistance, cpvzero};
	if(out){
		(*out) = info;
  } else {
		out = &info;
	}
	
	struct PointQueryContext context = {
		point, maxDistance,
		filter,
		NULL
	};
	
	cpBB bb = cpBBNewForCircle(point, cpfmax(maxDistance, 0.0f));
	cpSpatialIndexQuery(space->dynamicShapes, &context, bb, (cpSpatialIndexQueryFunc)NearestPointQueryNearest, out);
	cpSpatialIndexQuery(space->staticShapes, &context, bb, (cpSpatialIndexQueryFunc)NearestPointQueryNearest, out);
	
	return (cpShape *)out->shape;
}


//MARK: Segment Query Functions

struct SegmentQueryContext {
	cpVect start, end;
	cpFloat radius;
	cpShapeFilter filter;
	cpSpaceSegmentQueryFuncD func;
	uint64_t callbackId;
};

static cpFloat
SegmentQuery(struct SegmentQueryContext *context, cpShape *shape, void *data)
{
	cpSegmentQueryInfo info;
	
	if(
		!cpShapeFilterReject(shape->filter, context->filter) &&
		cpShapeSegmentQuery(shape, context->start, context->end, context->radius, &info)
	){
		context->func(shape, info.point, info.normal, info.alpha, data, context->callbackId);
	}
	
	return 1.0f;
}

// DART CALLBACK
void
cpSpaceSegmentQuery(cpSpace *space, cpVect start, cpVect end, cpFloat radius, cpShapeFilter filter, cpSpaceSegmentQueryFuncD func, void *data, uint64_t callbackId)
{
	struct SegmentQueryContext context = {
		start, end,
		radius,
		filter,
		func,
		callbackId,
	};
	
	cpSpaceLock(space); {
    cpSpatialIndexSegmentQuery(space->staticShapes, &context, start, end, 1.0f, (cpSpatialIndexSegmentQueryFunc)SegmentQuery, data);
    cpSpatialIndexSegmentQuery(space->dynamicShapes, &context, start, end, 1.0f, (cpSpatialIndexSegmentQueryFunc)SegmentQuery, data);
	} cpSpaceUnlock(space, cpTrue);
}

static cpFloat
SegmentQueryFirst(struct SegmentQueryContext *context, cpShape *shape, cpSegmentQueryInfo *out)
{
	cpSegmentQueryInfo info;
	
	if(
		!cpShapeFilterReject(shape->filter, context->filter) && !shape->sensor &&
		cpShapeSegmentQuery(shape, context->start, context->end, context->radius, &info) &&
		info.alpha < out->alpha
	){
		(*out) = info;
	}
	
	return out->alpha;
}

cpShape *
cpSpaceSegmentQueryFirst(cpSpace *space, cpVect start, cpVect end, cpFloat radius, cpShapeFilter filter, cpSegmentQueryInfo *out)
{
	cpSegmentQueryInfo info = {NULL, end, cpvzero, 1.0f};
	if(out){
		(*out) = info;
  } else {
		out = &info;
	}
	
	struct SegmentQueryContext context = {
		start, end,
		radius,
		filter,
		NULL
	};
	
	cpSpatialIndexSegmentQuery(space->staticShapes, &context, start, end, 1.0f, (cpSpatialIndexSegmentQueryFunc)SegmentQueryFirst, out);
	cpSpatialIndexSegmentQuery(space->dynamicShapes, &context, start, end, out->alpha, (cpSpatialIndexSegmentQueryFunc)SegmentQueryFirst, out);
	
	return (cpShape *)out->shape;
}

//MARK: BB Query Functions

struct BBQueryContext {
	cpBB bb;
	cpShapeFilter filter;
	cpSpaceBBQueryFuncD func;
	uint64_t callbackId;
};

static cpCollisionID
BBQuery(struct BBQueryContext *context, cpShape *shape, cpCollisionID id, void *data)
{
	if(
		!cpShapeFilterReject(shape->filter, context->filter) &&
		cpBBIntersects(context->bb, shape->bb)
	){
		context->func(shape, data, context->callbackId);
	}
	
	return id;
}

// DART CALLBACK
void
cpSpaceBBQuery(cpSpace *space, cpBB bb, cpShapeFilter filter, cpSpaceBBQueryFuncD func, void *data, uint64_t callbackId)
{
	struct BBQueryContext context = {bb, filter, func, callbackId};
	
	cpSpaceLock(space); {
    cpSpatialIndexQuery(space->dynamicShapes, &context, bb, (cpSpatialIndexQueryFunc)BBQuery, data);
    cpSpatialIndexQuery(space->staticShapes, &context, bb, (cpSpatialIndexQueryFunc)BBQuery, data);
	} cpSpaceUnlock(space, cpTrue);
}

//MARK: Shape Query Functions

struct ShapeQueryContext {
	cpSpaceShapeQueryFuncD func;
	void *data;
	cpBool anyCollision;
	uint64_t callbackId;
};

// Callback from the spatial hash.
static cpCollisionID
ShapeQuery(cpShape *a, cpShape *b, cpCollisionID id, struct ShapeQueryContext *context)
{
	if(cpShapeFilterReject(a->filter, b->filter) || a == b) return id;
	
	cpContactPointSet set = cpShapesCollide(a, b);
	if(set.count){
		if(context->func) context->func(b, &set, context->data, context->callbackId);
		context->anyCollision = !(a->sensor || b->sensor);
	}
	
	return id;
}

// DART CALLBACK

cpBool
cpSpaceShapeQuery(cpSpace *space, cpShape *shape, cpSpaceShapeQueryFuncD func, void *data, uint64_t callbackId)
{
	cpBody *body = shape->body;
	cpBB bb = (body ? cpShapeUpdate(shape, body->transform) : shape->bb);
	struct ShapeQueryContext context = {func, data, cpFalse};
	
	cpSpaceLock(space); {
    cpSpatialIndexQuery(space->dynamicShapes, shape, bb, (cpSpatialIndexQueryFunc)ShapeQuery, &context);
    cpSpatialIndexQuery(space->staticShapes, shape, bb, (cpSpatialIndexQueryFunc)ShapeQuery, &context);
	} cpSpaceUnlock(space, cpTrue);
	
	return context.anyCollision;
}
