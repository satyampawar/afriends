var App, areNotificationsSupported, deleteSubscription, disablePush, enableNotificationBtn, enablePush, logToConsoleAndScreen, logger, processSubscription, refreshDeviceList, saveSubscription, setupServiceWorker, subscribe, unsubscribe,
  slice = [].slice;

logToConsoleAndScreen = function() {
  var args, level, message;
  level = arguments[0], message = arguments[1], args = 3 <= arguments.length ? slice.call(arguments, 2) : [];
  console[level].apply(console, [message].concat(slice.call(args)));
  return $(function() {
    var $container;
    $container = $("#errors-container").empty();
    return $("<div/>").addClass("message is-" + level).text(message).prependTo($container);
  });
};

logger = {
  warn: logToConsoleAndScreen.bind(window, "warn"),
  error: logToConsoleAndScreen.bind(window, "error")
};

areNotificationsSupported = function() {
  if (!(ServiceWorkerRegistration && "showNotification" in ServiceWorkerRegistration.prototype)) {
    logger.warn("Notifications aren't supported");
    return false;
  }
  if ((typeof Notification !== "undefined" && Notification !== null ? Notification.permission : void 0) === "denied") {
    logger.warn("Notifications are blocked on this device");
    return false;
  }
  if (!("PushManager" in window)) {
    logger.warn("Push messaging isn't supported");
    return false;
  }
  return true;
};

processSubscription = function(subscription) {
  enableNotificationBtn();
  if (subscription != null) {
    console.log("Existing subscription found", subscription);
    enablePush();
    return saveSubscription(subscription);
  }
};

saveSubscription = function(subscription) {
  var deviceData, ref, ref1;
  subscription = subscription.toJSON();
  deviceData = {
    endpoint: subscription.endpoint,
    p256dh: (ref = subscription.keys) != null ? ref.p256dh : void 0,
    auth: (ref1 = subscription.keys) != null ? ref1.auth : void 0
  };
  return $.ajax({
    url: "/devices",
    method: "POST",
    contentType: "application/json",
    dataType: "json",
    data: JSON.stringify({
      device: deviceData
    })
  }).then(console.log.bind(console, "Subscription saved")).then(refreshDeviceList).fail(logger.warn.bind(window, "Error saving subscription"));
};

deleteSubscription = function(subscription) {
  var endpoint;
  endpoint = subscription.toJSON().endpoint;
  return $.ajax({
    url: "/devices/" + (btoa(endpoint)),
    method: "DELETE",
    contentType: "application/json",
    dataType: "json"
  }).then(console.log.bind(console, "Subscription deleted")).then(refreshDeviceList).fail(logger.warn.bind(window, "Error deleting subscription"));
};

enableNotificationBtn = function() {
  return $(".js-notifications-btn").prop("disabled", false);
};

enablePush = function() {
  $(".js-notifications-btn").text("Disable notifications on this device");
  return App.isPushEnabled = true;
};

disablePush = function(maintainState) {
  if (maintainState == null) {
    maintainState = false;
  }
  $(".js-notifications-btn").text("Enable notifications on this device");
  if (!maintainState) {
    return App.isPushEnabled = false;
  }
};

refreshDeviceList = function() {
  var ref, ref1, ref2;
  return (ref = $("#devices-iframe").get(0)) != null ? (ref1 = ref.contentDocument) != null ? (ref2 = ref1.location) != null ? ref2.reload(true) : void 0 : void 0 : void 0;
};

setupServiceWorker = function(registration) {
  console.log("Service worker registered", registration);
  if (!areNotificationsSupported()) {
    return;
  }
  return registration.pushManager.getSubscription().then(processSubscription)["catch"](logger.error.bind(window, "Error checking subscription"));
};

subscribe = function() {
  return navigator.serviceWorker.ready.then(function(serviceWorkerRegistration) {
    return serviceWorkerRegistration.pushManager.subscribe({
      userVisibleOnly: true
    }).then(function(subscription) {
      enableNotificationBtn();
      enablePush();
      return saveSubscription(subscription);
    })["catch"](function(error) {
      if ((typeof Notification !== "undefined" && Notification !== null ? Notification.permission : void 0) === "denied") {
        return logger.warn("Permission for Notifications was denied");
      } else {
        logger.error("Unable to subscribe to push", error);
        return enableNotificationBtn();
      }
    });
  });
};

unsubscribe = function() {
  return navigator.serviceWorker.ready.then(function(serviceWorkerRegistration) {
    return serviceWorkerRegistration.pushManager.getSubscription().then(function(subscription) {
      if (subscription == null) {
        disablePush();
        enableNotificationBtn();
        return;
      }
      deleteSubscription(subscription);
      return subscription.unsubscribe().then(function() {
        console.log("Unsubscribed from notifications", subscription);
        disablePush();
        return enableNotificationBtn();
      })["catch"](function(error) {
        deleteSubscription(subscription);
        logger.error("Unable to unsubscribe", error);
        enableNotificationBtn();
        return disablePush(true);
      });
    })["catch"](logger.error.bind(window, "Unable to find subscription"));
  });
};

App = {
  isPushEnabled: false
};

$(function() {
  return $(".js-notifications-btn").on("click", function(event) {
    $(event.target).prop("disabled", true);
    if (App.isPushEnabled) {
      return unsubscribe();
    } else {
      return subscribe();
    }
  });
});

if ("serviceWorker" in navigator) {
  navigator.serviceWorker.register("/assets/plugins/service-worker.js").then(setupServiceWorker)["catch"](logger.error.bind(window, "Unable to register Service Worker"));
} else {
  logger.warn("Sorry, Service Workers are not supported by your browser. Try Chrome instead");
}

// ---
// generated by coffee-script 1.9.2