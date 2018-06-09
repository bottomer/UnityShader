using UnityEngine;
using System.Collections;
using UnityEditor;

public class ShowObjectName : Editor {

	[DrawGizmo(GizmoType.InSelectionHierarchy | GizmoType.NotInSelectionHierarchy)]
	static void DrawGameObjectName(Transform transform, GizmoType gizmoType)
	{   
		if(transform.GetComponent<MeshRenderer>()!= null)
			Handles.Label(transform.position - new Vector3(0f,0.6f, 0f), transform.gameObject.name);
	}
}