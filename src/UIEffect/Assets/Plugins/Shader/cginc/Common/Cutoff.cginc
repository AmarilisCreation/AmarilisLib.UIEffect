#ifndef GRAB_PASS_CUTOFF
#define GRAB_PASS_CUTOFF

half4 cutoff(half4 mainTexColor, float useMainTexRGB, half4 resultColor)
{
    float useMainTexColor = useMainTexRGB * 2.0 - 1.0;

    half3 invertedColor = 1.0 - mainTexColor.rgb;
    half3 selectedColor = lerp(mainTexColor.rgb, invertedColor, step(0.5, abs(useMainTexColor)));

    half averageColor = lerp(
        (selectedColor.r + selectedColor.g + selectedColor.b) / 3.0,
        1.0,
        step(useMainTexColor, -0.5)
    );
    
    resultColor.a *= averageColor * mainTexColor.a;

#ifdef UNITY_UI_ALPHACLIP
    clip(resultColor.a - 0.001);
#endif

    return resultColor;
}

#endif
