using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class SimpleTable : MonoBehaviour {
	public float xStep = 1f;
	public float yStep = 2f;
	public int intRowNum = 10;
	private int intColNum;

	private List<Transform> transList = new List<Transform> ();

	public void Fresh(){
		transList = new List<Transform> ();
		int num = transform.childCount;
		intRowNum = intRowNum > num ? num : intRowNum;
		intColNum = Mathf.CeilToInt (num / intRowNum);
		float xStart = - xStep * (intRowNum - 1) / 2;
		float zStart = - yStep * (intColNum - 1) / 2;
		Vector3 vPos = Vector3.zero;
		for (int i = 0; i < num; i++) {
			transList.Add (transform.GetChild(i));
			vPos.x = xStart + xStep * (i % intRowNum);
			vPos.z = zStart - yStep * (Mathf.Floor(i / intRowNum));
			transList [i].position = vPos;
		}
	}

	void OnEnable () {
		Fresh ();
	}
}

