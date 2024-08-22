using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using System;

namespace AscheLib.UI
{
    abstract public class UIGrabPassEffectBase : UIEffectBase
    {
        private enum UseMainColor
        {
            UseNotRGB,
            UseRGB,
            UseInvertRGB,
        }

        [SerializeField]
        private UseMainColor _useMainColor;
        [SerializeField]
        private bool _isUseNamedGrabPass = true;
        private bool? _beforeIsUseNamedGrabPass = null;
        Mask mask;

        protected override bool TargetMaterialChangeConditions
        {
            get
            {
                if(base.TargetMaterialChangeConditions || BeforeIsUseNamedGrabPass != _isUseNamedGrabPass)
                {
                    BeforeIsUseNamedGrabPass = _isUseNamedGrabPass;
                    return true;
                }
                return false;
            }
        }
        protected abstract string ShaderName { get; }
        protected override string ShaderPath { get { return string.Format(_isUseNamedGrabPass ? "Hidden/UI/GrabPass/Named/{0}" : "Hidden/UI/GrabPass/{0}", ShaderName); } }

        public bool BeforeIsUseNamedGrabPass
        {
            set
            {
                _beforeIsUseNamedGrabPass = value;
            }
            get
            {
                if(_beforeIsUseNamedGrabPass == null)
                {
                    _beforeIsUseNamedGrabPass = _isUseNamedGrabPass;
                }
                return _beforeIsUseNamedGrabPass.Value;
            }
        }
        private float UseMainColorParameter()
        {
            switch(_useMainColor)
            {
                case UseMainColor.UseNotRGB:
                    return 0;
                case UseMainColor.UseRGB:
                    return 0.5f;
                case UseMainColor.UseInvertRGB:
                    return 1;
            }
            return 0.5f;
        }

        protected override Color GetSystemParameterColor()
            => new Color(UseMainColorParameter(), 0, 0, 0);
    }
}
