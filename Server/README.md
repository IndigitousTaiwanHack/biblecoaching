**_`Bible Coaching server for rails development`_**

**Installation**

    install ruby version 2.2.3
    install rails version 5.0.0
    install mysql

**Setup Rails**
    
    cd to your project directory
    run "bundle install"
    set your database config in database.yml 
    run "rails secret" and copy value in secret.yml
    run "rails assets:precompile"
    run "rake db:create" to create database from database.yml 
    run "rake db:migrate" to crate table from db/migrate
    run rails s -p 3000 -e production to start server

**Setup Facebook api**

    create Facebook developer account and apply an app
    create file name "omniauth.rb" in config/initializers and set app id and app key
    set your website url in facebook api setting

**Setup Web server(nginx)**  
    
    setting nginx like following :  
     
    upstream "ip_address"{
       server 127.0.0.1:3000;
    }
    server {
        listen 80;
        server_name "server name";
        root /home/ubuntu/public_html/hackathon/public;    
        index index.html;
     
        location / {
                    # Set the following HTTP headers so we can keep track
                    # of the true requestor IP on the backend
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
                    # We're not doing any redirection with URIs returned 
                    # from the proxied servers
            proxy_redirect off;
            try_files  $uri $uri/index.html @ruby;
            
        }
        location @ruby {
             proxy_pass "ip_address";
        }
    }
    
**Setup to communicate with mobile**     
    
    cd to your project directory
    run "rails c" and run "ApiToken.create!" or you can create a random number record in your api_tokens table 
    copy the value to your mobile developer

    