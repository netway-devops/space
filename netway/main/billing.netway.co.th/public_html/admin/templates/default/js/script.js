function forbidAccessBlock(message = "") {
  $(".isForbidAccess").block({
    message: message,
    css: {
      color: "#D1524C",
      textAlign: "right",
      width: "96%",
      border: "0px",
      backgroundColor: "rgba(255, 255, 255, 0)",
    },
    overlayCSS: {
      backgroundColor: "rgb(214 214 214)",
    },
  });
}
$(document).ready(function () {
  //block dropdown tax% in invoice ย้ายไปไว้ที่
});
