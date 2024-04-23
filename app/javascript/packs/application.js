// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import jQuery from 'jquery';
window.$ = jQuery
window.jQuery = jQuery

import 'bootstrap/dist/js/bootstrap'
require("jgrowl")
Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', function() {
  var equallyCheckbox = document.getElementById('equallyCheckbox');
  var unequallyCheckbox = document.getElementById('unequallyCheckbox');
  var unequallyFields = document.querySelector('.unequally-fields');
  var equallyFields = document.querySelector('.equally-fields');
  const friendCheckboxes = document.querySelectorAll('.friend-checkbox');
  const amountInput = document.querySelector('#expense_amount'); // Assuming the ID of the amount field is 'expense_amount'
  const saveButton = document.getElementById('saveButton');
  saveButton.addEventListener('click', function(event) {
    if (unequallyCheckbox.checked) {
      calculateTotalAmount();
    }
  });

  friendCheckboxes.forEach(function(checkbox) {
    checkbox.addEventListener('change', function() {
      const friendId = this.value;
      const friendAmountInput = document.querySelector(`#friend_amount_input_${friendId}`);
      friendAmountInput.style.display = this.checked ? 'block' : 'none';
    });
  });

  equallyCheckbox.addEventListener('change', function() {
    if (this.checked) {
      unequallyCheckbox.checked = false;
      unequallyFields.style.display = 'none';
      equallyFields.style.display = 'block';
    }
  });

  unequallyCheckbox.addEventListener('change', function() {
    if (this.checked) {
      equallyCheckbox.checked = false;
      unequallyFields.style.display = 'block';
      equallyFields.style.display = 'none';
    }
  });

  function calculateTotalAmount() {
    let totalAmount = 0;
    friendCheckboxes.forEach(function(checkbox) {
      if (checkbox.checked) {
        const friendId = checkbox.value;
        const friendAmountInput = document.querySelector(`#friend_amount_input_${friendId} input`);
        if (friendAmountInput) {
          const amount = parseFloat(friendAmountInput.value) || 0;
          totalAmount += amount;
        }
      }
    });

    // Update the total amount display or perform any other action as needed
    // For example, you can compare totalAmount with the value of amountInput
    // and display a message or change the style based on the result
    if (totalAmount !== parseFloat(amountInput.value)) {
      alert('Total amount does not match the specified amount.');
        event.preventDefault();
    }
  }
});
