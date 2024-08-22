using UnityEngine;
using UnityEngine.UI;

namespace AscheLib.UI
{
    [AddComponentMenu("UI/Effects/Overlap/UVScrollEffect")]
    public class UIGrabPassUVScrollEffect : UIGrabPassEffectBase
    {
        public enum BlendType
        {
            Add,
            Sub
        }
        [SerializeField][Range(0, 360)] private float _rotationAngle = 0;
        [SerializeField][Range(0, 1)] private float _scroll = 0;
        [SerializeField][Range(0, 1)] private float _strength = 0;
        [SerializeField] private BlendType _blendType = BlendType.Add;
        [SerializeField] private Texture _scrollTargetTexture;
        public float RotationAngle
        {
            get { return _rotationAngle; }
            set { _rotationAngle = value; SetDirty(); }
        }
        public float Scroll
        {
            get { return _scroll; }
            set { _scroll = value; SetDirty(); }
        }
        public float Strength
        {
            get { return _strength; }
            set { _strength = value; SetDirty(); }
        }
        public BlendType Blend
        {
            get { return _blendType; }
            set { _blendType = value; SetDirty(); }
        }

        protected override string ShaderName => "UVScroll";

        protected override void SetDirty()
        {
            base.SetDirty();
            TargetMaterial.SetTexture("_UVScrollTex", _scrollTargetTexture);
        }

        protected override Color GetParameterColor()
            => new Color((_rotationAngle / 360) % 1, _scroll % 1, _strength, _blendType == BlendType.Add ? 1 : 0);
    }
}
