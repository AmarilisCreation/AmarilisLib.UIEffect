#ifndef GRAB_PASS_RAINBOW
#define GRAB_PASS_RAINBOW
sampler2D _GrabTexture;
float4 _GrabTexture_TexelSize;
sampler2D _MainTex;
sampler2D _ParameterTexture;
sampler2D _SystemParameterTexture;

fixed3 HUEtoRGB(in float h)
{
    float r = abs(h * 6 - 3) - 1;
    float g = 2 - abs(h * 6 - 2);
    float b = 2 - abs(h * 6 - 4);
    return saturate(float3(r, g, b));
}

half4 frag(v2f IN) : SV_Target
{
    half4 parameter = tex2D(_ParameterTexture, float2(0, 0));
    half4 systemParameter = tex2D(_SystemParameterTexture, float2(0, 0));
    float threshold = parameter.r;
    half seed = parameter.g * 60000;
    fixed fineness = parameter.b * 10;

    half4 resultColor = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos));
    float noise = perlin_noise(IN.texcoord * fineness, seed);
    float hue = frac(noise + threshold);
    fixed3 hueColor = HUEtoRGB(hue);

    resultColor.rgb += hueColor;
    resultColor.a = 1.0;

    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, IN.color, resultColor);
}
#endif
