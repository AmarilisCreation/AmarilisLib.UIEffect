﻿using UnityEngine;
using UnityEngine.UI;

namespace AscheLib.UI
{
    [AddComponentMenu("UI/Effects/GrabPass/GrayscaleEffect")]
    public class UIGrabPassGrayscaleEffect : UIGrabPassEffectBase
    {
        [SerializeField][Range(0, 1)] private float _threshold = 1;
        public float Threshold
        {
            get { return _threshold; }
            set { _threshold = value; SetDirty(); }
        }

        protected override string ShaderName => "Grayscale";

        protected override Color GetParameterColor()
            => new Color(_threshold, 0, 0, 0);
    }
}
