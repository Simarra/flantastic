
delete_img_cache () {
    docker rmi $(docker images -f "dangling=true" -q)
}
compose_flantastic (){
    docker-compose -f docker-compose.yml up -d --build
}

delete_img_cache
compose_flantastic
delete_img_cache
df -h