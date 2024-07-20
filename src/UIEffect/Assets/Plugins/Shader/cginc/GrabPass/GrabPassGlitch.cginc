#ifndef GRAB_PASS_GLITCH
#define GRAB_PASS_GLITCH
sampler2D _GrabTexture;
float4 _GrabTexture_TexelSize;
sampler2D _MainTex;
sampler2D _ParameterTexture;
sampler2D _SystemParameterTexture;

float noise_random(float2 st, int seed)
{
    return -1.0 + 2.0 * perlin_noise(st, seed);
}

half4 frag(v2f IN) : SV_Target
{
    half4 parameter = tex2D(_ParameterTexture, float2(0, 0));
    half4 systemParameter = tex2D(_SystemParameterTexture, float2(0, 0));
    float blockSize = (1 - parameter.r + 0.0000001) * 100;
    float frequency = parameter.g * 10;
    half seed = parameter.b * 60000;

    float2 uv = UNITY_PROJ_COORD(IN.grabPos);

    float2 blockUV = floor(uv * blockSize) / blockSize;
    float noise = noise_random(blockUV, int(seed));
    noise += random(blockUV, int(seed)) * 0.3;
    float2 randomValue = noise_random(blockUV, int(seed));
    float sign = random(blockUV, int(seed)) < 0.5 ? -1.0 : 1.0;

    uv.x += sign * randomValue * frequency * sin(sin(frequency) * 0.5) * sin(-sin(noise) * 0.2) * frac(seed);

    half4 resultColor = tex2D(_GrabTexture, uv);
    resultColor *= IN.color;

    return cutoff(tex2D(_MainTex, IN.texcoord), systemParameter.r, resultColor);
}
#endif
