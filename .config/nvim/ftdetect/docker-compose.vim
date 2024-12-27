" If the filename matches docker-compose.yml or docker-compose.yaml,
" set the filetype to yaml.docker-compose
augroup docker_compose_detection
  autocmd!
  autocmd BufRead,BufNewFile docker-compose.yml set filetype=yaml.docker-compose
  autocmd BufRead,BufNewFile docker-compose.yaml set filetype=yaml.docker-compose
augroup END
