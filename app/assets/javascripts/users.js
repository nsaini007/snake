App.users = App.cable.subscriptions.create("UsersChannel", {
    received: function (data) {
        var users = data.users;
        var listItems = "";

        for (var i = 0; i < users.length; i++) {
            listItems += "<li>" + users[i].email + "</li>";
        }

        $("ul").html(listItems);
    }
});
