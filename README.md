##### Build
`docker build -t phpstrap .`

##### Dev
`docker run -p:80:80 -v /absolute/path//src/:/var/www/html/ phpstrap`

#####  Production
`docker run -p:80:80 phpstrap`

Access the site at localhost:80

Be sure to remove the .git folder 

