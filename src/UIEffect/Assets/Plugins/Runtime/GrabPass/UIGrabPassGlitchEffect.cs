using UnityEngine;
using UnityEngine.UI;

namespace AscheLib.UI
{
    [AddComponentMenu("UI/Effects/GrabPass/GlitchEffect")]
    public class UIGrabPassGlitchEffect : UIGrabPassEffectBase
    {
        [SerializeField][Range(0, 60000)] private float _blockSize = 1;
        [SerializeField][Range(0, 60000)] private float _frequency = 1;
        [SerializeField][Range(0, 60000)] private float _seed = 1;
        public float BlockSize
        {
            get { return _blockSize; }
            set { _blockSize = value; SetDirty(); }
        }
        public float Frequency
        {
            get { return _frequency; }
            set { _frequency = value; SetDirty(); }
        }
        public float Seed
        {
            get { return _seed; }
            set { _seed = value; SetDirty(); }
        }

        protected override string ShaderName => "Glitch";

        protected override Color GetParameterColor()
            => new Color(_blockSize / 60000, _frequency / 60000, _seed / 60000, 0);
    }
}
