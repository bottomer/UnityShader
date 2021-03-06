﻿Shader "001_PBR_StepByStep/006_InnerLit"
{
	Properties
	{
		_Color ("Color", Color) = (1, 1, 1, 1)
		_MainTex ("Texture", 2D) = "white" {}
		_m ("Shinniness", Float) = 20
		_kd ("Widegt of Diffuse", Range(0,1)) = 0.5
		_ks ("Widegt of Specular", Range(0,1)) = 0.5
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Tags {"LightMode" = "ForwardBase" }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			//#include "AutoLight.cginc"
			#include "PBR_StepByStep.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float4 pos : TEXCOORD1;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float4 pos : TEXCOORD1;
				float3 nor : TEXCOORD2;
			};


			uniform half4 _LightColor0;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed4 _Color;
			float _m;
			float _kd;
			float _ks;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				_BASE_VECTOR_FRAG_VERT
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = tex2D(_MainTex, i.uv) * _Color;
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb;
				_BASE_VECTOR_FRAG

				float3 light = lit(NL, NH, _m);
				col.rgb = col.rgb * _kd * (_LightColor0.rgb * light.y + ambient * light.x) +  _ks * _LightColor0.rgb * light.z;

				return saturate(col);
			}
			ENDCG
		}
	}
}