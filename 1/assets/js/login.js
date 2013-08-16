// Generated by CoffeeScript 1.6.3
$(document).ready(function() {
  var Checker, dispaly_error_info, elm_alert, elm_err, hidden_error_info;
  Checker = (function() {
    function Checker() {
      this.error = '';
    }

    Checker.prototype.isError = function() {
      return !this.error.length === 0;
    };

    Checker.prototype.isEmail = function(eml) {
      if (!/^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/.test(eml)) {
        this.error = "Student Number Input Error";
      }
      return this;
    };

    Checker.prototype.isPassword = function(pwd) {
      if (pwd.length === 0) {
        this.error = "Password Not Empty";
      }
      return this;
    };

    return Checker;

  })();
  elm_alert = $("div#l_alert");
  elm_err = $(elm_alert.children('p').get(0));
  dispaly_error_info = function(err) {
    elm_alert.show();
    return elm_err.html(err);
  };
  hidden_error_info = function() {
    elm_alert.hide();
    return elm_err.html('');
  };
  return $("button#l_submit").click(function() {
    var u_email, u_pwd, _checker;
    hidden_error_info();
    u_email = $.trim($("#l_u_email").val());
    u_pwd = $.trim($("#l_u_pwd").val());
    _checker = new Checker();
    if (_checker.isEmail(u_email).isError() === true) {
      dispaly_error_info(_checker.error);
    } else {
      if (_checker.isPassword(u_pwd).isError() === true) {
        dispaly_error_info(_checker.error);
      } else {
        $.ajax({
          url: '/wlg-login',
          success: function(result) {
            console.log(eval('(' + result + ')'));
            result = eval('(' + result + ')');
            if (result.status === true) {
              window.location.href = '/wlg/setting';
            }
            dispaly_error_info(result.info);
          },
          async: true,
          type: 'POST',
          data: {
            'l_u_email': u_email,
            'l_u_pwd': md5(u_pwd)
          }
        });
      }
    }
    return true;
  });
});