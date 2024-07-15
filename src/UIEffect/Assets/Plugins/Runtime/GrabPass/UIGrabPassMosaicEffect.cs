using UnityEngine;
using UnityEngine.UI;

namespace AscheLib.UI
{
    [AddComponentMenu("UI/Effects/GrabPass/MosaicEffect")]
    public class UIGrabPassMosaicEffect : UIGrabPassEffectBase
    {
        [SerializeField][Range(0, 1000)] private int _blockNum = 10;
        public int BlockNum
        {
            get { return _blockNum; }
            set { _blockNum = value; SetDirty(); }
        }

        protected override string ShaderName => "Mosaic";

        protected override Color GetParameterColor()
            => new Color(_blockNum / 1000.0f, 0, 0, 0);
    }
}
