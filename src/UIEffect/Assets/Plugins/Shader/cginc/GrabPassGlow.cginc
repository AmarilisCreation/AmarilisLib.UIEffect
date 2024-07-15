#ifndef GRAB_PASS_GLOW
#define GRAB_PASS_GLOW

sampler2D _GrabTexture;
float4 _GrabTexture_TexelSize;
sampler2D _MainTex;
sampler2D _ParameterTexture;
sampler2D _SystemParameterTexture;

half4 frag(v2f IN) : SV_Target
{
    half4 parameter = tex2D(_ParameterTexture, float2(0.5, 0.5));
    half4 systemParameter = tex2D(_SystemParameterTexture, float2(0.5, 0.5));
    float threshold = parameter.r;
    float strength = parameter.g * 10;
    
    half4 resultColor = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos));
    float bright = (resultColor.r + resultColor.g + resultColor.b) / 3;
    float tmp = step(threshold, bright);
    
    half4 glowColor = resultColor * tmp;
    
    half4 blurredGlow = half4(0, 0, 0, 0);
    float2 texelSize = _GrabTexture_TexelSize.xy;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(-2 * texelSize.x, -2 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(-2 * texelSize.x, -1 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(-2 * texelSize.x, 0, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(-2 * texelSize.x, 1 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(-2 * texelSize.x, 2 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(-1 * texelSize.x, -2 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(-1 * texelSize.x, -1 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(-1 * texelSize.x, 0, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(-1 * texelSize.x, 1 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(-1 * texelSize.x, 2 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(0, -2 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(0, -1 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(0, 0, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(0, 1 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(0, 2 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(1 * texelSize.x, -2 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(1 * texelSize.x, -1 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(1 * texelSize.x, 0, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(1 * texelSize.x, 1 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(1 * texelSize.x, 2 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(2 * texelSize.x, -2 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(2 * texelSize.x, -1 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(2 * texelSize.x, 0, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(2 * texelSize.x, 1 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    blurredGlow += tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos + float4(2 * texelSize.x, 2 * texelSize.y, 0, 0))) * (1.0 / 25.0) * tmp;
    resultColor += blurredGlow * strength;

    // 最終的な色を返す
    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, IN.color, resultColor);
}
#endif