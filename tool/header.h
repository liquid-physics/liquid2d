#include <stdint.h>
typedef double cpFloat;
typedef struct cpVect
{
    cpFloat x, y;
} cpVect;
typedef unsigned int cpTimestamp;
typedef void *cpDataPointer;
typedef struct cpArray cpArray;
typedef uintptr_t cpHashValue;
typedef unsigned char cpBool;
typedef uint32_t cpCollisionID;
typedef uintptr_t cpCollisionType;
typedef uintptr_t cpGroup;
typedef unsigned int cpBitmask;

typedef struct cpTransform
{
    cpFloat a, b, c, d, tx, ty;
} cpTransform;

typedef struct cpBB
{
    cpFloat l, b, r, t;
} cpBB;

struct cpArray
{
    int num, max;
    void **arr;
};

// typedef struct cpSpatialIndexClass cpSpatialIndexClass;
// typedef struct cpSpatialIndex cpSpatialIndex;
// typedef struct cpCollisionID cpCollisionID;
// typedef struct cpSpatialIndexIteratorFunc cpSpatialIndexIteratorFunc;
// typedef struct cpSpatialIndexBBFunc cpSpatialIndexBBFunc;

// typedef struct cpBB{
// 	cpFloat l, b, r ,t;
// } cpBB;

// typedef cpBB (*cpSpatialIndexBBFunc)(void *obj);
// typedef cpCollisionID (*cpSpatialIndexQueryFunc)(void *obj1, void *obj2, cpCollisionID id, void *data);
// typedef cpFloat (*cpSpatialIndexSegmentQueryFunc)(void *obj1, void *obj2, void *data);
// typedef cpBool (*cpSpatialIndexContainsImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);
// typedef struct cpContactBufferHeader cpContactBufferHeader;

// typedef void (*cpSpatialIndexDestroyImpl)(cpSpatialIndex *index);

// typedef int (*cpSpatialIndexCountImpl)(cpSpatialIndex *index);
// typedef void (*cpSpatialIndexEachImpl)(cpSpatialIndex *index, cpSpatialIndexIteratorFunc func, void *data);

// typedef cpBool (*cpSpatialIndexContainsImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);
// typedef void (*cpSpatialIndexInsertImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);
// typedef void (*cpSpatialIndexRemoveImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);

// typedef void (*cpSpatialIndexReindexImpl)(cpSpatialIndex *index);
// typedef void (*cpSpatialIndexReindexObjectImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);
// typedef void (*cpSpatialIndexReindexQueryImpl)(cpSpatialIndex *index, cpSpatialIndexQueryFunc func, void *data);

// typedef void (*cpSpatialIndexQueryImpl)(cpSpatialIndex *index, void *obj, cpBB bb, cpSpatialIndexQueryFunc func, void *data);
// typedef void (*cpSpatialIndexSegmentQueryImpl)(cpSpatialIndex *index, void *obj, cpVect a, cpVect b, cpFloat t_exit, cpSpatialIndexSegmentQueryFunc func, void *data);
typedef struct cpSpatialIndex cpSpatialIndex;
typedef void (*cpSpatialIndexIteratorFunc)(void *obj, void *data);
typedef struct cpSpatialIndexClass cpSpatialIndexClass;
typedef void (*cpSpatialIndexDestroyImpl)(cpSpatialIndex *index);
typedef int (*cpSpatialIndexCountImpl)(cpSpatialIndex *index);
typedef void (*cpSpatialIndexEachImpl)(cpSpatialIndex *index, cpSpatialIndexIteratorFunc func, void *data);
typedef cpBool (*cpSpatialIndexContainsImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);
typedef void (*cpSpatialIndexInsertImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);
typedef void (*cpSpatialIndexRemoveImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);
typedef void (*cpSpatialIndexReindexImpl)(cpSpatialIndex *index);
typedef void (*cpSpatialIndexReindexObjectImpl)(cpSpatialIndex *index, void *obj, cpHashValue hashid);
typedef cpCollisionID (*cpSpatialIndexQueryFunc)(void *obj1, void *obj2, cpCollisionID id, void *data);
typedef void (*cpSpatialIndexReindexQueryImpl)(cpSpatialIndex *index, cpSpatialIndexQueryFunc func, void *data);
typedef void (*cpSpatialIndexQueryImpl)(cpSpatialIndex *index, void *obj, cpBB bb, cpSpatialIndexQueryFunc func, void *data);
typedef cpFloat (*cpSpatialIndexSegmentQueryFunc)(void *obj1, void *obj2, void *data);
typedef void (*cpSpatialIndexSegmentQueryImpl)(cpSpatialIndex *index, void *obj, cpVect a, cpVect b, cpFloat t_exit, cpSpatialIndexSegmentQueryFunc func, void *data);
struct cpSpatialIndexClass
{
    cpSpatialIndexDestroyImpl destroy;
    cpSpatialIndexCountImpl count;
    cpSpatialIndexEachImpl each;

    cpSpatialIndexContainsImpl contains;
    cpSpatialIndexInsertImpl insert;
    cpSpatialIndexRemoveImpl remove;

    cpSpatialIndexReindexImpl reindex;
    cpSpatialIndexReindexObjectImpl reindexObject;
    cpSpatialIndexReindexQueryImpl reindexQuery;

    cpSpatialIndexQueryImpl query;
    cpSpatialIndexSegmentQueryImpl segmentQuery;
};

typedef cpBB (*cpSpatialIndexBBFunc)(void *obj);

struct cpSpatialIndex
{
    cpSpatialIndexClass *klass;

    cpSpatialIndexBBFunc bbfunc;

    cpSpatialIndex *staticIndex, *dynamicIndex;
};
typedef struct cpContactBufferHeader cpContactBufferHeader;
typedef struct cpHashSet cpHashSet;
typedef struct cpCollisionHandler cpCollisionHandler;

typedef struct cpSpace cpSpace;
typedef struct cpArbiter cpArbiter;

struct cpArbiterThread
{
    struct cpArbiter *next, *prev;
};
enum cpArbiterState
{
    // Arbiter is active and its the first collision.
    CP_ARBITER_STATE_FIRST_COLLISION,
    // Arbiter is active and its not the first collision.
    CP_ARBITER_STATE_NORMAL,
    // Collision has been explicitly ignored.
    // Either by returning false from a begin collision handler or calling cpArbiterIgnore().
    CP_ARBITER_STATE_IGNORE,
    // Collison is no longer active. A space will cache an arbiter for up to cpSpace.collisionPersistence more steps.
    CP_ARBITER_STATE_CACHED,
    // Collison arbiter is invalid because one of the shapes was removed.
    CP_ARBITER_STATE_INVALIDATED,
};

/// Fast collision filtering type that is used to determine if two objects collide before calling collision or query callbacks.
typedef struct cpShapeFilter
{
    /// Two objects with the same non-zero group value do not collide.
    /// This is generally used to group objects in a composite object together to disable self collisions.
    cpGroup group;
    /// A bitmask of user definable categories that this object belongs to.
    /// The category/mask combinations of both objects in a collision must agree for a collision to occur.
    cpBitmask categories;
    /// A bitmask of user definable category types that this object object collides with.
    /// The category/mask combinations of both objects in a collision must agree for a collision to occur.
    cpBitmask mask;
} cpShapeFilter;

typedef struct cpShape cpShape;


/// Point query info struct.
typedef struct cpPointQueryInfo {
	/// The nearest shape, NULL if no shape was within range.
	const cpShape *shape;
	/// The closest point on the shape's surface. (in world space coordinates)
	cpVect point;
	/// The distance to the point. The distance is negative if the point is inside the shape.
	cpFloat distance;
	/// The gradient of the signed distance function.
	/// The value should be similar to info.p/info.d, but accurate even for very small values of info.d.
	cpVect gradient;
} cpPointQueryInfo;


