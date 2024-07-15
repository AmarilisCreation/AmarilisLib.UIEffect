#ifndef GRAB_PASS_COMMON_STRUCT
#define GRAB_PASS_COMMON_STRUCT
struct appdata_t
{
    float4 vertex : POSITION;
    float4 color : COLOR;
    float2 texcoord : TEXCOORD0;
};
struct v2f
{
    float4 vertex : SV_POSITION;
    float4 grabPos : TEXCOORD0;
    half2 texcoord : TEXCOORD1;
    fixed4 color : COLOR;
    float4 worldPosition : TEXCOORD2;
};
v2f vert(appdata_t IN)
{
    v2f OUT;
    OUT.worldPosition = IN.vertex;
    OUT.vertex = UnityObjectToClipPos(IN.vertex);
    OUT.grabPos = ComputeGrabScreenPos(OUT.vertex);
    OUT.texcoord = IN.texcoord;
    OUT.color = IN.color;
    return OUT;
}
#endif
