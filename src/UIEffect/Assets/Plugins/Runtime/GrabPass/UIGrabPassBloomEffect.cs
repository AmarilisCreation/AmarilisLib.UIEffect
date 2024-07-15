using UnityEngine;
using UnityEngine.UI;

namespace AscheLib.UI
{
    [AddComponentMenu("UI/Effects/GrabPass/BloomEffect")]
    public class UIGrabPassBloomEffect : UIGrabPassEffectBase
    {
        [SerializeField][Range(0, 5)] private float _factor = 1;
        [SerializeField][Range(0, 1)] private float _threshold = 1;
        [SerializeField][Range(0, 10)] private float _strength = 1;
        public float Factor
        {
            get { return _factor; }
            set { _factor = value; SetDirty(); }
        }
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

        protected override string ShaderName => "Bloom";

        protected override Color GetParameterColor()
            => new Color(_factor / 5, _threshold, _strength / 10, 0);
    }
}