/// Segment query info struct.
typedef struct cpSegmentQueryInfo {
	/// The shape that was hit, or NULL if no collision occured.
	const cpShape *shape;
	/// The point of impact.
	cpVect point;
	/// The normal of the surface hit.
	cpVect normal;
	/// The normalized distance along the query segment in the range [0, 1].
	cpFloat alpha;
} cpSegmentQueryInfo;

typedef cpBB (*cpShapeCacheDataImpl)(cpShape *shape, cpTransform transform);
typedef void (*cpShapeDestroyImpl)(cpShape *shape);
typedef void (*cpShapePointQueryImpl)(const cpShape *shape, cpVect p, cpPointQueryInfo *info);
typedef void (*cpShapeSegmentQueryImpl)(const cpShape *shape, cpVect a, cpVect b, cpFloat radius, cpSegmentQueryInfo *info);

typedef struct cpShapeClass cpShapeClass;

typedef enum cpShapeType{
	CP_CIRCLE_SHAPE,
	CP_SEGMENT_SHAPE,
	CP_POLY_SHAPE,
	CP_NUM_SHAPES
} cpShapeType;

struct cpShapeClass
{
    cpShapeType type;

    cpShapeCacheDataImpl cacheData;
    cpShapeDestroyImpl destroy;
    cpShapePointQueryImpl pointQuery;
    cpShapeSegmentQueryImpl segmentQuery;
};


struct cpShapeMassInfo {
	cpFloat m;
	cpFloat i;
	cpVect cog;
	cpFloat area;
};
typedef struct cpConstraint cpConstraint;
typedef struct cpBody cpBody;

typedef void (*cpConstraintPreStepImpl)(cpConstraint *constraint, cpFloat dt);
typedef void (*cpConstraintApplyCachedImpulseImpl)(cpConstraint *constraint, cpFloat dt_coef);
typedef void (*cpConstraintApplyImpulseImpl)(cpConstraint *constraint, cpFloat dt);
typedef cpFloat (*cpConstraintGetImpulseImpl)(cpConstraint *constraint);

typedef struct cpConstraintClass {
	cpConstraintPreStepImpl preStep;
	cpConstraintApplyCachedImpulseImpl applyCachedImpulse;
	cpConstraintApplyImpulseImpl applyImpulse;
	cpConstraintGetImpulseImpl getImpulse;
} cpConstraintClass;

/// Callback function type that gets called before solving a joint.
// typedef void (*cpConstraintPreSolveFunc)(cpConstraint *constraint, cpSpace *space);
typedef void (*cpConstraintPreSolveFuncD)(cpConstraint *constraint, cpSpace *space, uint64_t callbackId);
/// Callback function type that gets called after solving a joint.
//typedef void (*cpConstraintPostSolveFunc)(cpConstraint *constraint, cpSpace *space);
typedef void (*cpConstraintPostSolveFuncD)(cpConstraint *constraint, cpSpace *space, uint64_t callbackId);


struct cpConstraint {
	const cpConstraintClass *klass;
	
	cpSpace *space;
	
	cpBody *a, *b;
	cpConstraint *next_a, *next_b;
	
	cpFloat maxForce;
	cpFloat errorBias;
	cpFloat maxBias;
	
	cpBool collideBodies;
	
	cpConstraintPreSolveFuncD preSolve;
	cpConstraintPostSolveFuncD postSolve;
	
	cpDataPointer userData;
};


/// Rigid body velocity update function type.
//typedef void (*cpBodyVelocityFunc)(cpBody *body, cpVect gravity, cpFloat damping, cpFloat dt);
typedef void (*cpBodyVelocityFuncD)(cpBody *body, cpVect gravity, cpFloat damping, cpFloat dt, uint64_t callbackId);
/// Rigid body position update function type.
// typedef void (*cpBodyPositionFunc)(cpBody *body, cpFloat dt);
typedef void (*cpBodyPositionFuncD)(cpBody *body, cpFloat dt, uint64_t callbackId);


struct cpBody {
	// Integration functions
	cpBodyVelocityFuncD velocity_func;
	cpBodyPositionFuncD position_func;
	
	// mass and it's inverse
	cpFloat m;
	cpFloat m_inv;
	
	// moment of inertia and it's inverse
	cpFloat i;
	cpFloat i_inv;
	
	// center of gravity
	cpVect cog;
	
	// position, velocity, force
	cpVect p;
	cpVect v;
	cpVect f;
	
	// Angle, angular velocity, torque (radians)
	cpFloat a;
	cpFloat w;
	cpFloat t;
	
	cpTransform transform;
	
	cpDataPointer userData;
	
	// "pseudo-velocities" used for eliminating overlap.
	// Erin Catto has some papers that talk about what these are.
	cpVect v_bias;
	cpFloat w_bias;
	
	cpSpace *space;
	
	cpShape *shapeList;
	cpArbiter *arbiterList;
	cpConstraint *constraintList;
	
	struct {
		cpBody *root;
		cpBody *next;
		cpFloat idleTime;
	} sleeping;
};


struct cpShape
{
    const cpShapeClass *klass;

    cpSpace *space;
    cpBody *body;
    struct cpShapeMassInfo massInfo;
    cpBB bb;

    cpBool sensor;

    cpFloat e;
    cpFloat u;
    cpVect surfaceV;

    cpDataPointer userData;

    cpCollisionType type;
    cpShapeFilter filter;

    cpShape *next;
    cpShape *prev;

    cpHashValue hashid;
};

struct cpArbiter
{
    cpFloat e;
    cpFloat u;
    cpVect surface_vr;

    cpDataPointer data;

    const cpShape *a, *b;
    cpBody *body_a, *body_b;
    struct cpArbiterThread thread_a, thread_b;

    int count;
    struct cpContact *contacts;
    cpVect n;

    // Regular, wildcard A and wildcard B collision handlers.
    cpCollisionHandler *handler, *handlerA, *handlerB;
    cpBool swapped;

    cpTimestamp stamp;
    enum cpArbiterState state;
};

// typedef cpBool (*cpCollisionBeginFunc)(cpArbiter *arb, cpSpace *space, cpDataPointer userData);
// typedef cpBool (*cpCollisionPreSolveFunc)(cpArbiter *arb, cpSpace *space, cpDataPointer userData);
// typedef void (*cpCollisionPostSolveFunc)(cpArbiter *arb, cpSpace *space, cpDataPointer userData);
// typedef void (*cpCollisionSeparateFunc)(cpArbiter *arb, cpSpace *space, cpDataPointer userData);

// struct cpCollisionHandler
// {
//     const cpCollisionType typeA;
//     const cpCollisionType typeB;
//     cpCollisionBeginFunc beginFunc;
//     cpCollisionPreSolveFunc preSolveFunc;
//     cpCollisionPostSolveFunc postSolveFunc;
//     cpCollisionSeparateFunc separateFunc;
//     cpDataPointer userData;
// 	int callbackId;
// };


typedef cpBool (*cpCollisionBeginFuncD)(cpArbiter *arb, cpSpace *space, cpDataPointer userData, uint64_t callbackId);
typedef cpBool (*cpCollisionPreSolveFuncD)(cpArbiter *arb, cpSpace *space, cpDataPointer userData, uint64_t callbackId);
typedef void (*cpCollisionPostSolveFuncD)(cpArbiter *arb, cpSpace *space, cpDataPointer userData, uint64_t callbackId);
typedef void (*cpCollisionSeparateFuncD)(cpArbiter *arb, cpSpace *space, cpDataPointer userData, uint64_t callbackId);

struct cpCollisionHandler {
	const cpCollisionType typeA;
	const cpCollisionType typeB;
	cpCollisionBeginFuncD beginFunc;
	cpCollisionPreSolveFuncD preSolveFunc;
	cpCollisionPostSolveFuncD postSolveFunc;
	cpCollisionSeparateFuncD separateFunc;
	cpDataPointer userData;
	uint64_t callbackId;
};

