#ifndef GRAB_PASS_MOSAIC
#define GRAB_PASS_MOSAIC

struct appdata_t
{
    float4 vertex : POSITION;
    float4 color : COLOR;
    float2 texcoord : TEXCOORD0;
};
struct v2f
{
    float4 grabPos : TEXCOORD0;
    half2 texcoord : TEXCOORD1;
    fixed4 color : COLOR;
};

sampler2D _GrabTexture;
float4 _GrabTexture_TexelSize;
sampler2D _MainTex;
sampler2D _ParameterTexture;
sampler2D _SystemParameterTexture;

v2f vert(appdata_t IN, out float4 vertex : SV_POSITION)
{
    v2f OUT;
    vertex = UnityObjectToClipPos(IN.vertex);
    OUT.grabPos = ComputeGrabScreenPos(vertex);
    OUT.texcoord = IN.texcoord;
    OUT.color = IN.color;
    return OUT;
}
half4 frag(v2f IN, UNITY_VPOS_TYPE vpos : VPOS) : SV_Target
{
    half4 parameter = tex2D(_ParameterTexture, float2(0, 0));
    half4 systemParameter = tex2D(_SystemParameterTexture, float2(0, 0));
    float blockNum = parameter.r * 1000;

    vpos.xy /= _ScreenParams.xy;
    float4 f = floor(vpos * blockNum);
    fixed size = 1.0 / blockNum;

    float4 leftBottomPosision = f / blockNum;
    float4 leftTopPosition = leftBottomPosision + float4(0.0, size, 0.0, 0.0);
    float4 rightBottomPosition = leftBottomPosision + float4(size, 0.0, 0.0, 0.0);
    float4 rightTopPosition = leftBottomPosision + float4(size, size, 0.0, 0.0);
	
    half4 resultColor = (
            tex2D(_GrabTexture, UNITY_PROJ_COORD(leftBottomPosision.xy)) +
            tex2D(_GrabTexture, UNITY_PROJ_COORD(leftTopPosition.xy)) +
            tex2D(_GrabTexture, UNITY_PROJ_COORD(rightBottomPosition.xy)) +
            tex2D(_GrabTexture, UNITY_PROJ_COORD(rightTopPosition.xy))) / 4.0;
    resultColor *= IN.color;
	
    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, resultColor);
}
#endif
