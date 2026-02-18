using System.Xml.Serialization;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.EventSystems;

public class Button : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler, IPointerDownHandler, IPointerUpHandler
{
    [Header("Settings")]
    [SerializeField] public UnityEvent onClick;

    private Animator anim;
    private bool isHovering;

    private void Awake()
    {
        anim = GetComponent<Animator>();
    }

    private void Start()
    {
        isHovering = false;
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        isHovering = true;
        anim.SetTrigger("OnHover");
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        isHovering = false;
        anim.SetTrigger("Revert");
    }

    public void OnPointerDown(PointerEventData eventData)
    {
        anim.SetTrigger("OnClick");
    }

    public void OnPointerUp(PointerEventData eventData)
    {
        onClick.Invoke();

        if (isHovering) anim.SetTrigger("OnHover");
        else anim.SetTrigger("Revert");
    }
}
