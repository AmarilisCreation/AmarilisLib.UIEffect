#ifndef GRAB_PASS_GRAY_SCALE
#define GRAB_PASS_GRAY_SCALE
sampler2D _GrabTexture;
float4 _GrabTexture_TexelSize;
sampler2D _MainTex;
sampler2D _ParameterTexture;
sampler2D _SystemParameterTexture;

half4 frag(v2f IN) : SV_Target
{
    half4 parameter = tex2D(_ParameterTexture, float2(0, 0));
    half4 systemParameter = tex2D(_SystemParameterTexture, float2(0, 0));
    float threshold = parameter.r;

    half4 resultColor = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos));
    float gray = dot(resultColor.rgb, fixed3(0.299, 0.587, 0.114));
    resultColor.rgb = lerp(resultColor.rgb, gray, threshold);
    resultColor *= IN.color;

    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, resultColor);
}
#endif