struct cpSpace
{
    int iterations;

    cpVect gravity;
    cpFloat damping;

    cpFloat idleSpeedThreshold;
    cpFloat sleepTimeThreshold;

    cpFloat collisionSlop;
    cpFloat collisionBias;
    cpTimestamp collisionPersistence;

    cpDataPointer userData;

    cpTimestamp stamp;
    cpFloat curr_dt;

    cpArray *dynamicBodies;
    cpArray *staticBodies;
    cpArray *rousedBodies;
    cpArray *sleepingComponents;

    cpHashValue shapeIDCounter;
    cpSpatialIndex *staticShapes;
    cpSpatialIndex *dynamicShapes;

    cpArray *constraints;

    cpArray *arbiters;
    cpContactBufferHeader *contactBuffersHead;
    cpHashSet *cachedArbiters;
    cpArray *pooledArbiters;

    cpArray *allocatedBuffers;
    unsigned int locked;

    cpBool usesWildcards;
    cpHashSet *collisionHandlers;
    cpCollisionHandler defaultHandler;

    cpBool skipPostStep;
    cpArray *postStepCallbacks;

    cpBody *staticBody;
    cpBody _staticBody;
};

#define CP_MAX_CONTACTS_PER_ARBITER 2

typedef struct cpContactPointSet cpContactPointSet;
/// A struct that wraps up the important collision data for an arbiter.
struct cpContactPointSet {
	/// The number of contact points in the set.
	int count;
	
	/// The normal of the collision.
	cpVect normal;
	
	/// The array of contact points.
	struct {
		/// The position of the contact on the surface of each shape.
		cpVect pointA, pointB;
		/// Penetration distance of the two shapes. Overlapping means it will be negative.
		/// This value is calculated as cpvdot(cpvsub(point2, point1), normal) and is ignored by cpArbiterSetContactPointSet().
		cpFloat distance;
	} points[CP_MAX_CONTACTS_PER_ARBITER];
};


typedef enum cpBodyType {
	/// A dynamic body is one that is affected by gravity, forces, and collisions.
	/// This is the default body type.
	CP_BODY_TYPE_DYNAMIC,
	/// A kinematic body is an infinite mass, user controlled body that is not affected by gravity, forces or collisions.
	/// Instead the body only moves based on it's velocity.
	/// Dynamic bodies collide normally with kinematic bodies, though the kinematic body will be unaffected.
	/// Collisions between two kinematic bodies, or a kinematic body and a static body produce collision callbacks, but no collision response.
	CP_BODY_TYPE_KINEMATIC,
	/// A static body is a body that never (or rarely) moves. If you move a static body, you must call one of the cpSpaceReindex*() functions.
	/// Chipmunk uses this information to optimize the collision detection.
	/// Static bodies do not produce collision callbacks when colliding with other static bodies.
	CP_BODY_TYPE_STATIC,
} cpBodyType;

//typedef void (*cpBodyShapeIteratorFunc)(cpBody *body, cpShape *shape, void *data);
typedef void (*cpBodyShapeIteratorFuncD)(cpBody *body, cpShape *shape, void *data, uint64_t callbackId);

// typedef void (*cpBodyConstraintIteratorFunc)(cpBody *body, cpConstraint *constraint, void *data);
typedef void (*cpBodyConstraintIteratorFuncD)(cpBody *body, cpConstraint *constraint, void *data, uint64_t callbackId);

//typedef void (*cpBodyArbiterIteratorFunc)(cpBody *body, cpArbiter *arbiter, void *data);
typedef void (*cpBodyArbiterIteratorFuncD)(cpBody *body, cpArbiter *arbiter, void *data, uint64_t callbackId);

// typedef cpFloat (*cpDampedRotarySpringTorqueFunc)(struct cpConstraint *spring, cpFloat relativeAngle);
typedef cpFloat (*cpDampedRotarySpringTorqueFuncD)(struct cpConstraint *spring, cpFloat relativeAngle, uint64_t callbackId);

typedef struct cpDampedRotarySpring cpDampedRotarySpring;


struct cpDampedRotarySpring {
	cpConstraint constraint;
	cpFloat restAngle;
	cpFloat stiffness;
	cpFloat damping;
	cpDampedRotarySpringTorqueFuncD springTorqueFunc;
	
	cpFloat target_wrn;
	cpFloat w_coef;
	
	cpFloat iSum;
	cpFloat jAcc;
	uint64_t callbackId;
};

typedef struct cpGearJoint cpGearJoint;

struct cpGearJoint {
	cpConstraint constraint;
	cpFloat phase, ratio;
	cpFloat ratio_inv;
	
	cpFloat iSum;
		
	cpFloat bias;
	cpFloat jAcc;
};
typedef struct cpDampedSpring cpDampedSpring;

//typedef cpFloat (*cpDampedSpringForceFunc)(cpConstraint *spring, cpFloat dist);
typedef cpFloat (*cpDampedSpringForceFuncD)(cpConstraint *spring, cpFloat dist, uint64_t callbackId);



struct cpDampedSpring {
	cpConstraint constraint;
	cpVect anchorA, anchorB;
	cpFloat restLength;
	cpFloat stiffness;
	cpFloat damping;
	cpDampedSpringForceFuncD springForceFunc;
	
	cpFloat target_vrn;
	cpFloat v_coef;
	
	cpVect r1, r2;
	cpFloat nMass;
	cpVect n;
	
	cpFloat jAcc;
	uint64_t callbackId;

};
typedef struct cpMat2x2 {
	// Row major [[a, b][c d]]
	cpFloat a, b, c, d;
} cpMat2x2;
typedef struct cpPivotJoint cpPivotJoint;

struct cpPivotJoint {
	cpConstraint constraint;
	cpVect anchorA, anchorB;
	
	cpVect r1, r2;
	cpMat2x2 k;
	
	cpVect jAcc;
	cpVect bias;
};

typedef struct cpPinJoint cpPinJoint;

struct cpPinJoint {
	cpConstraint constraint;
	cpVect anchorA, anchorB;
	cpFloat dist;
	
	cpVect r1, r2;
	cpVect n;
	cpFloat nMass;
	
	cpFloat jnAcc;
	cpFloat bias;
};

typedef struct cpGrooveJoint cpGrooveJoint;

struct cpGrooveJoint {
	cpConstraint constraint;
	cpVect grv_n, grv_a, grv_b;
	cpVect  anchorB;
	
	cpVect grv_tn;
	cpFloat clamp;
	cpVect r1, r2;
	cpMat2x2 k;
	
	cpVect jAcc;
	cpVect bias;
};

typedef struct cpSplittingPlane cpSplittingPlane;

struct cpSplittingPlane {
	cpVect v0, n;
};


#define CP_POLY_SHAPE_INLINE_ALLOC 6
typedef struct cpPolyShape cpPolyShape;

struct cpPolyShape {
	cpShape shape;
	
	cpFloat r;
	
	int count;
	// The untransformed planes are appended at the end of the transformed planes.
	struct cpSplittingPlane *planes;
	
	// Allocate a small number of splitting planes internally for simple poly.
	struct cpSplittingPlane _planes[2*CP_POLY_SHAPE_INLINE_ALLOC];
};

typedef struct cpRotaryLimitJoint cpRotaryLimitJoint;


struct cpRotaryLimitJoint {
	cpConstraint constraint;
	cpFloat min, max;
	
	cpFloat iSum;
		
	cpFloat bias;
	cpFloat jAcc;
};
typedef struct cpRatchetJoint cpRatchetJoint;

struct cpRatchetJoint {
	cpConstraint constraint;
	cpFloat angle, phase, ratchet;
	
	cpFloat iSum;
		
