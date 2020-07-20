# Absolute Risk Plumber Runner

This example runs the [plumber.io](https://www.rplumber.io/) package and loads an api for `absolute.risk`, `relative.risk`, `check.summary`, `risk.summary`.

## Steps

1. open `R` and run `install.packages("plumber")`
2. wait... the install took about 10 minutes
3. exit `R`
4. `cd web`
5. run `Rscript runner.R`
6. Open `http://localhost:8000/absolute.risk`
7. It will return response from shimmed absolute risk

## Docker
[heroku instructions](https://devcenter.heroku.com/articles/container-registry-and-runtime)
1. `make build`
2. `heroku container:login`  heroku login
3. `heroku create`  from dockerfile root level  
~ to add changes or version skip login and create steps ~
4. `heroku container:push web -a limitless-eyrie-26993`   needs version option here
5. `heroku container:release web -a limitless-eyrie-26993` 
6. `heroku open -a limitless-eyrie-26993`    
  
  
  `make run` to run locally docker desktop must be running  
  note: should throw error for missing params instead of defaults


## To Do

- [x] Add CORS and test over web
- [X] Make DockerFile
- [] Deploy DockerFile
- [] Set up HTTPS proxy
- [] CI Script

## Reverse Proxy for HTTPS

- [Nginx Docker Reverse Proxy](https://www.freecodecamp.org/news/docker-nginx-letsencrypt-easy-secure-reverse-proxy-40165ba3aee2/)

