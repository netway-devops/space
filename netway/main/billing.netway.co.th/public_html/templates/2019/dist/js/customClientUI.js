window.dataJSON;

$(function () {
  $(document).ready(function () {
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
  $.getJSON("/templates/2019/dist/js/customClientUI.json", function (data) {
    createEvent(data);
  });
}

function createEvent(dataJSON) {
  window.dataJSON = dataJSON;

  $.map(dataJSON, function (indexElement, typeEvent) {
    switch (typeEvent) {
      case "disables":
        $.each(indexElement, function (indexInArray, valueOfElement) {
          $(valueOfElement).each(function (index, element) {
            var typeInput = element.tagName;
            if (typeInput == "A") {
              $(valueOfElement).addClass("disabled");
            } else {
              if ($(valueOfElement).hasClass("haspicker")) {
                $(valueOfElement).datePicker({ createButton: false });
              }
              element.disabled = true;
            }
          });
        });
        break;
      case "readonly":
        $.each(indexElement, function (indexInArray, valueOfElement) {
          $(valueOfElement).each(function (index, element) {
            var typeInput = element.tagName;

            switch (typeInput) {
              case "SELECT":
                element.ariaDisabled = true;
                break;

              default:
                element.readOnly = true;
                $(element).attr("readonly", true);

                if ($(valueOfElement).hasClass("haspicker")) {
                  $(valueOfElement).datePicker({ createButton: false });
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
        });
        break;
      case "hidden":
        $.each(indexElement, function (indexInArray, $HiddenElement) {
          // Fix: Can't use :parent.
          var matchParent = $HiddenElement.match(":parent");
          if (matchParent) {
            $HiddenElement = $HiddenElement.replace(":parent", "");
            $HiddenElement = $($HiddenElement).parent();
          }
          $($HiddenElement).each(function (index, element) {
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
        });

        break;

      case "link":
        $.each(indexElement, function (indexInArray, valueOfElement) {
          $(valueOfElement).click(function (event) {
            event.preventDefault();
            alert("ยังไม่เปิดใช้งาน");
          });
        });

        break;
      case "prependStaticText":
        buildStaticText(indexElement, "prepend");

        break;

      case "appendStaticText":
        buildStaticText(indexElement, "append");

        break;
    }
  });
}

function buildStaticText(indexElement, typeEvent) {
  $.each(indexElement, function (indexInArray, valueOfElement) {
    $(indexInArray)[typeEvent](buildDOMPurifyText(valueOfElement.message));
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
    ALLOWED_ATTR: ["style"],
  });
}

function callSecureAxiosRoute(urlRoute) {
  return axios.get(urlRoute);
}