	cpFloat bias;
	cpFloat jAcc;
};
typedef struct cpSlideJoint cpSlideJoint;

struct cpSlideJoint {
	cpConstraint constraint;
	cpVect anchorA, anchorB;
	cpFloat min, max;
	
	cpVect r1, r2;
	cpVect n;
	cpFloat nMass;
	
	cpFloat jnAcc;
	cpFloat bias;
};
typedef struct cpCircleShape cpCircleShape;

struct cpCircleShape {
	cpShape shape;
	
	cpVect c, tc;
	cpFloat r;
};
typedef struct cpSegmentShape cpSegmentShape;

struct cpSegmentShape {
	cpShape shape;
	
	cpVect a, b, n;
	cpVect ta, tb, tn;
	cpFloat r;
	
	cpVect a_tangent, b_tangent;
};
typedef struct cpSimpleMotor cpSimpleMotor;

struct cpSimpleMotor {
	cpConstraint constraint;
	cpFloat rate;
	
	cpFloat iSum;
		
	cpFloat jAcc;
};

//typedef void (*cpPostStepFunc)(cpSpace *space, void *key, void *data);
typedef void (*cpPostStepFuncD)(cpSpace *space, void *key, void *data, uint64_t callbackId);

typedef void (*cpSpacePointQueryFuncD)(cpShape *shape, cpVect point, cpFloat distance, cpVect gradient, void *data, uint64_t callbackId);
//typedef void (*cpSpaceSegmentQueryFunc)(cpShape *shape, cpVect point, cpVect normal, cpFloat alpha, void *data);
typedef void (*cpSpaceSegmentQueryFuncD)(cpShape *shape, cpVect point, cpVect normal, cpFloat alpha, void *data, uint64_t callbackId);
typedef void (*cpSpaceBBQueryFuncD)(cpShape *shape, void *data, uint64_t callbackId);
typedef void (*cpSpaceShapeQueryFuncD)(cpShape *shape, cpContactPointSet *points, void *data, uint64_t callbackId);
typedef void (*cpSpaceBodyIteratorFunc)(cpBody *body, void *data);
typedef void (*cpSpaceBodyIteratorFuncD)(cpBody *body, void *data, uint64_t callbackId);
typedef void (*cpSpaceShapeIteratorFunc)(cpShape *shape, void *data);
typedef void (*cpSpaceShapeIteratorFuncD)(cpShape *shape, void *data, uint64_t callbackId);
typedef void (*cpSpaceConstraintIteratorFuncD)(cpConstraint *constraint, void *data, uint64_t callbackId);



/// Color type to use with the space debug drawing API.
typedef struct cpSpaceDebugColor {
	float r, g, b, a;
} cpSpaceDebugColor;

/// Callback type for a function that draws a filled, stroked circle.
typedef void (*cpSpaceDebugDrawCircleImpl)(cpVect pos, cpFloat angle, cpFloat radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillColor, cpDataPointer data);
/// Callback type for a function that draws a line segment.
typedef void (*cpSpaceDebugDrawSegmentImpl)(cpVect a, cpVect b, cpSpaceDebugColor color, cpDataPointer data);
/// Callback type for a function that draws a thick line segment.
typedef void (*cpSpaceDebugDrawFatSegmentImpl)(cpVect a, cpVect b, cpFloat radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillColor, cpDataPointer data);
/// Callback type for a function that draws a convex polygon.
typedef void (*cpSpaceDebugDrawPolygonImpl)(int count, const cpVect *verts, cpFloat radius, cpSpaceDebugColor outlineColor, cpSpaceDebugColor fillColor, cpDataPointer data);
/// Callback type for a function that draws a dot.
typedef void (*cpSpaceDebugDrawDotImpl)(cpFloat size, cpVect pos, cpSpaceDebugColor color, cpDataPointer data);
/// Callback type for a function that returns a color for a given shape. This gives you an opportunity to color shapes based on how they are used in your engine.
typedef cpSpaceDebugColor (*cpSpaceDebugDrawColorForShapeImpl)(cpShape *shape, cpDataPointer data);

typedef enum cpSpaceDebugDrawFlags {
	CP_SPACE_DEBUG_DRAW_SHAPES = 1<<0,
	CP_SPACE_DEBUG_DRAW_CONSTRAINTS = 1<<1,
	CP_SPACE_DEBUG_DRAW_COLLISION_POINTS = 1<<2,
} cpSpaceDebugDrawFlags;

/// Struct used with cpSpaceDebugDraw() containing drawing callbacks and other drawing settings.
typedef struct cpSpaceDebugDrawOptions {
	/// Function that will be invoked to draw circles.
	cpSpaceDebugDrawCircleImpl drawCircle;
	/// Function that will be invoked to draw line segments.
	cpSpaceDebugDrawSegmentImpl drawSegment;
	/// Function that will be invoked to draw thick line segments.
	cpSpaceDebugDrawFatSegmentImpl drawFatSegment;
	/// Function that will be invoked to draw convex polygons.
	cpSpaceDebugDrawPolygonImpl drawPolygon;
	/// Function that will be invoked to draw dots.
	cpSpaceDebugDrawDotImpl drawDot;
	
	/// Flags that request which things to draw (collision shapes, constraints, contact points).
	cpSpaceDebugDrawFlags flags;
	/// Outline color passed to the drawing function.
	cpSpaceDebugColor shapeOutlineColor;
	/// Function that decides what fill color to draw shapes using.
	cpSpaceDebugDrawColorForShapeImpl colorForShape;
	/// Color passed to drawing functions for constraints.
	cpSpaceDebugColor constraintColor;
	/// Color passed to drawing functions for collision points.
	cpSpaceDebugColor collisionPointColor;
	
	/// User defined context pointer passed to all of the callback functions as the 'data' argument.
	cpDataPointer data;
} cpSpaceDebugDrawOptions;

typedef struct cpSpaceHash cpSpaceHash;
typedef struct cpBBTree cpBBTree;
typedef struct cpSweep1D cpSweep1D;

typedef cpVect (*cpBBTreeVelocityFunc)(void *obj);

typedef struct cpPolyline {
  int count, capacity;
  cpVect verts[];
} cpPolyline;

typedef struct cpPolylineSet {
  int count, capacity;
  cpPolyline **lines;
} cpPolylineSet;

cpSpace* cpSpaceNew(void);
void cpSpaceSetGravity(cpSpace *space, cpVect gravity);
cpShape* cpSegmentShapeNew(cpBody *body, cpVect a, cpVect b, cpFloat radius);
cpBody* cpSpaceGetStaticBody(const cpSpace *space);

