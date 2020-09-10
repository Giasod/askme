
require("@rails/ujs").start()

import 'bootstrap/dist/js/bootstrap'

import '../styles/application'

require("@rails/activestorage").start()
require("channels")

document.addEventListener("turbolinks:load", function () {
    $(function () {
        $('#ask-button').click(function () {
            $('#ask-form').slideToggle(300);
            return false;
        });
    });
})

const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
