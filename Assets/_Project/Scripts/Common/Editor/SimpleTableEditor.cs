using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(SimpleTable), true)]
public class SimpleTableEditor : Editor {
	private SimpleTable _ctr;
	public override void OnInspectorGUI()
	{
		DrawDefaultInspector();
		_ctr = (SimpleTable)target;

		GUILayout.Space (20);

		if (GUILayout.Button("Fresh", GUILayout.Height(30)))
		{
			_ctr.Fresh ();
		}
	}
}

