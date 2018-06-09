Shader "001_PBR_StepByStep/005_Cook-Torrance"
{
	Properties
	{
		_Color ("Color", Color) = (1, 1, 1, 1)
		_MainTex ("Texture", 2D) = "white" {}
		_m ("Shinniness", Float) = 20
		_kd ("Widegt of Diffuse", Range(0,1)) = 0.5
		_ks ("Widegt of Specular", Range(0,1)) = 0.5
		_rough ("Roughness", Range(0,1)) = 0.5
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
			float _rough;
			
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
				//lambert diffuse
				float ln = max(0, NL);
				col.rgb *= _kd * (ln * _LightColor0.rgb + ambient);
				//phong specular
				float f = 0.1;
				//注释back，似乎没有影响
				//bool back = (NV>0)&&(ln>0);
				//粗糙度，越大越粗糙
				//float m = 0.5;
				//if(back){
					//防止分母为0
					_rough = lerp(0.0000001, 1, _rough);
					float temp = (NH * NH - 1)/(_rough * _rough * NH * NH);
					//粗糙度
					float roughness = (exp(temp)/pow(_rough,2)*pow(NH,4));
					float a = (2 * NH * NV) / VH;
					float b = (2 * NH * ln) / VH;
					float geometric = min(a,b);
					//几何衰减系数
					geometric = min(1, geometric);

					//fresnel反射系数
					float fresnelCoe = f +(1-f)*pow(1-VH,5.0);
					float rs = (fresnelCoe * geometric * roughness)/(NV*ln);
					float3 specularColor = rs * _LightColor0.xyz * ln * _ks;
					col.rgb += specularColor;
				//}


				return saturate(col);
			}
			ENDCG
		}
	}
}