#ifndef GRAB_PASS_FROSTED_GLASS
#define GRAB_PASS_FROSTED_GLASS
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
half4 getXShiftedColor(float4 vpos, float factor, float weight, float shiftX) : SV_Target
{
    float4 position = vpos;
    position.x += _GrabTexture_TexelSize.x * shiftX * factor;
    return tex2D(_GrabTexture, UNITY_PROJ_COORD(position.xy)) * weight;
}
half4 frag_x(v2f IN, UNITY_VPOS_TYPE vpos : VPOS) : SV_Target
{
    half4 parameter = tex2D(_ParameterTexture, float2(0, 0));
    half4 systemParameter = tex2D(_SystemParameterTexture, float2(0, 0));
    fixed4 factor = parameter.r * 5;

    half4 resultColor = 0;
    vpos.xy /= _ScreenParams.xy;
    resultColor += getXShiftedColor(vpos, factor, 0.05, 4.0);
    resultColor += getXShiftedColor(vpos, factor, 0.09, 3.0);
    resultColor += getXShiftedColor(vpos, factor, 0.12, 2.0);
    resultColor += getXShiftedColor(vpos, factor, 0.15, 1.0);
    resultColor += getXShiftedColor(vpos, factor, 0.18, 0.0);
    resultColor += getXShiftedColor(vpos, factor, 0.15, -1.0);
    resultColor += getXShiftedColor(vpos, factor, 0.12, -2.0);
    resultColor += getXShiftedColor(vpos, factor, 0.09, -3.0);
    resultColor += getXShiftedColor(vpos, factor, 0.05, -4.0);

    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, IN.color, resultColor);
}
half4 getYShiftedColor(float4 vpos, float param, float weight, float shiftY) : SV_Target
{
    float4 position = vpos;
    position.y += _GrabTexture_TexelSize.y * shiftY * param;
    return tex2D(_GrabTexture, UNITY_PROJ_COORD(position.xy)) * weight;
}
half4 frag_y(v2f IN, UNITY_VPOS_TYPE vpos : VPOS) : SV_Target
{
    half4 parameter = tex2D(_ParameterTexture, float2(0, 0));
    half4 systemParameter = tex2D(_SystemParameterTexture, float2(0, 0));
    fixed4 factor = parameter.r * 5;

    half4 resultColor = 0;
    vpos.xy /= _ScreenParams.xy;
    resultColor += getYShiftedColor(vpos, factor, 0.05, 4.0);
    resultColor += getYShiftedColor(vpos, factor, 0.09, 3.0);
    resultColor += getYShiftedColor(vpos, factor, 0.12, 2.0);
    resultColor += getYShiftedColor(vpos, factor, 0.15, 1.0);
    resultColor += getYShiftedColor(vpos, factor, 0.18, 0.0);
    resultColor += getYShiftedColor(vpos, factor, 0.15, -1.0);
    resultColor += getYShiftedColor(vpos, factor, 0.12, -2.0);
    resultColor += getYShiftedColor(vpos, factor, 0.09, -3.0);
    resultColor += getYShiftedColor(vpos, factor, 0.05, -4.0);

    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, IN.color, resultColor);
}

#endif
