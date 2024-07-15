using UnityEngine;
using UnityEngine.UI;

namespace AscheLib.UI
{
    [AddComponentMenu("UI/Effects/GrabPass/GlowEffect")]
    public class UIGrabPassGlowEffect : UIGrabPassEffectBase
    {
        [SerializeField][Range(0, 1)] private float _threshold = 1;
        [SerializeField][Range(0, 10)] private float _strength = 1;
        public float Threshold
        {
            get { return _threshold; }
            set { _threshold = value; SetDirty(); }
        }
        public float Strength
        {
            get { return _strength; }
            set { _strength = value; SetDirty(); }
        }

        protected override string ShaderName => "Glow";

        protected override Color GetParameterColor()
            => new Color(_threshold, _strength / 10, 0, 0);
    }
}
