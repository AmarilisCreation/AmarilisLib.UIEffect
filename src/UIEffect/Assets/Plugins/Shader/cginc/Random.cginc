#ifndef GRAB_PASS_RANDOM
#define GRAB_PASS_RANDOM
float2 random(float2 st, int seed)
{
    float2 s = float2(dot(st, float2(127.1, 311.7)) + seed, dot(st, float2(269.5, 183.3)) + seed);
    return -1 + 2 * frac(sin(s) * 43758.5453123);
}

float perlin_noise(float2 st, int seed)
{
    float2 p = floor(st);
    float2 f = frac(st);

    float w00 = dot(random(p, seed), f);
    float w10 = dot(random(p + float2(1, 0), seed), f - float2(1, 0));
    float w01 = dot(random(p + float2(0, 1), seed), f - float2(0, 1));
    float w11 = dot(random(p + float2(1, 1), seed), f - float2(1, 1));

    float2 u = f * f * (3 - 2 * f);

    return lerp(lerp(w00, w10, u.x), lerp(w01, w11, u.x), u.y);
}
#endif
