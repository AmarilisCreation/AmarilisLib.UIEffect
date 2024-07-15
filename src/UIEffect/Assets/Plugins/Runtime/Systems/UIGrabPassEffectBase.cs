using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using System;

namespace AscheLib.UI
{
    abstract public class UIGrabPassEffectBase : UIEffectBase
    {
        private enum PriorityColor
        {
            White,
            Black,
        }
        private const string ParameterName = "_ParameterTexture";
        private const string SystemParameterName = "_SystemParameterTexture";

        [SerializeField]
        private PriorityColor _priorityColor;
        [SerializeField]
        private bool _isUseNamedGrabPass = true;
        private bool? _beforeIsUseNamedGrabPass = null;

        protected override bool TargetMaterialChangeConditions {
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
        private float InvertMainTexColor
            => _priorityColor == PriorityColor.White ? 0 : 1;

        protected override Color GetSystemParameterColor()
            => new Color(InvertMainTexColor, 0, 0, 0);
    }
}
