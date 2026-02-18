using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelNexter : MonoBehaviour
{
    public void GoToScene(string sceneName)
    {
        LevelManager.instance.GoToScene(sceneName);
    }

    public void ExitGame()
    {
        Application.Quit();
    }

    public void BeatLevel(int levelIndex)
    {
        FindObjectOfType<LevelManager>().levelBeat[levelIndex] = true;
    }
}
