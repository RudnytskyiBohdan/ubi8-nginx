#/bin/bash
  
  if ["$ssl_certificate"=""] && ["$ssl_certificate_key"=""] ; then
      exit
  else
      sed '/HTTPS server/,$ s/#//g; /HTTPS server/c # HTTPS server' /etc/nginx/nginx.conf
  fi       
  exit