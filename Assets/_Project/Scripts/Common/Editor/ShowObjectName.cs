using UnityEngine;
using System.Collections;
using UnityEditor;

public class ShowObjectName : Editor {

	[DrawGizmo(GizmoType.InSelectionHierarchy | GizmoType.NotInSelectionHierarchy)]
	static void DrawGameObjectName(Transform transform, GizmoType gizmoType)
	{   
		if(transform.GetComponent<MeshRenderer>()!= null)
			Handles.Label(transform.position, transform.gameObject.name);
	}
}