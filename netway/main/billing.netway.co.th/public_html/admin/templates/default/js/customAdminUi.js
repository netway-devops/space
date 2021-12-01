window.dataJSON;
$(function () {
  $(document).ready(function () {
    console.log("Debug");
    getJSONFile();

    $(document).on("click", "button.static-button", function () {
      const keyIndex = $(this).data("key");
      const typeEvent = `${$(this).data("type")}StaticButton`;
      const buttonName = $(this).text();
      const ajaxGetRoute =
        window.dataJSON[typeEvent][keyIndex][buttonName].ajaxRequest;

      callSecureAxiosRoute(ajaxGetRoute)
        .then((result) => {
          console.log("result: ", result);
        })
        .catch((err) => {
          console.log("err.response: ", err.response);
        });
    });
  });
});

function getJSONFile(callback) {
  $.getJSON(
    "/7944web/templates/default/js/customAdminUi.json",
    function (data) {
      setDataToVar(data);
      createEvent(data);
    }
  );
}

function setDataToVar(dataJSON) {
  window.dataJSON = dataJSON;
}

function createEvent(dataJSON, callOfEvent) {
  console.log("dataJSON: ", dataJSON);
  $.map(dataJSON, function (indexElement, typeEvent) {
    switch (typeEvent) {
      case "disables":
        $.each(indexElement, async function (indexInArray, $DisablesElement) {
          if (callOfEvent) {
            var txtResponseFind = await findOfElement($DisablesElement);
            await regisEventDisable(txtResponseFind);
          } else {
            regisEventDisable($DisablesElement);
          }
        });
        break;
      case "readonly":
        $.each(indexElement, async function (indexInArray, $ReadOnlyElement) {
          if (callOfEvent) {
            var txtResponseFind = await findOfElement($ReadOnlyElement);
            await regisEventReadOnly(txtResponseFind);
          } else {
            regisEventReadOnly($ReadOnlyElement);
          }
        });
        break;
      case "hidden":
        $.each(indexElement, async function (indexInArray, $HiddenElement) {
          // Fix: Can't use :parent.
          var matchParent = $HiddenElement.match(":parent");
          if (matchParent) {
            $HiddenElement = $HiddenElement.replace(":parent", "");
            $HiddenElement = $($HiddenElement).parent();
          }

          if (callOfEvent) {
            var txtResponseFind = await findOfElement($HiddenElement);
            await regisEventHidden(txtResponseFind);
          } else {
            regisEventHidden($HiddenElement);
          }
        });

        break;

      case "link":
        $.each(indexElement, async function (indexInArray, $LinkElement) {
          if (callOfEvent) {
            var txtResponseFind = await findOfElement($LinkElement);
            await regisEventLink(txtResponseFind);
          } else {
            regisEventLink($LinkElement);
          }
        });

        break;

      case "prependStaticText":
        buildStaticText(indexElement, "prepend");

        break;

      case "appendStaticText":
        buildStaticText(indexElement, "append");

        break;

      case "prependAjaxText":
        buildAjaxText(indexElement, "prepend");
        break;

      case "appendAjaxText":
        buildAjaxText(indexElement, "append");

        break;

      case "prependStaticButton":
        buildStaticButton(indexElement, "prepend");
        break;

      case "appendStaticButton":
        buildStaticButton(indexElement, "append");

        break;
      case "callAfterEvent":
        $.each(indexElement, function (indexInArray, valueOfEventAfterClick) {
          var $Element = document.querySelector(indexInArray);
          if ($Element) {
            var dynamicEventListener =
              $Element.nodeName == "SELECT" ? "change" : "mouseup";
            $Element.addEventListener(dynamicEventListener, function (e) {
              createEvent(valueOfEventAfterClick, "callAfterEvent");
            });
          }
        });
        break;
    }
  });

  function regisEventDisable($DisablesElement) {
    $($DisablesElement).each(function (index, element) {
      var typeInput = element.tagName;
      if (typeInput == "A") {
        $($DisablesElement).addClass("disabled");
      } else {
        if ($($DisablesElement).hasClass("haspicker")) {
          $($DisablesElement).datePicker({ createButton: false });
        }
        element.disabled = true;
      }
    });
  }

  function regisEventLink($LinkElement) {
    $($LinkElement).click(function (event) {
      alert("ยังไม่เปิดใช้งาน");
      event.preventDefault();
      return false;
    });
  }

  function regisEventReadOnly($ReadOnlyElement) {
    $($ReadOnlyElement).each(function (index, element) {
      var typeInput = element.tagName;
      switch (typeInput) {
        case "SELECT":
          element.ariaDisabled = true;
          break;

        default:
          element.readOnly = true;
          $(element).attr("readonly", true);

          if ($($ReadOnlyElement).hasClass("haspicker")) {
            $($ReadOnlyElement).datePicker({ createButton: false });
          }

          break;
      }

      $(document).on(
        "click",
        "[type='checkbox'][readonly='readonly']",
        function (e) {
          e.preventDefault();
        }
      );
    });
  }

  function regisEventHidden(txtHiddenElement) {
    $(txtHiddenElement).each(function (index, element) {
      switch (element.type) {
        case "checkbox":
          $(element).hide();
          $(`label[for='${element.id}']`).hide();
          break;

        default:
          if ($(element).hasClass("d-flex")) {
            $(element).removeClass("d-flex");
          }

          $(element).hide();
          break;
      }
    });
  }
}

function findOfElement($ElementOnLoad) {
  return new Promise((resolve) => {
    var checkDiv = setInterval(function () {
      var $thisElem = $(`${$ElementOnLoad}`);
      if ($thisElem.length > 0) {
        clearInterval(checkDiv);
        resolve($ElementOnLoad);
      }
    }, 2);
  });
}

function buildStaticText(indexElement, typeEvent) {
  $.each(indexElement, function (indexInArray, valueOfElement) {
    $(indexInArray)[typeEvent](buildDOMPurifyText(valueOfElement.message));
  });
}

function buildAjaxText(indexElement, typeEvent) {
  for (const key in indexElement) {
    if (Object.hasOwnProperty.call(indexElement, key)) {
      const ajaxRequest = indexElement[key].messageFromAjaxRequest;
      callSecureAxiosRoute(ajaxRequest)
        .then((result) => {
          $(key)[typeEvent](buildDOMPurifyText(result.data.messageResponse));
        })
        .catch((error) => {
          console.log("error: ", error.response);
        });
    }
  }
}

function buildStaticButton(indexElement, typeEvent) {
  $.each(indexElement, function (indexInArray, valueOfElement) {
    for (const key in valueOfElement) {
      if (Object.hasOwnProperty.call(valueOfElement, key)) {
        const index = indexInArray;
        const button = valueOfElement;
        const { buttonClass } = button[key];

        var buildButtonTag = `<button type="button" class="btn ${buttonClass} static-button" data-type="${typeEvent}" data-key="${index}" >${key}</button>`;
        var scanDOMPurify = DOMPurify.sanitize(buildButtonTag, {
          ALLOWED_TAGS: ["button"],
        });

        $(indexInArray)[typeEvent](scanDOMPurify);
      }
    }
  });
}

function buildDOMPurifyText(messageResponse) {
  return DOMPurify.sanitize(messageResponse, {
    ALLOWED_TAGS: [
      "h1",
      "h2",
      "h3",
      "h4",
      "h5",
      "h6",
      "span",
      "p",
      "b",
      "i",
      "u",
    ],
    ALLOWED_ATTR: ["style", "class"],
  });
}

function callSecureAxiosRoute(urlRoute) {
  return axios.get(urlRoute);
}

