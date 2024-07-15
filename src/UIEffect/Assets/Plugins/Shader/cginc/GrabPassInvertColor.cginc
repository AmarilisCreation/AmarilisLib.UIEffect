#ifndef GRAB_PASS_INVERT_COLOR
#define GRAB_PASS_INVERT_COLOR
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
    resultColor.rgb = abs(threshold - resultColor.rgb);

    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, IN.color, resultColor);
}
#endif
