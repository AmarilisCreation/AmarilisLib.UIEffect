#ifndef GRAB_PASS_RGB_SHIFT
#define GRAB_PASS_RGB_SHIFT
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

    half4 resultColor = 1;
    half2 uvR = (IN.grabPos.xy / IN.grabPos.w) + intensity * half2(0.5, 0.5);
    half2 uvG = (IN.grabPos.xy / IN.grabPos.w) + intensity * half2(0.0, -0.5);
    half2 uvB = (IN.grabPos.xy / IN.grabPos.w) + intensity * half2(-0.5, 0.5);

    resultColor.r = tex2D(_GrabTexture, uvR).r;
    resultColor.g = tex2D(_GrabTexture, uvG).g;
    resultColor.b = tex2D(_GrabTexture, uvB).b;

    half4 originalColor = tex2D(_MainTex, IN.texcoord);

    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, IN.color, resultColor);
}
#endif