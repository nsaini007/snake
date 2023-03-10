import consumer from "./consumer"

const gameChannel = consumer.subscriptions.create("GameChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to game channel");
  },
  
  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("Disconnected from game channel");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("message", data);
  },

  roll(player) {
    console.log(player);
    this.perform("roll_dice", { player: player })
  }

});

export default gameChannel;
