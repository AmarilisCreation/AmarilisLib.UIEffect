#ifndef GRAB_PASS_CUTOFF
#define GRAB_PASS_CUTOFF
half4 cutoff(half4 mainTexColor, float invertMainTexColor, half4 color, half4 resultColor)
{
    resultColor *= color;
    mainTexColor.rgb = abs(invertMainTexColor - mainTexColor.rgb);
    half averageColor = (mainTexColor.r + mainTexColor.g + mainTexColor.b) / 3;
    resultColor.a *= averageColor * mainTexColor.a;

#ifdef UNITY_UI_ALPHACLIP
        clip (resultColor.a - 0.001);
#endif

    return resultColor;
}
#endif
