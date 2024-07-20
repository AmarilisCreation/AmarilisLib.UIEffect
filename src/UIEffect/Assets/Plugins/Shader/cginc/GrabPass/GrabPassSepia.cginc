#ifndef GRAB_PASS_SEPIA
#define GRAB_PASS_SEPIA
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

    half4 resultColor = 0;
    half4 color = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos));
    resultColor.r = color.r * 0.393 + color.g * 0.769 + color.b * 0.189;
    resultColor.g = color.r * 0.349 + color.g * 0.686 + color.b * 0.168;
    resultColor.b = color.r * 0.272 + color.g * 0.534 + color.b * 0.131;
    resultColor.a = 1;
    resultColor.rgb = lerp(color.rgb, resultColor, threshold);
    resultColor *= IN.color;

    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, resultColor);
}
#endif
