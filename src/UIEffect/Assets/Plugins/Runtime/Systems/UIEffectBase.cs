using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using System;

namespace AscheLib.UI
{
    [ExecuteInEditMode]
    [RequireComponent(typeof(Graphic))]
    [RequireComponent(typeof(RectTransform))]
    [DisallowMultipleComponent]
    abstract public class UIEffectBase : UIBehaviour
    {
        private const string ParameterName = "_ParameterTexture";
        private const string SystemParameterName = "_SystemParameterTexture";

        Graphic _graphic;
        Material _targetMaterial;
        Texture2D _parameterTexture = null;
        Texture2D _systemParameterTexture = null;
        RectTransform _rectTransform = null;

        private Graphic TargetGraphic
        {
            get
            {
                if(_graphic == null)
                {
                    _graphic = GetComponent<Graphic>();
                }
                return _graphic;
            }
        }
        protected virtual bool TargetMaterialChangeConditions { get { return _targetMaterial == null; } }
        protected Material TargetMaterial
        {
            get
            {
                if(TargetMaterialChangeConditions)
                {
                    _targetMaterial = new Material(Shader.Find(ShaderPath));
                    _targetMaterial.SetTexture(ParameterName, ParameterTexture);
                    _targetMaterial.SetTexture(SystemParameterName, SystemParameterTexture);
                }
                return _targetMaterial;
            }
        }
        public RectTransform RectTransform
        {
            get
            {
                if(_rectTransform == null)
                {
                    _rectTransform = GetComponent<RectTransform>();
                }
                return _rectTransform;
            }
        }
        private Texture2D ParameterTexture
        {
            get
            {
                if(_parameterTexture == null)
                {
                    _parameterTexture = new Texture2D(2, 2, TextureFormat.ARGB32, false);
                }
                return _parameterTexture;
            }
        }
        private Texture2D SystemParameterTexture
        {
            get
            {
                if(_systemParameterTexture == null)
                {
                    _systemParameterTexture = new Texture2D(2, 2, TextureFormat.ARGB32, false);
                }
                return _systemParameterTexture;
            }
        }

        protected abstract string ShaderPath { get; }

        protected override void OnEnable()
        {
            base.OnEnable();
            ModifyMaterial();
            SetDirty();
        }

        protected override void OnDisable()
        {
            base.OnDisable();
            ModifyMaterial();
        }

        protected override void OnValidate()
        {
            base.OnValidate();
            ModifyMaterial();
            SetDirty();
        }
        protected override void OnDidApplyAnimationProperties()
        {
            base.OnDidApplyAnimationProperties();
            ModifyMaterial();
            SetDirty();
        }

        protected virtual void SetDirty()
        {
            var color = GetParameterColor();
            for(int y = 0; y < ParameterTexture.height; y++)
            {
                for(int x = 0; x < ParameterTexture.width; x++)
                {
                    ParameterTexture.SetPixel(x, y, color);
                }
            }
            ParameterTexture.Apply();

            var systemColor = GetSystemParameterColor();
            for(int y = 0; y < SystemParameterTexture.height; y++)
            {
                for(int x = 0; x < SystemParameterTexture.width; x++)
                {
                    SystemParameterTexture.SetPixel(x, y, systemColor);
                }
            }
            SystemParameterTexture.Apply();
        }

        protected void ModifyMaterial()
        {
            TargetGraphic.material = isActiveAndEnabled ? TargetMaterial : null;
        }

        /// <summary>
        /// With SetFloat, even if you change the value when it is under Mask, it will not be applied, so the information is passed as the color of Texture.
        /// </summary>
        /// <returns>Numerical value to be passed as color information</returns>
        protected abstract Color GetParameterColor();
        protected abstract Color GetSystemParameterColor();
    }
}
