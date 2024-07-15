using UnityEngine;
using UnityEngine.UI;

namespace AscheLib.UI
{
    [AddComponentMenu("UI/Effects/GrabPass/FrostedGlassEffect")]
    public class UIGrabPassFrostedGlassEffect : UIGrabPassEffectBase
    {
        [SerializeField][Range(0, 5)] private float _factor = 1;
        public float Factor
        {
            get { return _factor; }
            set { _factor = value; SetDirty(); }
        }

        protected override string ShaderName => "FrostedGlass";

        protected override Color GetParameterColor()
            => new Color(_factor / 5, 0, 0, 0);
    }
}
