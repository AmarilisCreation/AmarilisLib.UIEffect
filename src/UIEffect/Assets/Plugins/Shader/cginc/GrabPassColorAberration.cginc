#ifndef GRAB_PASS_COLOR_ABERRATION
#define GRAB_PASS_COLOR_ABERRATION
sampler2D _GrabTexture;
float4 _GrabTexture_TexelSize;
sampler2D _MainTex;
sampler2D _ParameterTexture;
sampler2D _SystemParameterTexture;

half4 frag(v2f IN) : SV_Target
{
    half4 parameter = tex2D(_ParameterTexture, float2(0, 0));
    half4 systemParameter = tex2D(_SystemParameterTexture, float2(0, 0));
    float intensity = parameter.r;
    half4 resultColor = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos));

    half2 uvBase = UNITY_PROJ_COORD(IN.grabPos) - 0.5h;
    half2 uvR = uvBase * (1.0h - intensity * 2.0h) + 0.5h;

    resultColor.r = tex2D(_GrabTexture, uvR).r;
    half2 uvG = uvBase * (1.0h - intensity) + 0.5h;
    resultColor.g = tex2D(_GrabTexture, uvG).g;
	
    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, IN.color, resultColor);
}
#endif
