#ifndef GRAB_PASS_UV_SCROLL
#define GRAB_PASS_UV_SCROLL

sampler2D _GrabTexture;
float4 _GrabTexture_TexelSize;
sampler2D _MainTex;
sampler2D _UVScrollTex;
sampler2D _ParameterTexture;
sampler2D _SystemParameterTexture;

half4 frag(v2f IN) : SV_Target
{
    half4 parameter = tex2D(_ParameterTexture, float2(0, 0));
    half4 systemParameter = tex2D(_SystemParameterTexture, float2(0, 0));
    float rotationAngle = parameter.r * 3.14159265 * 2.0;
    float strength = parameter.g;
    float blend = 2.0 * parameter.b - 1.0;
    float2 center = float2(0.5, 0.5);
    float2 uv = IN.texcoord - center;
    float cosAngle = cos(rotationAngle);
    float sinAngle = sin(rotationAngle);
    
    float2 rotatedUV;
    rotatedUV.x = uv.x * cosAngle - uv.y * sinAngle;
    rotatedUV.y = uv.x * sinAngle + uv.y * cosAngle;
    rotatedUV += strength;
    rotatedUV += center;
    
    half4 grabColor = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(IN.grabPos));
    half4 uvScrollColor = tex2D(_UVScrollTex, rotatedUV) * IN.color;
    
    half4 resultColor = grabColor + uvScrollColor * uvScrollColor.a * blend;
    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, resultColor);
}
#endif
