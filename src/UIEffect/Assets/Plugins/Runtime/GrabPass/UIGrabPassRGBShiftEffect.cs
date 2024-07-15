using UnityEngine;
using UnityEngine.UI;

namespace AscheLib.UI
{
    [AddComponentMenu("UI/Effects/GrabPass/RGBShiftEffect")]
    public class UIGrabPassRGBShiftEffect : UIGrabPassEffectBase
    {
        [SerializeField][Range(0, 1)] private float _intensity = 1;
        public float Intensity
        {
            get { return _intensity; }
            set { _intensity = value; SetDirty(); }
        }

        protected override string ShaderName => "RGBShift";

        protected override Color GetParameterColor()
            => new Color(_intensity, 0, 0, 0);
    }
}
