function swalalert(title,text,icon,obj)
{
    swal({
        title: title,
        text:text,
        icon: icon,
        button: {
            text: "OK",
            value: true
        },
    })
.then((value) => {
    obj.focus();
                    
});
return false;
}

function check(msg,at,url,attr) {
    id = at.getAttribute(attr);
    swal({
        title: msg,
        icon: "warning",

        buttons: true,
    })
      .then((value) => {
          if (value)
          window.location.href = url+"?id="+id;
});

}

