#ifndef GRAB_PASS_BLOOM
#define GRAB_PASS_BLOOM
sampler2D _GrabTexture;
float4 _GrabTexture_TexelSize;
sampler2D _MainTex;
sampler2D _ParameterTexture;
sampler2D _SystemParameterTexture;

half4 frag_extract(v2f IN) : SV_Target
{
    half4 parameter = tex2D(_ParameterTexture, float2(0, 0));
    half4 systemParameter = tex2D(_SystemParameterTexture, float2(0, 0));
    float threshold = parameter.g;
    float strength = parameter.b * 10;
	
    half4 resultColor = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos));
    float bright = (resultColor.r + resultColor.g + resultColor.b) / 3;
    float tmp = step(threshold, bright);
	
    resultColor *= tmp * strength;
    resultColor += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos));
	
    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, IN.color, resultColor);
}
#endif
