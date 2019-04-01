new Vue({
  el: "[data-hook=vue-body]",
  data: window.USER_FORM_DATA,
  methods: {
    onSubmit() {
      $.ajax({
        method: 'PATCH',
        url: this.form_url,
        data: $('#user-edit-form').serialize(),
        dataType: 'json',
        success: function(response) {
          // response
        },
        error: function(error) {
          // error.responseJSON
        }
      });
    }
  }
});
