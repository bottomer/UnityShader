// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

//PBR_StepByStep_CGInclude
#define _BASE_VECTOR_VERT \
	float3 V = WorldSpaceViewDir(v.vertex); \
	V = normalize(V); \
	float3 N = mul((float3x3)unity_ObjectToWorld, v.normal); \
	N = normalize(N); \
	float3 L = WorldSpaceLightDir(v.vertex); \
	L = normalize(L);

//
#define _BASE_VECTOR_FRAG_VERT \
	o.pos = v.vertex; \
	o.nor = v.normal;

//use UNITY_PI
//#define PI 3.1415962653

#define _BASE_VECTOR_FRAG \
	float4 wPos = mul(unity_ObjectToWorld, i.pos); \
	float3 V = WorldSpaceViewDir(i.pos); \
	V = normalize(V); \
	float3 N = UnityObjectToWorldNormal(i.nor); \
	N = normalize(N); \
	float3 L = normalize(_WorldSpaceLightPos0.xyz); \
	float3 R = 2 * max(dot(N,L), 0) * N - L; \
	R = normalize(R); \
	float3 H = normalize(L + V); \
	float NL = dot(N, L); \
	float NV = dot(N, V); \
	float NH = dot(N, H); \
	float VR = dot(V, R); \
	float VH = dot(V, H); 