void cpShapeSetFriction(cpShape *shape, cpFloat friction);
cpShape* cpSpaceAddShape(cpSpace *space, cpShape *shape);
cpFloat cpMomentForCircle(cpFloat m, cpFloat r1, cpFloat r2, cpVect offset);
cpBody* cpSpaceAddBody(cpSpace *space, cpBody *body);
void cpBodySetPosition(cpBody *body, cpVect pos);
cpVect cpBodyGetPosition(const cpBody *body);
cpVect cpBodyGetVelocity(const cpBody *body);
void cpSpaceStep(cpSpace *space, cpFloat dt);
void cpShapeFree(cpShape *shape);
void cpBodyFree(cpBody *body);
void cpSpaceFree(cpSpace *space);
cpBody* cpBodyNew(cpFloat mass, cpFloat moment);
cpShape* cpCircleShapeNew(cpBody *body, cpFloat radius, cpVect offset);


 void cpMessage(const char *condition, const char *file, int line, int isError, int isHardError, const char *message, ...);
 extern const char *cpVersionString;
 cpFloat cpAreaForCircle(cpFloat r1, cpFloat r2);
 cpFloat cpMomentForSegment(cpFloat m, cpVect a, cpVect b, cpFloat radius);
 cpFloat cpAreaForSegment(cpVect a, cpVect b, cpFloat radius);
 cpFloat cpMomentForPoly(cpFloat m, int count, const cpVect *verts, cpVect offset, cpFloat radius);
 cpFloat cpAreaForPoly(const int count, const cpVect *verts, cpFloat radius);
 cpVect cpCentroidForPoly(const int count, const cpVect *verts);
 cpFloat cpMomentForBox(cpFloat m, cpFloat width, cpFloat height);
 cpFloat cpMomentForBox2(cpFloat m, cpBB box);
 int cpConvexHull(int count, const cpVect *verts, cpVect *result, int *first, cpFloat tol);
 cpFloat cpArbiterGetRestitution(const cpArbiter *arb);
 void cpArbiterSetRestitution(cpArbiter *arb, cpFloat restitution);
 cpFloat cpArbiterGetFriction(const cpArbiter *arb);
 void cpArbiterSetFriction(cpArbiter *arb, cpFloat friction);
 cpVect cpArbiterGetSurfaceVelocity(cpArbiter *arb);
 void cpArbiterSetSurfaceVelocity(cpArbiter *arb, cpVect vr);
 cpDataPointer cpArbiterGetUserData(const cpArbiter *arb);
 void cpArbiterSetUserData(cpArbiter *arb, cpDataPointer userData);
 cpVect cpArbiterTotalImpulse(const cpArbiter *arb);
 cpFloat cpArbiterTotalKE(const cpArbiter *arb);
 cpBool cpArbiterIgnore(cpArbiter *arb);
 void cpArbiterGetShapes(const cpArbiter *arb, cpShape **a, cpShape **b);
 void cpArbiterGetBodies(const cpArbiter *arb, cpBody **a, cpBody **b);
 cpContactPointSet cpArbiterGetContactPointSet(const cpArbiter *arb);
 void cpArbiterSetContactPointSet(cpArbiter *arb, cpContactPointSet *set);
 cpBool cpArbiterIsFirstContact(const cpArbiter *arb);
 cpBool cpArbiterIsRemoval(const cpArbiter *arb);
 int cpArbiterGetCount(const cpArbiter *arb);
 cpVect cpArbiterGetNormal(const cpArbiter *arb);
 cpVect cpArbiterGetPointA(const cpArbiter *arb, int i);
 cpVect cpArbiterGetPointB(const cpArbiter *arb, int i);
 cpFloat cpArbiterGetDepth(const cpArbiter *arb, int i);
 cpBool cpArbiterCallWildcardBeginA(cpArbiter *arb, cpSpace *space);
 cpBool cpArbiterCallWildcardBeginB(cpArbiter *arb, cpSpace *space);
 cpBool cpArbiterCallWildcardPreSolveA(cpArbiter *arb, cpSpace *space);
 cpBool cpArbiterCallWildcardPreSolveB(cpArbiter *arb, cpSpace *space);
 void cpArbiterCallWildcardPostSolveA(cpArbiter *arb, cpSpace *space);
 void cpArbiterCallWildcardPostSolveB(cpArbiter *arb, cpSpace *space);
 void cpArbiterCallWildcardSeparateA(cpArbiter *arb, cpSpace *space);
 void cpArbiterCallWildcardSeparateB(cpArbiter *arb, cpSpace *space);
 cpBody* cpBodyAlloc(void);
 cpBody* cpBodyInit(cpBody *body, cpFloat mass, cpFloat moment);
 cpBody* cpBodyNewKinematic(void);
 cpBody* cpBodyNewStatic(void);
 void cpBodyDestroy(cpBody *body);
 void cpBodyActivate(cpBody *body);
 void cpBodyActivateStatic(cpBody *body, cpShape *filter);
 void cpBodySleep(cpBody *body);
 void cpBodySleepWithGroup(cpBody *body, cpBody *group);
 cpBool cpBodyIsSleeping(const cpBody *body);
 cpBodyType cpBodyGetType(cpBody *body);
 void cpBodySetType(cpBody *body, cpBodyType type);
 cpSpace* cpBodyGetSpace(const cpBody *body);
 cpFloat cpBodyGetMass(const cpBody *body);
 void cpBodySetMass(cpBody *body, cpFloat m);
 cpFloat cpBodyGetMoment(const cpBody *body);
 void cpBodySetMoment(cpBody *body, cpFloat i);
 cpVect cpBodyGetCenterOfGravity(const cpBody *body);
 void cpBodySetCenterOfGravity(cpBody *body, cpVect cog);
 void cpBodySetVelocity(cpBody *body, cpVect velocity);
 cpVect cpBodyGetForce(const cpBody *body);
 void cpBodySetForce(cpBody *body, cpVect force);
 cpFloat cpBodyGetAngle(const cpBody *body);
 void cpBodySetAngle(cpBody *body, cpFloat a);
 cpFloat cpBodyGetAngularVelocity(const cpBody *body);
 void cpBodySetAngularVelocity(cpBody *body, cpFloat angularVelocity);
 cpFloat cpBodyGetTorque(const cpBody *body);
 void cpBodySetTorque(cpBody *body, cpFloat torque);
 cpVect cpBodyGetRotation(const cpBody *body);
 cpDataPointer cpBodyGetUserData(const cpBody *body);
 void cpBodySetUserData(cpBody *body, cpDataPointer userData);
 void cpBodySetVelocityUpdateFunc(cpBody *body, cpBodyVelocityFuncD velocityFunc, uint64_t callbackId);
 void cpBodySetPositionUpdateFunc(cpBody *body, cpBodyPositionFuncD positionFunc, uint64_t callbackId);
 void cpBodyUpdateVelocity(cpBody *body, cpVect gravity, cpFloat damping, cpFloat dt, uint64_t callbackId);
 void cpBodyUpdatePosition(cpBody *body, cpFloat dt,  uint64_t callbackId);
 cpVect cpBodyLocalToWorld(const cpBody *body, const cpVect point);
 cpVect cpBodyWorldToLocal(const cpBody *body, const cpVect point);
 void cpBodyApplyForceAtWorldPoint(cpBody *body, cpVect force, cpVect point);
 void cpBodyApplyForceAtLocalPoint(cpBody *body, cpVect force, cpVect point);
 void cpBodyApplyImpulseAtWorldPoint(cpBody *body, cpVect impulse, cpVect point);
 void cpBodyApplyImpulseAtLocalPoint(cpBody *body, cpVect impulse, cpVect point);
 cpVect cpBodyGetVelocityAtWorldPoint(const cpBody *body, cpVect point);
 cpVect cpBodyGetVelocityAtLocalPoint(const cpBody *body, cpVect point);
 cpFloat cpBodyKineticEnergy(const cpBody *body);
 void cpBodyEachShape(cpBody *body, cpBodyShapeIteratorFuncD func, void *data, uint64_t callbackId);
 void cpBodyEachConstraint(cpBody *body, cpBodyConstraintIteratorFuncD func, void *data, uint64_t callbackId);
 void cpBodyEachArbiter(cpBody *body, cpBodyArbiterIteratorFuncD func, void *data, uint64_t callbackId);
 cpBool cpConstraintIsDampedRotarySpring(const cpConstraint *constraint);
 cpDampedRotarySpring* cpDampedRotarySpringAlloc(void);
 cpDampedRotarySpring* cpDampedRotarySpringInit(cpDampedRotarySpring *joint, cpBody *a, cpBody *b, cpFloat restAngle, cpFloat stiffness, cpFloat damping);
 cpConstraint* cpDampedRotarySpringNew(cpBody *a, cpBody *b, cpFloat restAngle, cpFloat stiffness, cpFloat damping);
 cpFloat cpDampedRotarySpringGetRestAngle(const cpConstraint *constraint);
 void cpDampedRotarySpringSetRestAngle(cpConstraint *constraint, cpFloat restAngle);
 cpFloat cpDampedRotarySpringGetStiffness(const cpConstraint *constraint);
 void cpDampedRotarySpringSetStiffness(cpConstraint *constraint, cpFloat stiffness);
 cpFloat cpDampedRotarySpringGetDamping(const cpConstraint *constraint);
 void cpDampedRotarySpringSetDamping(cpConstraint *constraint, cpFloat damping);
 cpDampedRotarySpringTorqueFuncD cpDampedRotarySpringGetSpringTorqueFunc(const cpConstraint *constraint);
 void cpDampedRotarySpringSetSpringTorqueFunc(cpConstraint *constraint, cpDampedRotarySpringTorqueFuncD springTorqueFunc, uint64_t callbackId);
 void cpConstraintDestroy(cpConstraint *constraint);
 void cpConstraintFree(cpConstraint *constraint);
 cpSpace* cpConstraintGetSpace(const cpConstraint *constraint);
 cpBody* cpConstraintGetBodyA(const cpConstraint *constraint);
 cpBody* cpConstraintGetBodyB(const cpConstraint *constraint);
 cpFloat cpConstraintGetMaxForce(const cpConstraint *constraint);
 void cpConstraintSetMaxForce(cpConstraint *constraint, cpFloat maxForce);
 cpFloat cpConstraintGetErrorBias(const cpConstraint *constraint);
 void cpConstraintSetErrorBias(cpConstraint *constraint, cpFloat errorBias);
 cpFloat cpConstraintGetMaxBias(const cpConstraint *constraint);
 void cpConstraintSetMaxBias(cpConstraint *constraint, cpFloat maxBias);
 cpBool cpConstraintGetCollideBodies(const cpConstraint *constraint);
 void cpConstraintSetCollideBodies(cpConstraint *constraint, cpBool collideBodies);
 cpConstraintPreSolveFuncD cpConstraintGetPreSolveFunc(const cpConstraint *constraint);
 void cpConstraintSetPreSolveFunc(cpConstraint *constraint, cpConstraintPreSolveFuncD preSolveFunc);
 cpConstraintPostSolveFuncD cpConstraintGetPostSolveFunc(const cpConstraint *constraint);
 void cpConstraintSetPostSolveFunc(cpConstraint *constraint, cpConstraintPostSolveFuncD postSolveFunc, uint64_t callbackId);
 cpDataPointer cpConstraintGetUserData(const cpConstraint *constraint);
 void cpConstraintSetUserData(cpConstraint *constraint, cpDataPointer userData);
 cpFloat cpConstraintGetImpulse(cpConstraint *constraint);
 cpBool cpConstraintIsGearJoint(const cpConstraint *constraint);
 cpGearJoint* cpGearJointAlloc(void);
 cpGearJoint* cpGearJointInit(cpGearJoint *joint, cpBody *a, cpBody *b, cpFloat phase, cpFloat ratio);
 cpConstraint* cpGearJointNew(cpBody *a, cpBody *b, cpFloat phase, cpFloat ratio);
 cpFloat cpGearJointGetPhase(const cpConstraint *constraint);
 void cpGearJointSetPhase(cpConstraint *constraint, cpFloat phase);
 cpFloat cpGearJointGetRatio(const cpConstraint *constraint);
 void cpGearJointSetRatio(cpConstraint *constraint, cpFloat ratio);
 cpBool cpConstraintIsDampedSpring(const cpConstraint *constraint);
 cpDampedSpring* cpDampedSpringAlloc(void);
 cpDampedSpring* cpDampedSpringInit(cpDampedSpring *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat restLength, cpFloat stiffness, cpFloat damping);
 cpConstraint* cpDampedSpringNew(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat restLength, cpFloat stiffness, cpFloat damping);
 cpVect cpDampedSpringGetAnchorA(const cpConstraint *constraint);
 void cpDampedSpringSetAnchorA(cpConstraint *constraint, cpVect anchorA);
 cpVect cpDampedSpringGetAnchorB(const cpConstraint *constraint);
 void cpDampedSpringSetAnchorB(cpConstraint *constraint, cpVect anchorB);
 cpFloat cpDampedSpringGetRestLength(const cpConstraint *constraint);
 void cpDampedSpringSetRestLength(cpConstraint *constraint, cpFloat restLength);
 cpFloat cpDampedSpringGetStiffness(const cpConstraint *constraint);
 void cpDampedSpringSetStiffness(cpConstraint *constraint, cpFloat stiffness);
 cpFloat cpDampedSpringGetDamping(const cpConstraint *constraint);
 void cpDampedSpringSetDamping(cpConstraint *constraint, cpFloat damping);
 cpDampedSpringForceFuncD cpDampedSpringGetSpringForceFunc(const cpConstraint *constraint);
 void cpDampedSpringSetSpringForceFunc(cpConstraint *constraint, cpDampedSpringForceFuncD springForceFunc, uint64_t callbackId);
 cpBool cpConstraintIsPivotJoint(const cpConstraint *constraint);
 cpPivotJoint* cpPivotJointAlloc(void);
 cpPivotJoint* cpPivotJointInit(cpPivotJoint *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);
 cpConstraint* cpPivotJointNew(cpBody *a, cpBody *b, cpVect pivot);
 cpConstraint* cpPivotJointNew2(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);
 cpVect cpPivotJointGetAnchorA(const cpConstraint *constraint);
 void cpPivotJointSetAnchorA(cpConstraint *constraint, cpVect anchorA);
 cpVect cpPivotJointGetAnchorB(const cpConstraint *constraint);
 void cpPivotJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);
 cpBool cpConstraintIsPinJoint(const cpConstraint *constraint);
 cpPinJoint* cpPinJointAlloc(void);
 cpPinJoint* cpPinJointInit(cpPinJoint *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);
 cpConstraint* cpPinJointNew(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB);
 cpVect cpPinJointGetAnchorA(const cpConstraint *constraint);
 void cpPinJointSetAnchorA(cpConstraint *constraint, cpVect anchorA);
 cpVect cpPinJointGetAnchorB(const cpConstraint *constraint);
 void cpPinJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);
 cpFloat cpPinJointGetDist(const cpConstraint *constraint);
 void cpPinJointSetDist(cpConstraint *constraint, cpFloat dist);
 cpBool cpConstraintIsGrooveJoint(const cpConstraint *constraint);
 cpGrooveJoint* cpGrooveJointAlloc(void);
 cpGrooveJoint* cpGrooveJointInit(cpGrooveJoint *joint, cpBody *a, cpBody *b, cpVect groove_a, cpVect groove_b, cpVect anchorB);
 cpConstraint* cpGrooveJointNew(cpBody *a, cpBody *b, cpVect groove_a, cpVect groove_b, cpVect anchorB);
 cpVect cpGrooveJointGetGrooveA(const cpConstraint *constraint);
 void cpGrooveJointSetGrooveA(cpConstraint *constraint, cpVect grooveA);
 cpVect cpGrooveJointGetGrooveB(const cpConstraint *constraint);
 void cpGrooveJointSetGrooveB(cpConstraint *constraint, cpVect grooveB);
 cpVect cpGrooveJointGetAnchorB(const cpConstraint *constraint);
 void cpGrooveJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);
 cpPolyShape* cpPolyShapeAlloc(void);
 cpPolyShape* cpPolyShapeInit(cpPolyShape *poly, cpBody *body, int count, const cpVect *verts, cpTransform transform, cpFloat radius);
 cpPolyShape* cpPolyShapeInitRaw(cpPolyShape *poly, cpBody *body, int count, const cpVect *verts, cpFloat radius);
 cpShape* cpPolyShapeNew(cpBody *body, int count, const cpVect *verts, cpTransform transform, cpFloat radius);
 cpShape* cpPolyShapeNewRaw(cpBody *body, int count, const cpVect *verts, cpFloat radius);
 cpPolyShape* cpBoxShapeInit(cpPolyShape *poly, cpBody *body, cpFloat width, cpFloat height, cpFloat radius);
 cpPolyShape* cpBoxShapeInit2(cpPolyShape *poly, cpBody *body, cpBB box, cpFloat radius);
 cpShape* cpBoxShapeNew(cpBody *body, cpFloat width, cpFloat height, cpFloat radius);
 cpShape* cpBoxShapeNew2(cpBody *body, cpBB box, cpFloat radius);
 int cpPolyShapeGetCount(const cpShape *shape);
 cpVect cpPolyShapeGetVert(const cpShape *shape, int index);
 cpFloat cpPolyShapeGetRadius(const cpShape *shape);
 cpBool cpConstraintIsRotaryLimitJoint(const cpConstraint *constraint);
 cpRotaryLimitJoint* cpRotaryLimitJointAlloc(void);
 cpRotaryLimitJoint* cpRotaryLimitJointInit(cpRotaryLimitJoint *joint, cpBody *a, cpBody *b, cpFloat min, cpFloat max);
 cpConstraint* cpRotaryLimitJointNew(cpBody *a, cpBody *b, cpFloat min, cpFloat max);
 cpFloat cpRotaryLimitJointGetMin(const cpConstraint *constraint);
 void cpRotaryLimitJointSetMin(cpConstraint *constraint, cpFloat min);
 cpFloat cpRotaryLimitJointGetMax(const cpConstraint *constraint);
 void cpRotaryLimitJointSetMax(cpConstraint *constraint, cpFloat max);
 cpBool cpConstraintIsRatchetJoint(const cpConstraint *constraint);
 cpRatchetJoint* cpRatchetJointAlloc(void);
 cpRatchetJoint* cpRatchetJointInit(cpRatchetJoint *joint, cpBody *a, cpBody *b, cpFloat phase, cpFloat ratchet);
 cpConstraint* cpRatchetJointNew(cpBody *a, cpBody *b, cpFloat phase, cpFloat ratchet);
 cpFloat cpRatchetJointGetAngle(const cpConstraint *constraint);
 void cpRatchetJointSetAngle(cpConstraint *constraint, cpFloat angle);
 cpFloat cpRatchetJointGetPhase(const cpConstraint *constraint);
 void cpRatchetJointSetPhase(cpConstraint *constraint, cpFloat phase);
 cpFloat cpRatchetJointGetRatchet(const cpConstraint *constraint);
 void cpRatchetJointSetRatchet(cpConstraint *constraint, cpFloat ratchet);
 cpBool cpConstraintIsSlideJoint(const cpConstraint *constraint);
 cpSlideJoint* cpSlideJointAlloc(void);
 cpSlideJoint* cpSlideJointInit(cpSlideJoint *joint, cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat min, cpFloat max);
 cpConstraint* cpSlideJointNew(cpBody *a, cpBody *b, cpVect anchorA, cpVect anchorB, cpFloat min, cpFloat max);
 cpVect cpSlideJointGetAnchorA(const cpConstraint *constraint);
 void cpSlideJointSetAnchorA(cpConstraint *constraint, cpVect anchorA);
 cpVect cpSlideJointGetAnchorB(const cpConstraint *constraint);
 void cpSlideJointSetAnchorB(cpConstraint *constraint, cpVect anchorB);
 cpFloat cpSlideJointGetMin(const cpConstraint *constraint);
 void cpSlideJointSetMin(cpConstraint *constraint, cpFloat min);
 cpFloat cpSlideJointGetMax(const cpConstraint *constraint);
 void cpSlideJointSetMax(cpConstraint *constraint, cpFloat max);
 void cpShapeDestroy(cpShape *shape);
 cpBB cpShapeCacheBB(cpShape *shape);
 cpBB cpShapeUpdate(cpShape *shape, cpTransform transform);
 cpFloat cpShapePointQuery(const cpShape *shape, cpVect p, cpPointQueryInfo *out);
 cpBool cpShapeSegmentQuery(const cpShape *shape, cpVect a, cpVect b, cpFloat radius, cpSegmentQueryInfo *info);
 cpContactPointSet cpShapesCollide(const cpShape *a, const cpShape *b);
 cpSpace* cpShapeGetSpace(const cpShape *shape);
 cpBody* cpShapeGetBody(const cpShape *shape);
 void cpShapeSetBody(cpShape *shape, cpBody *body);
 cpFloat cpShapeGetMass(cpShape *shape);
 void cpShapeSetMass(cpShape *shape, cpFloat mass);
 cpFloat cpShapeGetDensity(cpShape *shape);
 void cpShapeSetDensity(cpShape *shape, cpFloat density);
 cpFloat cpShapeGetMoment(cpShape *shape);
 cpFloat cpShapeGetArea(cpShape *shape);
 cpVect cpShapeGetCenterOfGravity(cpShape *shape);
 cpBB cpShapeGetBB(const cpShape *shape);
 cpBool cpShapeGetSensor(const cpShape *shape);
 void cpShapeSetSensor(cpShape *shape, cpBool sensor);
 cpFloat cpShapeGetElasticity(const cpShape *shape);
 void cpShapeSetElasticity(cpShape *shape, cpFloat elasticity);
 cpFloat cpShapeGetFriction(const cpShape *shape);
 cpVect cpShapeGetSurfaceVelocity(const cpShape *shape);
 void cpShapeSetSurfaceVelocity(cpShape *shape, cpVect surfaceVelocity);
 cpDataPointer cpShapeGetUserData(const cpShape *shape);
 void cpShapeSetUserData(cpShape *shape, cpDataPointer userData);
 cpCollisionType cpShapeGetCollisionType(const cpShape *shape);
 void cpShapeSetCollisionType(cpShape *shape, cpCollisionType collisionType);
 cpShapeFilter cpShapeGetFilter(const cpShape *shape);
 void cpShapeSetFilter(cpShape *shape, cpShapeFilter filter);
 cpCircleShape* cpCircleShapeAlloc(void);
 cpCircleShape* cpCircleShapeInit(cpCircleShape *circle, cpBody *body, cpFloat radius, cpVect offset);
 cpVect cpCircleShapeGetOffset(const cpShape *shape);
 cpFloat cpCircleShapeGetRadius(const cpShape *shape);
 cpSegmentShape* cpSegmentShapeAlloc(void);
 cpSegmentShape* cpSegmentShapeInit(cpSegmentShape *seg, cpBody *body, cpVect a, cpVect b, cpFloat radius);
 void cpSegmentShapeSetNeighbors(cpShape *shape, cpVect prev, cpVect next);
 cpVect cpSegmentShapeGetA(const cpShape *shape);
 cpVect cpSegmentShapeGetB(const cpShape *shape);
 cpVect cpSegmentShapeGetNormal(const cpShape *shape);
 cpFloat cpSegmentShapeGetRadius(const cpShape *shape);
 cpBool cpConstraintIsSimpleMotor(const cpConstraint *constraint);
 cpSimpleMotor* cpSimpleMotorAlloc(void);
 cpSimpleMotor* cpSimpleMotorInit(cpSimpleMotor *joint, cpBody *a, cpBody *b, cpFloat rate);
 cpConstraint* cpSimpleMotorNew(cpBody *a, cpBody *b, cpFloat rate);
 cpFloat cpSimpleMotorGetRate(const cpConstraint *constraint);
 void cpSimpleMotorSetRate(cpConstraint *constraint, cpFloat rate);
 cpSpace* cpSpaceAlloc(void);
 cpSpace* cpSpaceInit(cpSpace *space);
 void cpSpaceDestroy(cpSpace *space);
 int cpSpaceGetIterations(const cpSpace *space);
 void cpSpaceSetIterations(cpSpace *space, int iterations);
 cpVect cpSpaceGetGravity(const cpSpace *space);
 cpFloat cpSpaceGetDamping(const cpSpace *space);
 void cpSpaceSetDamping(cpSpace *space, cpFloat damping);
 cpFloat cpSpaceGetIdleSpeedThreshold(const cpSpace *space);
 void cpSpaceSetIdleSpeedThreshold(cpSpace *space, cpFloat idleSpeedThreshold);
 cpFloat cpSpaceGetSleepTimeThreshold(const cpSpace *space);
 void cpSpaceSetSleepTimeThreshold(cpSpace *space, cpFloat sleepTimeThreshold);
 cpFloat cpSpaceGetCollisionSlop(const cpSpace *space);
 void cpSpaceSetCollisionSlop(cpSpace *space, cpFloat collisionSlop);
 cpFloat cpSpaceGetCollisionBias(const cpSpace *space);
 void cpSpaceSetCollisionBias(cpSpace *space, cpFloat collisionBias);
 cpTimestamp cpSpaceGetCollisionPersistence(const cpSpace *space);
 void cpSpaceSetCollisionPersistence(cpSpace *space, cpTimestamp collisionPersistence);
 cpDataPointer cpSpaceGetUserData(const cpSpace *space);
 void cpSpaceSetUserData(cpSpace *space, cpDataPointer userData);
 cpFloat cpSpaceGetCurrentTimeStep(const cpSpace *space);
 cpBool cpSpaceIsLocked(cpSpace *space);
 cpCollisionHandler *cpSpaceAddDefaultCollisionHandler(cpSpace *space, uint64_t callbackId);
 cpCollisionHandler *cpSpaceAddCollisionHandler(cpSpace *space, cpCollisionType a, cpCollisionType b, uint64_t callbackId);
 cpCollisionHandler *cpSpaceAddWildcardHandler(cpSpace *space, cpCollisionType type, uint64_t callbackId);
 cpConstraint* cpSpaceAddConstraint(cpSpace *space, cpConstraint *constraint);
 void cpSpaceRemoveShape(cpSpace *space, cpShape *shape);
 void cpSpaceRemoveBody(cpSpace *space, cpBody *body);
 void cpSpaceRemoveConstraint(cpSpace *space, cpConstraint *constraint);
 cpBool cpSpaceContainsShape(cpSpace *space, cpShape *shape);
 cpBool cpSpaceContainsBody(cpSpace *space, cpBody *body);
 cpBool cpSpaceContainsConstraint(cpSpace *space, cpConstraint *constraint);
 cpBool cpSpaceAddPostStepCallback(cpSpace *space, cpPostStepFuncD func, void *key, void *data, uint64_t callbackId);
 void cpSpacePointQuery(cpSpace *space, cpVect point, cpFloat maxDistance, cpShapeFilter filter, cpSpacePointQueryFuncD func, void *data, uint64_t callbackId);
 cpShape *cpSpacePointQueryNearest(cpSpace *space, cpVect point, cpFloat maxDistance, cpShapeFilter filter, cpPointQueryInfo *out);
 void cpSpaceSegmentQuery(cpSpace *space, cpVect start, cpVect end, cpFloat radius, cpShapeFilter filter, cpSpaceSegmentQueryFuncD func, void *data, uint64_t callbackId);
 cpShape *cpSpaceSegmentQueryFirst(cpSpace *space, cpVect start, cpVect end, cpFloat radius, cpShapeFilter filter, cpSegmentQueryInfo *out);
 void cpSpaceBBQuery(cpSpace *space, cpBB bb, cpShapeFilter filter, cpSpaceBBQueryFuncD func, void *data, uint64_t callbackId);
 cpBool cpSpaceShapeQuery(cpSpace *space, cpShape *shape, cpSpaceShapeQueryFuncD func, void *data, uint64_t callbackId);
 void cpSpaceEachBody(cpSpace *space, cpSpaceBodyIteratorFuncD func, void *data, uint64_t callbackId);
 void cpSpaceEachShape(cpSpace *space, cpSpaceShapeIteratorFuncD func, void *data, uint64_t callbackId);
 void cpSpaceEachConstraint(cpSpace *space, cpSpaceConstraintIteratorFuncD func, void *data, uint64_t callbackId);
 void cpSpaceReindexStatic(cpSpace *space);
 void cpSpaceReindexShape(cpSpace *space, cpShape *shape);
 void cpSpaceReindexShapesForBody(cpSpace *space, cpBody *body);
 void cpSpaceUseSpatialHash(cpSpace *space, cpFloat dim, int count);
 void cpSpaceDebugDraw(cpSpace *space, cpSpaceDebugDrawOptions *options);
 cpSpaceHash* cpSpaceHashAlloc(void);
 cpSpatialIndex* cpSpaceHashInit(cpSpaceHash *hash, cpFloat celldim, int numcells, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
 cpSpatialIndex* cpSpaceHashNew(cpFloat celldim, int cells, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
 void cpSpaceHashResize(cpSpaceHash *hash, cpFloat celldim, int numcells);
 cpBBTree* cpBBTreeAlloc(void);
 cpSpatialIndex* cpBBTreeInit(cpBBTree *tree, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
 cpSpatialIndex* cpBBTreeNew(cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
 void cpBBTreeOptimize(cpSpatialIndex *index);
 void cpBBTreeSetVelocityFunc(cpSpatialIndex *index, cpBBTreeVelocityFunc func);
 cpSweep1D* cpSweep1DAlloc(void);
 cpSpatialIndex* cpSweep1DInit(cpSweep1D *sweep, cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
 cpSpatialIndex* cpSweep1DNew(cpSpatialIndexBBFunc bbfunc, cpSpatialIndex *staticIndex);
 void cpSpatialIndexFree(cpSpatialIndex *index);
 void cpSpatialIndexCollideStatic(cpSpatialIndex *dynamicIndex, cpSpatialIndex *staticIndex, cpSpatialIndexQueryFunc func, void *data);
 void cpCircleShapeSetRadius(cpShape *shape, cpFloat radius);
 void cpCircleShapeSetOffset(cpShape *shape, cpVect offset);
 void cpSegmentShapeSetEndpoints(cpShape *shape, cpVect a, cpVect b);
 void cpSegmentShapeSetRadius(cpShape *shape, cpFloat radius);
 void cpPolyShapeSetVerts(cpShape *shape, int count, cpVect *verts, cpTransform transform);
 void cpPolyShapeSetVertsRaw(cpShape *shape, int count, cpVect *verts);
 void cpPolyShapeSetRadius(cpShape *shape, cpFloat radius);
 cpSpace *cpHastySpaceNew(void);
 void cpHastySpaceFree(cpSpace *space);
 void cpHastySpaceSetThreads(cpSpace *space, unsigned long threads);
 unsigned long cpHastySpaceGetThreads(cpSpace *space);
 void cpHastySpaceStep(cpSpace *space, cpFloat dt);
 void cpPolylineFree(cpPolyline *line);
 cpBool cpPolylineIsClosed(cpPolyline *line);
 cpPolyline *cpPolylineSimplifyCurves(cpPolyline *line, cpFloat tol);
 cpPolyline *cpPolylineSimplifyVertexes(cpPolyline *line, cpFloat tol);
 cpPolyline *cpPolylineToConvexHull(cpPolyline *line, cpFloat tol);
 cpPolylineSet *cpPolylineSetAlloc(void);
 cpPolylineSet *cpPolylineSetInit(cpPolylineSet *set);
 cpPolylineSet *cpPolylineSetNew(void);
 void cpPolylineSetDestroy(cpPolylineSet *set, cpBool freePolylines);
 void cpPolylineSetFree(cpPolylineSet *set, cpBool freePolylines);
 void cpPolylineSetCollectSegment(cpVect v0, cpVect v1, cpPolylineSet *lines);
 cpPolylineSet *cpPolylineConvexDecomposition(cpPolyline *line, cpFloat tol);
