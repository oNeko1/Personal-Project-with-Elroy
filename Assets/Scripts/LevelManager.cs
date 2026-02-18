using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class LevelManager : MonoBehaviour
{
    public static LevelManager instance;

    [Header("Debug")]
    [SerializeField] public List<bool> levelBeat = new List<bool>();

    private string newLevelName;

    [SerializeField] private GameObject sceneTransition;

    void Awake()
    {
        if (instance == null)
        {
            instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
        }

        levelBeat.Add(false);
        levelBeat.Add(false);
        levelBeat.Add(false);
    }

    public void GoToScene(string levelName)
    {
        newLevelName = levelName;
        StartCoroutine(LoadingToScene());
    }

    IEnumerator LoadingToScene()
    {
        //sceneTransition.SetActive(true);
        sceneTransition.GetComponent<Animator>().SetTrigger("StartTransition");
        yield return new WaitForSeconds(1);
        SceneManager.LoadSceneAsync(newLevelName);
        sceneTransition.GetComponent<Animator>().SetTrigger("EndTransition");
    }
}
