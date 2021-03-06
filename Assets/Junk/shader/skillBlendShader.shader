﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/skillBlendShader" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_SkillTex ("Base (RGB)", 2D) = "white" {}
	}
	
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert 
		    #pragma fragment frag
		    #include "UnityCG.cginc"
		    struct VertIn {
	        	float4 vertex : POSITION;
	        	float4 texcoord : TEXCOORD0;
	        };
	        struct v2f {
	        	fixed4 pos : SV_POSITION;
	        	fixed2 uv : TEXCOORD0;
	   		};
	        uniform sampler2D _MainTex;
	        uniform sampler2D _SkillTex;

			uniform float _SkillLightCoff;


	        v2f vert(VertIn v) 
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = MultiplyUV(UNITY_MATRIX_TEXTURE0, v.texcoord);
				
				return o;
			}
			fixed4 frag(v2f i) : Color {
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed4 skillLight = tex2D(_SkillTex, i.uv);
				fixed4 newCol;
				newCol.rgb = col.rgb*(1+skillLight.rgb*_SkillLightCoff);
				newCol.a = col.a;
				return newCol;
			}
	        
		    ENDCG
		}
		
	} 
	FallBack "Diffuse"
}
