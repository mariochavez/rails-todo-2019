import consumer from "./consumer"
import CableReady from "cable_ready"

consumer.subscriptions.create("TodoChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.cableReady) CableReady.perform(data.operations)
  }
});
