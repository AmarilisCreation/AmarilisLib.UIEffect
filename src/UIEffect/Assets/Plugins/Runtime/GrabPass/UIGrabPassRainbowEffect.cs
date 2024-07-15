using UnityEngine;
using UnityEngine.UI;

namespace AscheLib.UI
{
    [AddComponentMenu("UI/Effects/GrabPass/RainbowEffect")]
    public class UIGrabPassRainbowEffect : UIGrabPassEffectBase
    {
        [SerializeField][Range(0, 1)] private float _threshold = 1;
        [SerializeField][Range(0, 60000)] private float _seed = 1;
        [SerializeField][Range(0, 10)] private float _fineness = 1;
        public float Threshold
        {
            get { return _threshold; }
            set { _threshold = value; SetDirty(); }
        }
        public float Seed
        {
            get { return _seed; }
            set { _seed = value; SetDirty(); }
        }
        public float Fineness
        {
            get { return _fineness; }
            set { _fineness = value; SetDirty(); }
        }

        protected override string ShaderName => "Rainbow";

        protected override Color GetParameterColor()
            => new Color(_threshold % 1, _seed / 60000, _fineness / 10, 0);
    }
}
